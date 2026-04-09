#!/usr/bin/env bash
#set -o pipefail
set -e

#BENCHMARKS=("stencil_chain" "interpolate" "max_filter" "camera_pipe" "hist" "nl_means" "lens_blur" "bilateral_grid" "harris" "local_laplacian" "conv_layer" "iir_blur" "bgu" "unsharp" "depthwise_separable_conv")  # add yours
BENCHMARKS=("lens_blur" "interpolate" "camera_pipe" "local_laplacian" "iir_blur")  # add yours

RESULT_DIR="./results_benchapp"
mkdir -p "$RESULT_DIR"
for BENCHMARK in "${BENCHMARKS[@]}"; do
    echo ">>> Running benchmark: $BENCHMARK"

    # Clear samples from previous benchmark/mode runs
    rm -rf ./build_benchapp_samples/samples
	bash run_benchapp_samples.sh "$BENCHMARK" custom adams2019    | tee "$RESULT_DIR/${BENCHMARK}_custom.log"

	#rm -rf ./build_benchapp_samples/samples
	##bash run_benchapp_samples.sh "$BENCHMARK" adams2019Libtorch  | tee "$RESULT_DIR/${BENCHMARK}_adams2019.log"

	rm -rf ./build_benchapp_samples/samples
	bash run_benchapp_samples.sh "$BENCHMARK" adams2019Halide  | tee "$RESULT_DIR/${BENCHMARK}_adams2019Halide.log"

	rm -rf ./build_benchapp_samples/samples
	bash run_benchapp_baseline.sh "$BENCHMARK" manual    | tee "$RESULT_DIR/${BENCHMARK}_manual.log"
done
