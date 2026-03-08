# Using the scripts within this repo to test the halide autoscheduler

## To test the random pipeline generator
Running either of the below mentioned random-program-testing scripts should automatically build the generator and use it to produce new programs as long as the corresponding build directory is not already present (in which case it will skip building, and just use the already-built binary for the generator).

## Running halide with random programs
The scripts `run_x86_samples.sh` and `run_x86_samples_libtorch.sh` can be used to test halide on random programs. Both of them require defining the `$BATCH_SIZE` and `$NUM_BATCHES` variables. When specified, for each batch, we run a particular randomly generated halide pipeline (generated through the `random_program_generator.cpp` with the batch id as seed) `BATCH_SIZE` number of time, where each time, the arguments to the autoscheduler are varied, resulting in it finding different "best" schedules.

## Running halide on benchmarks
This requires that you have the benchmarks built on your system. We have hardcoded the path to the root folder consisting of each benchmark's `.generator` file. Once this path (and other paths) has bene set, simply running `bash benchmark.sh` should run all these benchmarks in order, each benchmark being executed multiple times using the same autoscheduler parameters. Following this, run `python3 analyze_benchmarks.py` to take the results produced from these runs, and automatically generate graphs consisting of the average runtime (averaged over multiple runs), total compile time, and total benchmarking time for each benchmark. 


