// Regression test for convolve2D_unrolled().
//
// convolve2D_unrolled() fully unrolls the input channels, so for a while
// nothing in the generated expression referred to the *output* channel
// argument. Such a Func is channel-invariant, which is a problem when its
// only consumer uses it as a channel index (slice() does exactly that):
// once the conv gets inlined, the index expression - and with it every
// reference to the Funcs feeding that index - is constant-folded away.
// The orphaned producers are still in the environment and still get a
// realize/produce node from ScheduleFunctions, but BoundsInference derives
// bounds from consumers, so they end up with no bounds lets at all, and
// codegen dies on the undefined symbol.
//
// This test does two things, per pipeline seed:
//   1. Builds the pipeline and checks that every Func produced by
//      convolve2D_unrolled() actually depends on its output-channel Var.
//   2. Optionally autoschedules and compiles it all the way through LLVM
//      codegen, which is where the dangling-symbol failure surfaced.
//
// Driven by test_conv2d_unrolled.sh; see there for usage.

#include "random_pipeline_generator.cpp"

#include <map>
#include <string>
#include <vector>

using namespace Halide;
using Halide::Internal::Function;

namespace {

// convolve2D_unrolled() names its Func "conv2D_<arg0><arg1>". The two
// reduction-based variants use the "conv2D_r_" and "conv2D_w_" prefixes,
// and they already multiply by weights(..., args[2]).
bool is_unrolled_conv2d(const std::string &name) {
    if (!Internal::starts_with(name, "conv2D_")) return false;
    return !Internal::starts_with(name, "conv2D_r_") &&
           !Internal::starts_with(name, "conv2D_w_");
}

// Every Func reachable from the outputs of p.
std::map<std::string, Function> all_funcs(const Pipeline &p) {
    std::map<std::string, Function> env;
    for (const Func &f : p.outputs()) {
        env.emplace(f.name(), f.function());
        std::map<std::string, Function> callees =
            Internal::find_transitive_calls(f.function());
        env.insert(callees.begin(), callees.end());
    }
    return env;
}

// Does any of f's values mention the Var it is indexed by in dimension 2?
bool depends_on_output_channel(const Function &f) {
    const std::vector<std::string> &args = f.args();
    if (args.size() < 3) return true;  // not a 3d stage; nothing to check
    for (const Expr &v : f.values()) {
        if (Internal::expr_uses_var(v, args[2])) return true;
    }
    return false;
}

std::string arg_value(int argc, char **argv, int &i) {
    if (i + 1 >= argc) {
        std::cerr << "Missing value for " << argv[i] << "\n";
        exit(1);
    }
    return argv[++i];
}

}  // namespace

int run(int argc, char **argv) {
    int seed = 0;
    int max_stages = 20;
    std::string target_str = "host";
    std::string plugin, weights, out_prefix;

    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "--seed") {
            seed = std::stoi(arg_value(argc, argv, i));
        } else if (a == "--max-stages") {
            max_stages = std::stoi(arg_value(argc, argv, i));
        } else if (a == "--target") {
            target_str = arg_value(argc, argv, i);
        } else if (a == "--autoscheduler") {
            plugin = arg_value(argc, argv, i);
        } else if (a == "--weights") {
            weights = arg_value(argc, argv, i);
        } else if (a == "--out") {
            out_prefix = arg_value(argc, argv, i);
        } else {
            std::cerr << "Usage: " << argv[0]
                      << " [--seed N] [--max-stages N] [--target T]"
                      << " [--autoscheduler libautoschedule_adams2019.so]"
                      << " [--weights weights.pt] [--out prefix]\n";
            return 1;
        }
    }

    Target target(target_str);

    // The controlled RNG hands out one chunk of prescribed values per stage
    // and never rewinds, so reset the cursor before building a pipeline.
    rng.current_stage = -1;

    std::unique_ptr<RandomPipeline> gen =
        RandomPipeline::create(GeneratorContext(target));
    Internal::AbstractGenerator *ag = gen.get();
    ag->set_generatorparam_value("seed", std::to_string(seed));
    ag->set_generatorparam_value("max_stages", std::to_string(max_stages));
    if (!plugin.empty()) {
        // Also tells generate() to skip its own compute_root() calls.
        ag->set_generatorparam_value("autoscheduler", "Adams2019");
    }

    Pipeline p;
    try {
        p = ag->build_pipeline();
    } catch (const Halide::Error &e) {
        // The generator failed to even build this pipeline, which is a
        // different problem from the one under test. Report it, but let the
        // driver tell it apart from a real failure (exit code 2).
        std::cerr << "seed " << seed << ": pipeline construction failed: "
                  << e.what() << "\n";
        return 2;
    }

    // 1. The invariant: unrolled convs must vary with the output channel.
    int checked = 0, bad = 0;
    for (const auto &it : all_funcs(p)) {
        if (!is_unrolled_conv2d(it.first)) continue;
        checked++;
        if (!depends_on_output_channel(it.second)) {
            bad++;
            std::cerr << "FAIL [seed " << seed << "]: " << it.first
                      << " does not depend on its output channel ("
                      << it.second.args()[2] << "):\n  "
                      << it.second.values()[0] << "\n";
        }
    }
    std::cout << "seed " << seed << ": checked " << checked
              << " unrolled conv2D func(s), " << bad << " channel-invariant\n";
    if (bad) return 1;

    // 2. The pipeline must survive autoscheduling + codegen.
    if (!plugin.empty()) {
        load_plugin(plugin);
        AutoschedulerParams asp("Adams2019", {{"parallelism", "32"}});
        if (!weights.empty()) {
            asp.extra["weights_path"] = weights;
        }
        p.apply_autoscheduler(target, asp);

        if (out_prefix.empty()) out_prefix = "random_pipeline_test";
        p.compile_to_static_library(out_prefix, p.infer_arguments(),
                                    "random_pipeline",
                                    target.with_feature(Target::NoRuntime));
        std::cout << "seed " << seed << ": compiled ok\n";
    }

    return 0;
}

int main(int argc, char **argv) {
    // Halide reports both user and internal errors as exceptions here; let
    // them out as a readable message rather than a call to terminate.
    try {
        return run(argc, argv);
    } catch (const Halide::Error &e) {
        std::cerr << "Halide error: " << e.what() << "\n";
        return 1;
    }
}
