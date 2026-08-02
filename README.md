# Using the scripts within this repo to test the halide autoscheduler

## To test the random pipeline generator
Running either of the below mentioned random-program-testing scripts should automatically build the generator and use it to produce new programs as long as the corresponding build directory is not already present (in which case it will skip building, and just use the already-built binary for the generator).

## Testing the generator itself

`bash test_conv2d_unrolled.sh` is a regression test for the generator, covering
the two fixes described in `CHANGELOG.md`. It takes about a minute and needs no
prior build - it compiles its own test binary, which `#include`s
`random_pipeline_generator.cpp` so that it can build pipelines in-process and
inspect the Funcs the generator produced.

For each pipeline it checks that every Func from `convolve2D_unrolled()` varies
with its output channel, then autoschedules with Adams2019 and compiles all the
way through LLVM codegen. Three groups of pipelines are run:

- **Case A** uses the controlled RNG (`HL_RNG_CHOICES_FILE`) to force the exact
  shape that used to crash: an unrolled 2D convolution feeding a `slice()` that
  indexes into it.
- **Case B** runs plain pipeline seeds `0..NUM_SEEDS-1` with no controlled RNG.
  A seed the generator cannot build at all is reported as `SKIP`, since that is
  a different bug from the one under test.
- **Case C** pins seeds that used to fail outright (currently seed 15). These
  are strict: a construction failure is a `FAIL`, not a `SKIP`.

The script exits non-zero if anything fails, or if it never saw an unrolled 2D
convolution to check. Useful overrides, all optional:

```
HALIDE_INSTALL_ROOT=...   # defaults to the libtorch-mod install
NUM_SEEDS=16              # how many plain seeds Case B runs
MAX_STAGES=20             # stages per pipeline (Case C is pinned to 20)
WEIGHTS=...               # cost model weights; defaults to weights_archive/
HL_USE_LIBTORCH_COST_MODEL=1
TARGET=host
BLD=./build_tests         # test binary, logs and generated .a files land here
```

Per-pipeline logs are written to `$BLD/out/<case>.log`.

## Running halide with random programs
The scripts `run_x86_samples.sh` and `run_x86_samples_libtorch.sh` can be used to test halide on random programs. Both of them require defining the `$BATCH_SIZE` and `$NUM_BATCHES` variables. When specified, for each batch, we run a particular randomly generated halide pipeline (generated through the `random_program_generator.cpp` with the batch id as seed) `BATCH_SIZE` number of time, where each time, the arguments to the autoscheduler are varied, resulting in it finding different "best" schedules.

## Running halide on benchmarks
This requires that you have the benchmarks built on your system. We have hardcoded the path to the root folder consisting of each benchmark's `.generator` file. Once this path (and other paths) has bene set, simply running `bash benchmark.sh` should run all these benchmarks in order, each benchmark being executed multiple times using the same autoscheduler parameters. Following this, run `python3 analyze_benchmarks.py` to take the results produced from these runs, and automatically generate graphs consisting of the average runtime (averaged over multiple runs), total compile time, and total benchmarking time for each benchmark. 


