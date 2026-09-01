#!/usr/bin/env bash
#set -o pipefail
set -e

BENCHMARKS=("stencil_chain" "interpolate" "max_filter" "camera_pipe" "hist" "nl_means" "lens_blur" "bilateral_grid" "harris" "local_laplacian" "conv_layer" "iir_blur" "bgu" "unsharp" "depthwise_separable_conv")  # add yours
#BENCHMARKS=("lens_blur" "interpolate" "camera_pipe" "local_laplacian")  # add yours
#BENCHMARKS=("interpolate" "camera_pipe" "local_laplacian")  # add yours
#BENCHMARKS=("lens_blur")  # add yours

RESULT_DIR="./results_generate_test_dist"
mkdir -p "$RESULT_DIR"
for BENCHMARK in "${BENCHMARKS[@]}"; do
    echo ">>> Running benchmark: $BENCHMARK"
    # Clears samples from previous benchmark/mode runs before every benchmark test

    #rm -rf ./build_benchapp_samples/samples
    #bash run_benchapp_samples.sh "$BENCHMARK" custom adams2019  "${BEST_WEIGHTS_RANDOM}"  | tee "$RESULT_DIR/${BENCHMARK}_customAdams2019Random.log"

    #rm -rf ./build_benchapp_samples/samples
    #bash run_benchapp_samples.sh "$BENCHMARK" custom adams2019  "${BEST_WEIGHTS_STRATEGY}"  | tee "$RESULT_DIR/${BENCHMARK}_customAdams2019${STRATEGY_NAME}.log"

    #rm -rf ./build_benchapp_samples/samples
    bash run_test_dist_generation.sh "$BENCHMARK" adams2019Halide  | tee "$RESULT_DIR/${BENCHMARK}_halideAdams2019.log"

    #rm -rf ./build_benchapp_samples/samples
    #bash run_benchapp_baseline.sh "$BENCHMARK" manual    | tee "$RESULT_DIR/${BENCHMARK}_manual.log"
done
