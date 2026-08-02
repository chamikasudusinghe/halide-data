#include "Halide.h"
#include <iostream>
#include <iomanip>
#include <random>
#include <cstdlib>
#include <unordered_map>
#include <queue>
#include <fstream>

using namespace Halide;
using namespace Halide::Internal;
using namespace std;
using std::vector;
using std::unordered_map;

// PATCH TO REPLACE RANDOM NUMBER GENERATION ################################

// Controlled RNG with per-stage chunk isolation.
//
// File format (written by Python):
//   <count_0> <val> <val> ...    ← chunk 0 (boundary)
//   <count_1> <val> <val> ...    ← chunk 1 (stage 0: i2, i1, stage_type, params...)
//   <count_2> <val> <val> ...    ← chunk 2 (stage 1: ...)
//   ...
//
// Call advance_stage() before each stage.  Any leftover values from the
// previous chunk are discarded, so a mismatch in one stage cannot cascade
// into the next.
struct ControlledRNG {
    std::vector<std::vector<uint32_t>> stage_chunks;
    int current_stage = -1;
    std::queue<uint32_t> prescribed;   // current chunk's values
    std::mt19937 fallback;
    bool log_enabled = false;
    int call_count = 0;
    std::ofstream log_file;

    void seed_fallback(uint32_t s) {
        fallback.seed(s);
    }

    void load_from_file(const std::string &path) {
        std::ifstream f(path);
        if (!f.is_open()) {
            std::cerr << "[ControlledRNG] WARNING: could not open "
                      << path << ", falling back to mt19937\n";
            return;
        }
        uint32_t count;
        while (f >> count) {
            stage_chunks.emplace_back();
            auto &chunk = stage_chunks.back();
            for (uint32_t i = 0; i < count; i++) {
                uint32_t v;
                if (!(f >> v)) break;
                chunk.push_back(v);
            }
        }
        std::cerr << "[ControlledRNG] Loaded " << stage_chunks.size()
                  << " chunks from " << path << "\n";

        // getting the log file ready as well
        const char *log_path = std::getenv("HL_RNG_LOG_FILE");
        if (log_path && log_path[0] != '\0') {
            log_file.open(log_path);
        }
    }

    void advance_stage() {
        // Discard any leftover values from the previous chunk
        std::queue<uint32_t> empty;
        std::swap(prescribed, empty);
        current_stage++;
        if (current_stage < (int)stage_chunks.size()) {
            for (auto v : stage_chunks[current_stage]) {
                prescribed.push(v);
            }
            if (log_file.is_open()) {
                log_file << "[STAGE " << current_stage << "] loaded "
                         << stage_chunks[current_stage].size()
                         << " prescribed values\n";
                log_file.flush();
            }
        }
    }

    uint32_t operator()() {
        uint32_t val;
        bool from_queue = false;
        if (!prescribed.empty()) {
            val = prescribed.front();
            prescribed.pop();
            from_queue = true;
        } else {
            val = fallback();
        }

        if (log_file.is_open()) {
            log_file << "[RNG call " << call_count << "] "
                     << val << " "
                     << (from_queue ? "(prescribed)" : "(fallback)") << "\n";
            log_file.flush();
        }
        ++call_count;
        return val;
    }

    // Satisfy the mt19937 interface used by rand_int / rand_bool
    using result_type = uint32_t;
    static constexpr uint32_t min() { return 0; }
    static constexpr uint32_t max() { return UINT32_MAX; }
};

ControlledRNG rng;

// Helper: initialise rng from GeneratorParam seed and optional file.
// Call this at the top of generate() instead of rng.seed(seed).
void init_rng(int seed_val) {
    rng.seed_fallback(seed_val);

    const char *choices_file = std::getenv("HL_RNG_CHOICES_FILE");
    if (choices_file && choices_file[0] != '\0') {
        rng.load_from_file(choices_file);
    }

    const char *log_flag = std::getenv("HL_RNG_LOG");
    rng.log_enabled = (log_flag && std::string(log_flag) == "1");
}
 


// END, PATCH TO REPLACE RANDOM NUMBER GENERATION ################################


// Convert a vector of Vars to Exprs. Useful for generating references
// to Funcs.
vector<Expr> make_arguments(vector<Var> vars) {
    vector<Expr> result;
    for (Var i : vars) {
        result.push_back(i);
    }
    return result;
}

//std::mt19937 rng;

// Helpers to generate random values.
int rand_int(int min, int max) { return (rng() % (max - min + 1)) + min; }
bool rand_bool() { return rng() % 2 == 0; }

// Generate random expressions. Given a vector of expresions and a
// tree depth, recursively generates an expression by combining
// subexpressions.  At the base case where depth is 0, we just return
// a randomly chosen input.
Type expr_types[] = {UInt(8), UInt(16), UInt(32), Int(8), Int(16), Int(32), Float(32)};
const int expr_type_count = sizeof(expr_types)/sizeof(expr_types[0]);

typedef Expr (*make_bin_op_fn)(Expr, Expr);

make_bin_op_fn make_bin_op[] = {
    (make_bin_op_fn)operator+,
    (make_bin_op_fn)operator-,
    (make_bin_op_fn)operator*,
    (make_bin_op_fn)min,
    (make_bin_op_fn)max,
    (make_bin_op_fn)operator/,
    (make_bin_op_fn)operator%,
};

make_bin_op_fn make_bool_bin_op[] = {
    (make_bin_op_fn)operator&&,
    (make_bin_op_fn)operator||,
};

make_bin_op_fn make_comp_bin_op[] = {
    (make_bin_op_fn)operator==,
    (make_bin_op_fn)operator!=,
    (make_bin_op_fn)operator<,
    (make_bin_op_fn)operator<=,
    (make_bin_op_fn)operator>,
    (make_bin_op_fn)operator>=
};

const int bin_op_count = sizeof(make_bin_op) / sizeof(make_bin_op[0]);
const int bool_bin_op_count = sizeof(make_bool_bin_op) / sizeof(make_bool_bin_op[0]);
const int comp_bin_op_count = sizeof(make_comp_bin_op) / sizeof(make_comp_bin_op[0]);

Type random_type() {
    auto expr_types_id = rng()%expr_type_count;
    Type T = expr_types[expr_types_id];
    return T;
}

Expr random_expr_inner(vector<Expr> inputs, int depth, int func_size);

Expr random_condition(vector<Expr> inputs, int depth, int func_size) {
    Expr a = random_expr_inner(inputs, depth, func_size);
    Expr b = random_expr_inner(inputs, depth, func_size);
    int op = rng() % comp_bin_op_count;
    return make_comp_bin_op[op](a, b);
}

// takes a vector of inputs (points in functions) and an expected Type
// if the chosen input is not of the given type, cast it to conform
Expr make_leaf(vector<Expr> inputs) {
    auto chosen_input = inputs[rand_int(0, inputs.size()-1)];
    return chosen_input;
}

Expr random_expr_inner(vector<Expr> inputs, int depth, int func_size) {
    const int op_count = bin_op_count + bool_bin_op_count + 4 + 5;

    if (depth <= 0) {
        return make_leaf(inputs);
    }

    // pick a random operation to combine exprs
    int op = rng() % op_count; // ops need to be defined
    switch(op) {
    case 0:  // casting
    {
        // Get a random type
        Type convertT = random_type();
        auto e1 = random_expr_inner(inputs, depth, func_size);
        return cast(convertT, e1);
    }
    case 1: // select operation
    {
        auto c = random_condition(inputs, depth-2, func_size); // arbitrarily chose to make condition expression shorter
        auto e1 = random_expr_inner(inputs, depth-1, func_size);
        auto e2 = random_expr_inner(inputs, depth-2, func_size);
        // make sure e1 and e2 have the same type
        if (e1.type() != e2.type()) {
            e2 = cast(e1.type(), e2);
        }
        return select(c, e1, e2);
    }
    case 2: // unary boolean op
    {
        auto e1 = random_expr_inner(inputs, depth-1, func_size);
        if (e1.type().is_bool()) {
            return !e1;
        }
        break;
    }
    case 3: // condition
    {
        return random_condition(inputs, depth-1, func_size);
    }
	case 4: // pow - exponentiation (common in CV)
    {
        auto base = random_expr_inner(inputs, depth-1, func_size);
        // Use small integer exponents (2 or 3)
        int exp_val = rand_int(2, 3);

		Expr base_f = cast<float>(base);
		Expr r = pow(base_f, (float)exp_val);
		return cast(base.type(), r);

		//Type t = base.type();
		//Expr r = pow(cast<float>(base), cast<float>(exp_val));
		//return cast(t, r);
        //return pow(cast<float>(base), cast<float>(exp_val));
    }
    
    case 5: // sqrt - square root (common in distance calculations)
    {
        auto e = random_expr_inner(inputs, depth-1, func_size);
        // Take abs first to avoid sqrt of negative numbers
		Type t = e.type();
		Expr r = sqrt(abs(cast<float>(e)));
		return cast(t, r);
        //return sqrt(abs(cast<float>(e)));
    }
    
    case 6: // abs - absolute value (common in edge detection)
    {
        auto e = random_expr_inner(inputs, depth-1, func_size);
		if (e.type().is_uint()) {
			return e;
		} else {
			return abs(e);
		}
    }
    
    case 7: // absd - absolute difference (common in stereo, motion)
    {
        auto e1 = random_expr_inner(inputs, depth-1, func_size);
        auto e2 = random_expr_inner(inputs, depth-2, func_size);
		if (e1.type() != e2.type()) {
			e2 = cast(e1.type(), e2);
		}

		if (e1.type().is_float()) {
			return abs(e1 - e2);
		} else {
			return absd(e1, e2);
		}
    }
    
    case 8: // lerp - linear interpolation (common in blending)
    {
        auto e1 = random_expr_inner(inputs, depth-1, func_size);
        auto e2 = random_expr_inner(inputs, depth-2, func_size);
        // Random weight between 0.25 and 0.75
        float weight = 0.25f + (rand_int(0, 2) * 0.25f);
		Expr w = cast<float>(weight);
		Expr r = lerp(cast<float>(e1), cast<float>(e2), w);
		return cast(e1.type(), r);
    }
    default: // binary op
        make_bin_op_fn maker;
        auto e1 = random_expr_inner(inputs, depth-1, func_size);
        auto e2 = random_expr_inner(inputs, depth-2, func_size);
        if (e1.type().is_bool() && e2.type().is_bool()) {
            maker = make_bool_bin_op[op % bool_bin_op_count];
        } else {
			if(e1.type().is_float() || e2.type().is_float()) {
				if(op % bin_op_count == 6) {
					int new_op = 5;
					maker = make_bin_op[new_op];
				} else{

					maker = make_bin_op[op % bin_op_count];
				}
			}else{

				maker = make_bin_op[op % bin_op_count];
			}
        }

        return maker(e1, e2);
    }

    // selected case did not return an expression, try again
    return random_expr_inner(inputs, depth, func_size);
}

Expr rand_value(Type t) {
    if (t.is_bool()) {
        return cast(t, rand_int(0,1));
    } else if (t.is_int() || t.is_uint()) {
        return cast(t, rand_int(1, 127));
    } else if (t.is_float()) {
        //assert(false);
        //return undef(t);
		float v = (float)rand_int(0, 100) / 10.0f;
		return cast(t, v);
    } else {
        // Shouldn't get here.
        assert(false);
        return undef(t);
    }
}

Expr random_expr(vector<Expr> inputs, int depth, int func_size) {
    for (auto &e : inputs) {
        e = Internal::simplify(e);
    }

    for (int attempts = 0; attempts < 1; attempts++) {
        Expr result =
            Internal::simplify(Internal::common_subexpression_elimination(random_expr_inner(inputs, depth, func_size)));

        class Checker : public Internal::IRMutator {
        public:
            Expr mutate(const Expr &e) override {
                exprs_to_find.erase(e);
                return IRMutator::mutate(e);
            }
            using Internal::IRMutator::mutate;
            std::set<Expr, Internal::IRDeepCompare> exprs_to_find;
            Checker(const vector<Expr> &inputs) {
                for (const auto &e : inputs) {
                    exprs_to_find.insert(e);
                }
            }
        } checker(inputs);

        checker.mutate(result);

        // Double check all the inputs are used
        if (!checker.exprs_to_find.empty()) {
            std::cerr << "In random expression: " << result << "\n"
                      << "The following expressions were unused:\n";
            for (auto &e : checker.exprs_to_find) {
                std::cerr << e << "\n";
            }
        } else {
            return result;
        }
    }

    // We're having a hard time generating an expression that uses all the inputs. Just sum them.
    Type t = inputs[0].type();
    if (t.is_bool()) {
        t = UInt(8);
    }
    Expr result = cast(t, 0);
    for (const auto &e : inputs) {
        result += e;
    }
    return result;
}

// Generator to produce a random pipeline. The generated pipeline will
// be solely a function of the seed and the number of stages.
class RandomPipeline : public Halide::Generator<RandomPipeline> {
public:
    int num_stage_types = 18;
    // The random seed to use to generate the pipeline.
    GeneratorParam<int> seed{"seed", 1};
    // The approximate max number of stages to generate in the random pipeline.
    GeneratorParam<int> max_stages{"max_stages", 20};
    Input<Buffer<int32_t>>  input{"input", 3};
    Input<Buffer<uint8_t>>  uint8_weights {"uint8_weights", 4};
    Input<Buffer<uint16_t>>  uint16_weights{"uint16_weights", 4};
    Input<Buffer<uint32_t>>  uint32_weights{"uint32_weights", 4};
    Input<Buffer<int8_t>>  int8_weights {"int8_weights", 4};
    Input<Buffer<int16_t>>  int16_weights{"int16_weights", 4};
    Input<Buffer<int32_t>>  int32_weights{"int32_weights", 4};
	Input<Buffer<float>> float32_weights{"float32_weights", 4};
    Output<Buffer<int32_t>> output{"output", 3};

    Func uint8_weights_bounded {"uint8_weights_bounded"};
    Func uint16_weights_bounded{"uint16_weights_bounded"};
    Func uint32_weights_bounded{"uint32_weights_bounded"};
    Func int8_weights_bounded  {"int8_weights_bounded"};
    Func int16_weights_bounded {"int16_weights_bounded"};
    Func int32_weights_bounded {"int32_weights_bounded"};
	Func float32_weights_bounded {"float32_weights_bounded"};

    void set_upcast_types(Type input_type, Type& mult_type, Type& sum_type) {
        if (input_type.is_bool()) {
            mult_type = UInt(8);
            sum_type = UInt(8);
        } else if (!input_type.is_float() && rand_int(0,1)) {
            int input_bits = input_type.bits();
            int mult_bits = std::min(32, 2*input_bits);
            int sum_bits = std::min(32, 2*mult_bits);
            mult_type = input_type.with_bits(mult_bits);
            sum_type = input_type.with_bits(sum_bits);
        } else {
            mult_type = input_type;
            sum_type = input_type;
        }
        return;
    }
    Expr div_expr(Expr num, Expr den) {
        int bits = std::max(num.type().bits(), den.type().bits());
        if (bits < 32)
            return num / den;
        Expr num_down = cast(num.type().with_bits(16), num);
        Expr den_down = cast(den.type().with_bits(16), den);
        return num_down/den_down;
    }
    void set_downcast_type(Type input_type, Type& output_type) {
        if (input_type.is_int() && rand_int(0,1)) {
            int input_bits = input_type.bits();
            int factor = rand_int(1, 2) * 2;
            int output_bits = std::max(8, input_bits/factor);
            output_type = Int(output_bits);
        } else {
            output_type = input_type;
        }
        return;
    }

    Func get_conv_weights(Type t) {
        if (t == UInt(8) || t == Bool()) return uint8_weights_bounded;
        else if (t == UInt(16)) return uint16_weights_bounded;
        else if (t == UInt(32)) return uint32_weights_bounded;
        else if (t == Int(8)) return int8_weights_bounded;
        else if (t == Int(16)) return int16_weights_bounded;
        else if (t == Int(32)) return int32_weights_bounded;
		else if (t == Float(32)) return float32_weights_bounded;
        else {
	        assert(false);
        }
    }

	
	// BHsketch
	// Helper: average two expressions
	//Expr avg(Expr a, Expr b) {
		//Type wider = a.type().with_bits(a.type().bits() * 2);
		//return cast(a.type(), (cast(wider, a) + b + 1) / 2);
	//}

	//// Alternative simpler version for float:
	//Expr avg_float(Expr a, Expr b) {
		//return (cast<float>(a) + cast<float>(b)) / 2.0f;
	//}

    struct Stage {
        Func func;

        // approx width and height and channels. Used to preserve
        // spatial scale when combining stages, and to track the total
        // sizes of things.
        int w, h, c;

        static constexpr int max_size = 100000000;
        static constexpr int min_size = 100;
        static constexpr int max_stride = 3; // for convs and pools

        int size() const {
            return w*h*c;
        }

        bool may_increase_size() const {
            return size() < max_size && w <= 8000 && h <= 8000 && c <= 512;
        }

        bool may_reduce_size() const {
            return size() > min_size;
        }

        int random_size_increase_factor() const {
            int sz = size();
            int max_factor = (max_size + sz - 1) / sz;
            if (max_factor <= 1) return 1;
            int log_max_factor = std::ceil(std::log(max_factor) / std::log(2));
            int factor = 1 << rand_int(std::max(1, log_max_factor - 3), log_max_factor);
            return factor;
        }

        int random_size_reduce_factor() const {
            int sz = size();
            int max_factor = (sz + min_size - 1) / min_size;
            if (max_factor <= 1) return 1;
            return std::min(8, 1 << rand_int(1, std::ceil(std::log(max_factor) / std::log(2))));
        }

        int random_out_channels() const {
            int min = (min_size + w * h - 1) / (w * h);
            int max = std::min(512, max_size / (w * h));
            if (min >= max) return min;
            return rand_int(min, max);
        }
    };

    // Generate a random convolution of one dimension of f, statically unrolled.
    Stage convolve(Stage f, int dim, int kernel_min, int kernel_max) {
        std::cout << "Convolving dimension " << dim
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]\n";

        vector<Var> args = f.func.args();

        // generate random expression using potentially all values in the stencil
		// Essentially this is generating a Stage (which is basically a function) of the kind:
		// Convolve(x, y, z) = input(x, y+kernel_min, z) + input(x, y+(kernel_min+1), z) + ... + input(x, y+(kernel_max), z)
		// where each "+" could be any operation.
		// args gives a list with names for each dimension of the input (i.e. x, y, z etc.)
		// Convolving in a particular dimension just means we're taking a linear combination of the inputs in that dimension
		// "statically unrolled" just means we're generating each "input(x, y+k, z)" term individualy, instead of just using 
		// some sort of RDom to do the same.
        vector<Expr> inputs;
        for (int i = kernel_min; i <= kernel_max; i++) {
            vector<Expr> coords = make_arguments(f.func.args());
            coords[dim] += i;
            inputs.push_back(f.func(coords));
        }
        int min_depth = std::floor(std::log(kernel_max - kernel_min + 1));
        int max_depth = min_depth + 1;
        Expr def = random_expr(inputs, rand_int(min_depth, max_depth), f.size());
        std::cerr << def << "\n";

        Func conv("conv_" + args[dim].name());
        conv(args) = def;

        return {conv, f.w, f.h, f.c};
    }

    // Generate a random convolution of one dimension of f using a reduction.
    Stage convolve_r(Stage f, int dim, int kernel_min, int kernel_max) {
        std::cout << "Convolving dimension " << dim
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]"
                  << " using +=\n";

        vector<Var> args = f.func.args();

        Func conv("conv_r_" + args[dim].name());
        RDom r(kernel_min, kernel_max - kernel_min + 1);
        vector<Expr> coords = make_arguments(f.func.args());
        coords[dim] += r;
        conv(args) += rand_value(f.func.value().type()) * f.func(coords);

        return {conv, f.w, f.h, f.c};
    }

    // Generate a random convolution of one dimension of f using a reduction with a wrapper
    Stage convolve_w(Stage f, int dim, int kernel_min, int kernel_max) {
        std::cout << "Convolving dimension " << dim
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]"
                  << " using sum() helper\n";

        vector<Var> args = f.func.args();

        Func conv("conv_w_" + args[dim].name());
        RDom r(kernel_min, kernel_max - kernel_min + 1);
        vector<Expr> coords = make_arguments(f.func.args());
        coords[dim] += r;
        conv(args) = sum(rand_value(f.func.value().type()) * f.func(coords));

        return {conv, f.w, f.h, f.c};
    }

    // Generate a padding layer (a zero boundary condition)
    Stage padding(Stage f) {
        std::cout << "Padding\n";
        Halide::Region bounds(3); // assuming all stages have 3 dims
        bounds.at(0).min = 0;
        bounds.at(0).extent = f.w;
        bounds.at(1).min = 0;
        bounds.at(1).extent = f.h;
        bounds.at(2).min = 0;
        bounds.at(2).extent = f.c;
        Expr zero = cast(f.func.value().type(), 0);
        return {BoundaryConditions::constant_exterior(f.func, zero, bounds), f.w, f.h, f.c};
    }

    Stage convolve2D(Stage f, int kernel_min, int kernel_max) {
		std::cout << "convolve2D with kernel_min=" << kernel_min << " kernel_max="<< kernel_max<<"\n";
        int conv_type = rand_int(0,2);
        if (conv_type == 0) return convolve2D_unrolled(f, kernel_min, kernel_max);
        if (conv_type == 1) return convolve2D_w(f, kernel_min, kernel_max);
        else return convolve2D_r(f, kernel_min, kernel_max);
    }

    Stage pool2D(Stage f, int kernel_min, int kernel_max) {
		std::cout<<"created pool2D\n";
        int pool_type = rand_int(0,2);
        if (pool_type == 0) return pool2D_unrolled(f, kernel_min, kernel_max);
        if (pool_type == 1) return pool2D_w(f, kernel_min, kernel_max);
        else return pool2D_r(f, kernel_min, kernel_max);
    }

    Stage activation(Stage f) {
		std::cout<<"created activation\n";
        return relu_layer(f);
    }

    Stage relu_layer(Stage f) {
        std::cout << "Created Relu\n";
        Func activation("relu");
        // if input type is int, downcast with 50% chance
        Type input_type = f.func.value().type();
        Type output_type;
        set_downcast_type(input_type, output_type);

        vector<Expr> coords = make_arguments(f.func.args());
        activation(f.func.args()) = max(cast(output_type, 0), cast(output_type,f.func(coords)));
        return {activation, f.w, f.h, f.c};
    }
    Stage pool2D_unrolled(Stage f, int kernel_min, int kernel_max) {
		std::cout <<"Created pool2D_unrolled with kmin=" << kernel_min << ", kmax=" << kernel_max << "\n";
        vector<Var> args = f.func.args();
        Func pooled2D("pooled2D" + args[0].name() + args[1].name());
        int stride = f.random_size_reduce_factor();

        int extent = kernel_max - kernel_min + 1;
        int scale = extent * extent;

        if (stride > extent) {
            stride = 1;
        }

        std::cout << "Pooling unrolled with stride: " << stride
                  << " and kernel [ " << kernel_min
                  << ", " << kernel_max << "]\n";

        Expr def = cast(f.func.value().type(), 0);

        // Avoid huge unrolled loops
        if (extent >= 4) return pool2D_r(f, kernel_min, kernel_max);

        // assuming input is 3d: w, h, c
        for (int i = kernel_min; i <= kernel_max; i++) {
            for (int j = kernel_min; j <= kernel_max; j++) {
                vector<Expr> pooled_coords = make_arguments(f.func.args());
                pooled_coords[0] = pooled_coords[0] * stride + i;
                pooled_coords[1] = pooled_coords[1] * stride + j;
                if (def.type().is_bool()) {
                    def = def && f.func(pooled_coords);
                } else {
                    def = def + f.func(pooled_coords);
                }
            }
        }
        // Can create 64bit values on hexagon if def is 32 bits.
        if (!def.type().is_bool()) {
            def = div_expr(def, scale);
        }

        pooled2D(args) = def;

        return {pooled2D, (f.w + stride - 1) / stride, (f.h + stride - 1) / stride, f.c};
    }

    Stage pool2D_r(Stage f, int kernel_min, int kernel_max) {
		std::cout <<"Created pool2D_r with kmin=" << kernel_min << ", kmax=" << kernel_max << "\n";
        vector<Var> args = f.func.args();
        Func pooled2D_r("pool2D_r_" + args[0].name() + args[1].name());
        int stride = f.random_size_reduce_factor();
        int extent = kernel_max - kernel_min + 1;
        int scale = extent * extent;

        if (stride > extent) {
            stride = 1;
        }

        std::cout << "Pooling using += with stride: " << stride << " and kernel [ " << kernel_min
          << ", " << kernel_max << "]\n";

        RDom r(kernel_min, extent,
               kernel_min, extent);

        vector<Expr> coords = make_arguments(f.func.args());
        Type ty = f.func.value().type();
        coords[0] = coords[0] * stride + r.x;
        coords[1] = coords[1] * stride + r.y;
        if (ty.is_bool()) {
            pooled2D_r(args) = const_true();
            pooled2D_r(args) = pooled2D_r(args) && f.func(coords);
        } else {
            pooled2D_r(args) += div_expr(f.func(coords), scale);
        }

        return {pooled2D_r, (f.w + stride - 1) / stride, (f.h + stride - 1) / stride, f.c};
    }

    Stage pool2D_w(Stage f, int kernel_min, int kernel_max) {
		std::cout <<"Created pool2D_w with kmin=" << kernel_min << ", kmax=" << kernel_max << "\n";
        vector<Var> args = f.func.args();
        Func pooled2D_w("pooled2D_w_" + args[0].name() + args[1].name());
        int stride = f.random_size_reduce_factor();
        int extent = kernel_max - kernel_min + 1;
        int scale = extent * extent;

        if (stride > extent) {
            stride = 1;
        }

        std::cout << "Pooling using sum() with stride: " << stride << " and kernel [ " << kernel_min
          << ", " << kernel_max << "]\n";

        RDom r(kernel_min, extent,
               kernel_min, extent);

        vector<Expr> coords = make_arguments(f.func.args());
        coords[0] = (coords[0] * stride + r.x);
        coords[1] = (coords[1] * stride + r.y);

        pooled2D_w(args) = div_expr(sum(cast(f.func.value().type(), f.func(coords))), scale);

        return {pooled2D_w, (f.w + stride - 1) / stride, (f.h + stride - 1) / stride, f.c};
    }

    // Convolution in the deep learning sense of the word.
    Stage convolve2D_unrolled(Stage f, int kernel_min, int kernel_max) {
        std::cout << "Convolving 2D dimension 1: " << 0
                  << " dimension 2: " << 1
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]\n";

        vector<Var> args = f.func.args();
        // Avoid huge unrolled loops
        if (f.c >= 4) return convolve2D_r(f, kernel_min, kernel_max);

        // The input channels are fully unrolled, so nothing below refers to
        // args[2]. Weight every tap by weights(..., args[2]) - the same trick
        // the reduction-based variants use - so that the result actually
        // varies with the output channel. Without this the Func is
        // channel-invariant, and any consumer that only uses it as a channel
        // index (see slice()) gets constant-folded away during inlining,
        // leaving a scheduled Func with no consumers and hence no bounds.
        Type input_type = f.func.value().type();
        Func weights = get_conv_weights(input_type);

        vector<Expr> inputs;
        for (int c = 0; c < f.c; c++)  {
            for (int i = kernel_min; i <= kernel_max; i++) {
                for (int j = kernel_min; j <= kernel_max; j++) {
                    vector<Expr> coords = make_arguments(f.func.args());
                    coords[0] += i;
                    coords[1] += j;
                    coords[2] = c;
                    Expr w = weights(c, i, j, args[2]);
                    Expr tap = f.func(coords);
                    // bool taps can't be multiplied; promote them to the
                    // weight type (uint8) first.
                    if (tap.type().is_bool()) {
                        tap = cast(w.type(), tap);
                    }
                    inputs.push_back(cast(tap.type(), w * tap));
                }
            }
        }

        int out_channels = f.random_out_channels();
        int kernel_width = kernel_max - kernel_min + 1;
        int min_depth = std::floor(std::log(kernel_width * kernel_width * f.c));
        int max_depth = min_depth + 1;
        int func_size = f.w * f.h * out_channels;

        Expr def = random_expr(inputs, rand_int(min_depth, max_depth), func_size);
        std::cerr << def << "\n";

        Func conv("conv2D_" + args[0].name() + args[1].name());
        conv(args) = def;

        return {conv, f.w, f.h, out_channels};
    }

    // Generate a random convolution of one dimension of f using a reduction.
    Stage convolve2D_r(Stage f, int kernel_min, int kernel_max) {
        std::cout << "Convolving 2D dimension 1: " << 0
                  << " dimension 2: " << 1
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]"
                  << " using +=\n";

        vector<Var> args = f.func.args();
        Func conv("conv2D_r_" + args[0].name() + args[1].name());
        // if input type is int, upcast with 50% chance
        Type mult_type, sum_type;
        Type input_type = f.func.value().type();
        Func weights = get_conv_weights(input_type);
        set_upcast_types(input_type, mult_type, sum_type);

        int stride = f.random_size_reduce_factor();
        int extent = kernel_max - kernel_min + 1;
        if (stride > extent) {
            stride = 1;
        }

        RDom r(kernel_min, extent,
               kernel_min, extent,
               0, f.c);

        vector<Expr> coords = make_arguments(f.func.args());
        coords[0] = coords[0] * stride + r.x; // only stride in w and h
        coords[1] = coords[1] * stride + r.y;
        coords[2] = r.z;
        conv(args) += cast(sum_type, cast(mult_type, weights(r.z, r.x, r.y, args[2]) * f.func(coords)));

        Stage out {conv, f.w, f.h, f.random_out_channels()};
        out.w = (out.w + stride - 1)/stride;
        out.h = (out.h + stride - 1)/stride;
        return out;
    }

    // Generate a random convolution of one dimension of f using a reduction with a wrapper
    Stage convolve2D_w(Stage f, int kernel_min, int kernel_max) {
        std::cout << "Convolving 2D dimension 1: " << 0
                  << " dimension 2: " << 1
                  << " with kernel [" << kernel_min << ", " << kernel_max << "]"
                  << " using sum() helper\n";

        vector<Var> args = f.func.args();
        Func conv("conv2D_w_" + args[0].name() + args[1].name());
        // if input type is int, upcast with 50% chance
        Type mult_type, sum_type;
        Type input_type = f.func.value().type();
        Func weights = get_conv_weights(input_type);
        set_upcast_types(input_type, mult_type, sum_type);

        int stride = f.random_size_reduce_factor();
        int extent = kernel_max - kernel_min + 1;

        if (stride > extent) {
            stride = 1;
        }

        RDom r(kernel_min, extent,
               kernel_min, extent,
               0, f.c);
        vector<Expr> coords = make_arguments(f.func.args());
        coords[0] = coords[0] * stride + r.x;
        coords[1] = coords[1] * stride + r.y;
        coords[2] = r.z;
        // sum() captures free vars in the order found, and the new
        // autoscheduler isn't clever enough to do storage reordering
        // yet, so make sure to put the term that depends on the
        // output channel last.
        conv(args) = sum(cast(sum_type, cast(mult_type, weights(r.z, r.x, r.y, args[2]) * f.func(coords))));

        // choose a channel output size - 0.5 prob of doubling channel dim
        Stage out {conv, f.w, f.h, f.random_out_channels()};
        out.w = (out.w + stride -1)/stride;
        out.h = (out.h + stride -1)/stride;
        return out;
    }

    // Generate an upsampling or downsampling of dimension dim by factor.
    Stage upsample(Stage f, int dim, int factor = 0) {
        std::cout << "Upsampling dimension " << dim << " by " << factor << "x\n";

        if (factor == 0) factor = f.random_size_increase_factor();

        Func resampled;

        if (rand_bool()) {
            // Nearest neighbour
            resampled = Func("upsampled_nn_" + f.func.args()[dim].name());
            vector<Expr> resampled_coords = make_arguments(f.func.args());
            resampled_coords[dim] = resampled_coords[dim] / factor;
            resampled(f.func.args()) = f.func(resampled_coords);
        } else {
            // Linear interpolation
            resampled = Func("upsampled_linear_" + f.func.args()[dim].name());
            vector<Expr> resampled_coords = make_arguments(f.func.args());
            Expr x = resampled_coords[dim];
            resampled_coords[dim] = x / factor;
            Expr s1 = f.func(resampled_coords);
            resampled_coords[dim] += 1;
            Expr s2 = f.func(resampled_coords);
            x = x % factor;

            Type mult_type, sum_type;
            Type input_type = f.func.value().type();
            set_upcast_types(input_type, mult_type, sum_type);
            s1 = cast(sum_type, s1);
            s2 = cast(sum_type, s2);

            resampled(f.func.args()) = cast(input_type, div_expr((factor - x) * s1 + x * s2, 2*factor));
        }

        Stage s {resampled, f.w, f.h, f.c};
        if (dim == 0) {
            s.w *= factor;
        } else if (dim == 1) {
            s.h *= factor;
        } else {
            assert(false);
        }
        return s;
    }

    Stage downsample(Stage f, int dim, int factor = 0) {
        std::cout << "Downsampling dimension " << dim << " by " << factor << "x\n";

        if (factor == 0) factor = f.random_size_reduce_factor();

        Func resampled;
        if (rand_bool()) {
            // Nearest neighbour
            resampled = Func("downsampled_nn_" + f.func.args()[dim].name());
            vector<Expr> resampled_coords = make_arguments(f.func.args());
            resampled_coords[dim] = resampled_coords[dim] * factor;
            resampled(f.func.args()) = f.func(resampled_coords);
        } else {
            // Averaging down
            resampled = Func("downsampled_box_" + f.func.args()[dim].name());
            vector<Expr> resampled_coords = make_arguments(f.func.args());
            resampled_coords[dim] = resampled_coords[dim] * factor;
            Expr e = cast(f.func.value().type(), 0);
            for (int i = 0; i < factor; i++) {
                resampled_coords[dim] += 1;
                e += f.func(resampled_coords);
            }
            resampled(f.func.args()) = e;
        }

        Stage s {resampled, f.w, f.h, f.c};
        if (dim == 0) {
            s.w = (s.w + factor - 1)/factor;
        } else if (dim == 1) {
            s.h = (s.h + factor - 1)/factor;
        } else {
            assert(false);
        }
        return s;
    }

    // A random pointwise combination of two stages.
    Stage binary_op(Stage f, Stage g) {
        std::cout << "Binary op\n";
        // They are first resized to match scales.
        if (f.w != g.w || f.h != g.h || f.c != g.c) {
            if (f.size() < g.size()) {
                f = resample_to(f, g.w, g.h, g.c);
            } else {
                g = resample_to(g, f.w, f.h, f.c);
            }
        }

        Func binary("binary_op");

        vector<Expr> inputs = {f.func(f.func.args()), g.func(f.func.args())};
        int min_depth = 1;
        int max_depth = 3;
        int func_size = f.w * f.h * std::min(f.c, g.c);
        Expr def = random_expr(inputs, rand_int(min_depth, max_depth), func_size);
        std::cerr << def << "\n";
		std::cout <<"generating binary op: "<< def <<"\n"; 
        binary(f.func.args()) = def;
        return {binary, f.w, f.h, std::min(f.c, g.c)};
    }
    // Generate an all-to-all communication in dimension dim,
    // statically unrolled. Currently only every applied over the
    // channels dimension.
    Stage all_to_all(Stage f, int dim) {
        std::cout << "All to all on dimension " << dim << '\n';

        if (f.c > 16) return all_to_all_r(f, dim);

        vector<Expr> reduction_coords = make_arguments(f.func.args());
        Expr e = 0;
        for (int i = 0; i < f.c; i++) {
            reduction_coords[dim] = i;
            e += f.func(reduction_coords) * ((i + 1) * f.c + (f.func.args()[dim] + 1));
        }

        Func all("all");
        all(f.func.args()) = e;

        return {all, f.w, f.h, f.random_out_channels()};
    }

    // Generate an all-to-all communication in dimension dim using an RDom
    Stage all_to_all_r(Stage f, int dim) {
        std::cout << "All to all on dimension " << dim << " using += \n";

        vector<Expr> reduction_coords = make_arguments(f.func.args());
        RDom r(0, f.c);
        reduction_coords[dim] = r;
        Func all("all_r");
        all(f.func.args()) += f.func(reduction_coords) * ((r + 1) * f.c + (f.func.args()[dim] + 1));

        return {all, f.w, f.h, f.random_out_channels()};
    }

    // Generate an all-to-all communication in dimension dim using an RDom with wrapper func
    Stage all_to_all_w(Stage f, int dim) {
        std::cout << "All to all on dimension " << dim << " using += \n";

        vector<Expr> reduction_coords = make_arguments(f.func.args());
        RDom r(0, f.c);
        reduction_coords[dim] = r;
        Func all("all_w");
        all(f.func.args()) = sum(f.func(reduction_coords) * ((r + 1) * f.c + (f.func.args()[dim] + 1)));

        return {all, f.w, f.h, f.random_out_channels()};
    }

    // Generate a forwards-then-backwards scan along a dimension
    Stage scan(Stage f, int dim) {
        std::cout << "Scan on dimension " << dim << '\n';
        int extent = dim == 0 ? f.w : dim == 1 ? f.h : 3;
        RDom r(1, extent - 1);
        Func scan("scan_" + f.func.args()[dim].name());
        vector<Expr> coords = make_arguments(f.func.args());
        scan(coords) = f.func(coords);
        coords[dim] = r;
        vector<Expr> prev_coords = coords;
        prev_coords[dim] = r-1;
        scan(coords) += scan(prev_coords);
        // Now in reverse
        coords[dim] = extent - r - 1;
        prev_coords[dim] = extent - r;
        scan(coords) += scan(prev_coords);
        return {scan, f.w, f.h, f.c};
    }

    // Do a data-dependent looking into one stage using another as the
    // index.
    Stage slice(Stage f, Stage g) {
        std::cout << "Created Slice\n";
        if (f.c > g.c) {
            std::swap(f, g);
        }

        // Index g's channels using f

        f = resample_to(f, g.w, g.h, 1);

        Func sliced("sliced");
        vector<Expr> coords = make_arguments(f.func.args());
        coords.back() = clamp(cast<int32_t>(f.func(f.func.args())), 0, g.c - 1);
        sliced(f.func.args()) = g.func(coords);

        return {sliced, f.w, f.h, f.c};
    }

    // Construct a tiled histogram of regions of a stage.
    Stage tiled_histogram(Stage f) {
        std::cout << " Created Tiled histogram\n";

        int old_c = f.c;
        f = resample_to(f, f.w, f.h, 1);

        int box_size = 1 << rand_int(1, 3);
        int histogram_buckets = box_size * box_size * old_c;

        RDom r(0, box_size, 0, box_size);
        vector<Expr> from_coords = make_arguments(f.func.args());
        vector<Expr> to_coords = from_coords;

        Func hist("hist");
        hist(f.func.args()) = cast<int32_t>(0);

		// from_coords defines a (box_size x box_size) shaped tile 
        from_coords[0] = to_coords[0] * box_size + r.x;
        from_coords[1] = to_coords[1] * box_size + r.y;
        from_coords[2] = 0;
		// assuming f.func(x, y, z) will be normalized (i.e. between 0 and 1), the multiplication
		// will be between 0 and histogram_buckets; cast into i32_t will truncate it; thus giving
		// us a bucket index between 0 and (histogram_buckets - 1).
        to_coords[2] = clamp(cast<int32_t>(f.func(from_coords) * histogram_buckets), 0, histogram_buckets - 1);
		// to_cords == (x, y, z), where (x, y) is the TILE number, 
		// and z is the bucket index.
		// Through the RDom, we get a bucket index for all elements within a tile, and we update the appropriate
		// (x, y, bucket_index) in hist. So it's a per-tile histogram.
        hist(to_coords) += 1;

        return {hist, f.w / box_size, f.h / box_size, histogram_buckets};
    }

    // Resample a stage to a different size.
    Stage resample_to(Stage f, int w, int h, int c) {
        std::cout << "Resampling from " << f.w << ", " << f.h << ", " << f.c << " to " << w << ", " << h << ", " << c << "\n";
        Stage out = f;
        // First decrease any sizes that need decreasing
        if (out.w > w) {
            int factor = (out.w + w/2) / w;
            if (factor != 1) {
                out = downsample(out, 0, factor);
            }
        }
        if (out.h > h) {
            int factor = (out.h + h/2) / h;
            if (factor != 1) {
                out = downsample(out, 1, (out.h + h/2) / h);
            }
        }
        // Adapt channel count with an all-to-all
        if (out.c != c) {
            out = all_to_all_r(out, 2);
            out.c = c;
        }
        // Increase any sizes that need increasing
        if (out.w < w) {
            int factor = (w + out.w/2) / out.w;
            if (factor != 1) {
                out = upsample(out, 0, factor);
            }
        }
        if (out.h < h) {
            int factor = (h + out.h/2) / out.h;
            if (factor != 1) {
                out = upsample(out, 1, factor);
            }
        }
        std::cout << "Resulting size: " << out.w << ", " << out.h << ", " << out.c << "\n";
        return out;
    }

    Stage cast_stage(Type t, Stage f) {
		std::cout << "Creating cast stage\n";
        Func casted("casted");
        casted(f.func.args()) = cast(t, f.func(f.func.args()));
        return {casted, f.w, f.h, f.c};
    }

	// Aggregation stage: reduces data using random expressions
	Stage aggregation_stage(Stage f, int func_size) {
		std::cout << "Creating aggregation stage from " << f.w << "×" << f.h << "×" << f.c << "\n";
		
		std::vector<Expr> coords = make_arguments(f.func.args());
		std::vector<Expr> agg_coords = coords;
		//Func f_bounded = BoundaryConditions::repeat_edge(f.func);
		Func result("aggregation");
		// Choose which dimension to aggregate over (0=x, 1=y, 2=c)
		int reduce_dim = rand_int(0, 2);
		// Choose whether to use simple aggregation (depth=0) or complex (depth=1)
		int expr_depth = rand_int(0, 1);

		auto dim_extent = [&](int d) { return d == 0 ? f.w : d == 1 ? f.h : f.c; };

		// A dimension of extent 1 clamps the reduction coordinate to a single
		// point, so simplify() folds the RVar away and sum()/argmin()/argmax()
		// reject the expression ("must reference a reduction domain"). Reduce
		// over the largest dimension instead. Note that rand_int() consumes one
		// value however wide its range is, so this doesn't shift the RNG stream.
		if (dim_extent(reduce_dim) < 2) {
			int largest = 0;
			for (int d = 1; d < 3; d++) {
				if (dim_extent(d) > dim_extent(largest)) largest = d;
			}
			if (dim_extent(largest) < 2) {
				std::cout << "  Nothing to reduce over; skipping aggregation\n";
				return f;
			}
			std::cout << "  Dimension " << reduce_dim << " has extent 1; reducing over "
					  << largest << " instead\n";
			reduce_dim = largest;
		}

		std::cout << "  Reducing over dimension " << reduce_dim
				  << " with expression depth " << expr_depth << "\n";


		// ### create a randomly generated aggregate function over a randomly chosen reduction domain.
		// #### decide over what dimension and window size to aggregate.
		int extent = dim_extent(reduce_dim);
		int window_size = rand_int(1, std::min(10, extent));
		RDom r(0, window_size);
		agg_coords[reduce_dim] = clamp(agg_coords[reduce_dim] + r, 0, extent - 1);
		std::vector<Expr> inputs;
		inputs.push_back(f.func(agg_coords));
		Expr agg_expr = random_expr(inputs, expr_depth, func_size);
		

		// Choosing Reduction =========
		int agg_type = rand_int(0, 4);

		if(agg_type == 0) {
			result(f.func.args()) = sum(cast(f.func.value().type(), agg_expr));
			std::cout<<"finding sum(cast(" << f.func.value().type() <<", "<< agg_expr << "))\n";
		} else if(agg_type == 1) {
			result(f.func.args()) += cast(f.func.value().type(), agg_expr/window_size);
			std::cout<<"finding avg(cast(" << f.func.value().type() <<", "<< agg_expr << "))\n";
		}else if(agg_type == 2) {
			result(f.func.args()) = argmin(cast(f.func.value().type(), agg_expr))[0];
			std::cout<<"finding argmin(cast(" << f.func.value().type() <<", "<< agg_expr << "))\n";
		}else if(agg_type == 3) {
			result(f.func.args()) = argmax(cast(f.func.value().type(), agg_expr))[0];
			std::cout<<"finding argmax(cast(" << f.func.value().type() <<", "<< agg_expr << "))\n";
		}else{
			result(f.func.args()) = sum(cast(f.func.value().type(), agg_expr));
			std::cout<<"finding sum(cast(" << f.func.value().type() <<", "<< agg_expr << "))\n";
		}
		
		return {result, f.w, f.h, f.c};
	}


	// ============================================================================
	// REVISED Mux Stage
	// ============================================================================

	// Mux stage: N-way selection based on index value
	// REVISED: Always maintains 3D output
	//Stage mux_stage(Stage data, Stage index) {
		//std::cout << "Creating mux stage from data " << data.w << "×" << data.h << "×" << data.c 
				  //<< " with index " << index.w << "×" << index.h << "×" << index.c << "\n";
		
		//Func result("mux");
		
		//if (data.c == 3) {
			//// Mux over channels using index stage, result per-channel
			//std::cout << "  Mux: selecting from " << data.c << " channels\n";
			
			//// Use modulo to ensure index is in valid range
			//Expr idx = cast<int>(index.func(x, y, c)) % data.c;
			
			//// Build mux options
			//std::vector<Expr> options;
			//for (int i = 0; i < std::min(data.c, 8); i++) {
				//options.push_back(data.func(x, y, i));
			//}
			
			//// REVISED: Apply mux per-channel (each channel might select different source)
			//result(x, y, c) = mux(idx, options);
			
			//return {result, data.w, data.h, data.c};  // CHANGED: Keep 3D
		//}
		
		//// Fallback: just return data as-is
		//std::cout << "  Mux: fallback to identity (not enough channels)\n";
		//result(x, y, c) = data.func(x, y, c);
		//return {result, data.w, data.h, data.c};
	//}


    // Add a random new stage onto the end of the pipeline.
    Stage random_stage(const vector<Stage> &s) {
        int m = (int)s.size() - 1;
        int i2 = m > 0 ? rand_int(0, m - 1) : 0;
        int i1 = m > 0 ? rand_int(i2 + 1, m) : 0;

        Stage f = s[i1], g = s[i2];

        int stage_type = rand_int(0, 16);

        if (stage_type == 0) {
            int dim = rand_int(0, 1);
            int kernel_min = rand_int(-3, 0);
            int kernel_max = rand_int(0, 3);
            return convolve(f, dim, kernel_min, kernel_max);
        } else if (stage_type == 1) {
            int dim = rand_int(0, 1);
            int kernel_min = rand_int(-10, 0);
            int kernel_max = rand_int(0, 10);
            return convolve_r(f, dim, kernel_min, kernel_max);
        } else if (stage_type == 2) {
            int dim = rand_int(0, 1);
            int kernel_min = rand_int(-10, 0);
            int kernel_max = rand_int(0, 10);
            return convolve_w(f, dim, kernel_min, kernel_max);
        } else if (stage_type == 3) {
            int kernel_min = rand_int(-5, 0);
            int kernel_max = rand_int(0, 5);
            return convolve2D(f, kernel_min, kernel_max);
        } else if (stage_type == 4 && f.may_reduce_size() && f.w >= 32 && f.h >= 32) {
            int kernel_min = rand_int(-5, 0);
            int kernel_max = rand_int(0, 5);
            return pool2D(f, kernel_min, kernel_max);
        } else if (stage_type == 5) {
            return activation(f);
        } else if (stage_type == 6) {
            return padding(f);
        } else if (stage_type == 7 && f.may_increase_size()) {
            // For now, only upsample dimensions 0 or 1.
            return upsample(f, rand_int(0, 1));
        } else if (stage_type == 8 && f.may_reduce_size()) {
            // For now, only downsample dimensions 0 or 1.
            return downsample(f, rand_int(0, 1));
        } else if (stage_type == 9) {
            int dim = 2;
            return all_to_all(f, dim);
        } else if (stage_type == 10) {
            int dim = 2;
            return all_to_all_r(f, dim);
        } else if (stage_type == 11) {
            int dim = 2;
            return all_to_all_w(f, dim);
        } else if (stage_type == 13) {
            return slice(f, g);
        } else if (stage_type == 14) {
        // CHANGED: Pass func_size to aggregation_stage
			int func_size = 20;
			return aggregation_stage(f, func_size);
		} else if (i1 != i2) {
            return binary_op(f, g);
        } else {
            // Try again
            return random_stage(s);
        }
    }

    void generate() {
        //rng.seed((int)seed);
		std::cerr << "[DEBUG] HL_RNG_LOG=" 
			<< (std::getenv("HL_RNG_LOG") ? std::getenv("HL_RNG_LOG") : "unset") 
			<< "\n";
		std::cerr << "[DEBUG] HL_RNG_CHOICES_FILE=" 
			<< (std::getenv("HL_RNG_CHOICES_FILE") ? std::getenv("HL_RNG_CHOICES_FILE") : "unset") 
			<< "\n";
		init_rng((int)seed);

        Var x("x"), y("y"), c("c");

        Func first;

	// Need boundary conditions to avoid out of bounds access on input buffer
        // first(x, y, c) = input(x, y, c);
        rng.advance_stage();  // chunk 0: boundary
        int rand_boundary = rand_int(0, 4);
	if (rand_boundary == 0) {
            std::cout << "Using constant_exterior" << "\n";
	    first = BoundaryConditions::constant_exterior(input, 7);
	} else if (rand_boundary == 1) {
            std::cout << "Using repeat_edge" << "\n";
	    first = BoundaryConditions::repeat_edge(input);
	} else if (rand_boundary == 2) {
            std::cout << "Using repeat_image" << "\n";
	    first = BoundaryConditions::repeat_image(input);
	} else if (rand_boundary == 3) {
            std::cout << "Using mirror_image" << "\n";
	    first = BoundaryConditions::mirror_image(input);
	} else {
            std::cout << "Using mirror_interior" << "\n";
	    first = BoundaryConditions::mirror_interior(input);
	}

	uint8_weights_bounded  = BoundaryConditions::repeat_edge(uint8_weights);
	uint16_weights_bounded = BoundaryConditions::repeat_edge(uint16_weights);
	uint32_weights_bounded = BoundaryConditions::repeat_edge(uint32_weights);
	int8_weights_bounded   = BoundaryConditions::repeat_edge(int8_weights);
	int16_weights_bounded  = BoundaryConditions::repeat_edge(int16_weights);
	int32_weights_bounded  = BoundaryConditions::repeat_edge(int32_weights);
	float32_weights_bounded = BoundaryConditions::repeat_edge(float32_weights);

        int W=2000;
        int H=2000;
        vector<Stage> stages;
        // Assume input starts at ~2000x2000
        // stages.emplace_back(Stage{first, 2000, 2000, 3});
        stages.emplace_back(Stage{first, W, H, 3});

        for (int i = 0; i < max_stages - 2; i++) {
            std::cout << "Approx size: " << stages.back().w << ", " << stages.back().h << ", " << stages.back().c << "\n";
            rng.advance_stage();  // chunk i+1: stage i
            Stage next = random_stage(stages);
            stages.push_back(next);
            if (!using_autoscheduler()) {
                stages.back().func.compute_root();
            }
        }

        Stage tail = stages.back();

        // Resample back to the correct resolution
        // tail = resample_to(tail, 2000, 2000, 3);
        tail = resample_to(tail, W, H, 3);
        Stage casted = cast_stage(output.type(), tail);
        output = casted.func;

        if (!using_autoscheduler()) {
            output.compute_root();
        }
    }

    void schedule() {
        // Set estimates for both autoscheduler and benchmarking
        // Estimates are required for autoscheduler to make scheduling decisions
        // and for RunGenMain benchmark tool to allocate buffers
        int W=2000;
        int H=2000;
        input.dim(0).set_estimate(0, W)
            .dim(1).set_estimate(0, H)
            .dim(2).set_estimate(0, 3);
        uint8_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        uint16_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        uint32_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        int8_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        int16_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        int32_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        float32_weights.dim(0).set_estimate(0, 512)
            .dim(1).set_estimate(-5, 5)
            .dim(2).set_estimate(-5, 5)
            .dim(3).set_estimate(0, 512);
        //output.set_estimate(output.args()[0], 0, W);
        //output.set_estimate(output.args()[1], 0, H);
        //output.set_estimate(output.args()[2], 0, 3);

        output.dim(0).set_estimate(0, W);
        output.dim(1).set_estimate(0, H);
        output.dim(2).set_estimate(0, 3);
    }
};

HALIDE_REGISTER_GENERATOR(RandomPipeline, random_pipeline)

