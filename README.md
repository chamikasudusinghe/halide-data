# Using the scripts within this repo to test the halide autoscheduler

## To test the random pipeline generator
Running either of the below mentioned random-program-testing scripts should automatically build the generator and use it to produce new programs as long as the corresponding build directory is not already present (in which case it will skip building, and just use the already-built binary for the generator).

## Running halide with random programs
The scripts `run_x86_samples.sh` and `run_x86_samples_libtorch.sh` can be used to test halide on random programs. Both of them require defining the `$BATCH_SIZE` and `$NUM_BATCHES` variables. When specified, for each batch, we run a particular randomly generated halide pipeline (generated through the `random_program_generator.cpp` with the batch id as seed) `BATCH_SIZE` number of time, where each time, the arguments to the autoscheduler are varied, resulting in it finding different "best" schedules.

### Diversity of Pipelines and Schedules
The generated pipeline is controlled using the "seed" generator param. This is currently set to ```$BATCH_ID``` (check make\_featurization()) because a batch includes multiple schedules for the same pipeline. The generated schedule for that pipeline is set using three controls: random\_dropout, beam\_size and random\_dropout\_seed. The first two are hardcoded to (100, 32) for the first schedule of any batch, and (1, 1) for the remaining schedules. The random dropout seed is controlled by a combination of the pipeline id and schedule id; so it's unique for each schedule that we generate in this script.

### Current setup for parallelism
There are three kinds of things to worry about here:
- The **autoscheduler.parallelism** setting provided as a generator param to random\_pipeline\_generator: This specifies to the generator "for what kind of target machine am I producing a halide schedule?". Based on this *suggestion*, it will prune its schedule search space so as to speed up the search. Presumably if you compile for 32 cores but run for 4 cores, there'll be a lot of parallel tasks competing for a limited number of cores.
- The number of **local cores** on your system: Ideally, autoscheduler.parallelism should be a number smaller than this, else, again, halide will generate schedules that have more parallel tasks than the machine can handle efficiently.
- The **HL_NUM_THREADS** environment variable: This determines how many threads *the halide runtime generates and uses irrespective of the total number of cores in the system*. If total number of cores is 32, autoscheduler.parallelism is 32, but HL\_NUM\_THREADS is 8, then the halide runtime will try to schedule parallel tasks created for a 32 thread machine onto just 8 threads; leading to thrashing.

The default script setup is to take three parameters: --num-threads, --start-core, --end-core.

If all three are specified, the script will set autoscheduler.parallelism and HL\_NUM\_THREADS to num-threads, and run the benchmark using taskset, pinning it from start-core to end-core. 
If num-threads is not provided, it'll be inferred from start-core and end-core
if none of them are provided, num-threads will be set to the number of local cores detected using nproc

## Running halide on benchmarks
This requires that you have the benchmarks built on your system. We have hardcoded the path to the root folder consisting of each benchmark's `.generator` file. Once this path (and other paths) has bene set, simply running `bash benchmark.sh` should run all these benchmarks in order, each benchmark being executed multiple times using the same autoscheduler parameters. Following this, run `python3 analyze\_benchmarks.py` to take the results produced from these runs, and automatically generate graphs consisting of the average runtime (averaged over multiple runs), total compile time, and total benchmarking time for each benchmark. 


