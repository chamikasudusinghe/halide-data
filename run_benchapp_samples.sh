#!/bin/bash

set -e

BENCHMARK=$1
BENCH_MODE=$2
CUSTOM_TYPE=${3:-}
BEST_WEIGHTS=${4:-}

# ====================================================
# Set up environment vars necessary to build generator
# ====================================================
# The following are for Halide installation and changes per user
export HALIDE_ROOT=/home/bhirani2/cosmos/deeptuner/Halide
export HALIDE_INSTALL_ROOT=/home/bhirani2/cosmos/deeptuner/halide-install-all/halide-install-libtorch-mod
# The following are for halide
export HALIDE_BIN=${HALIDE_INSTALL_ROOT}/bin
export AUTOSCHED_TOOLS=${HALIDE_ROOT}/src/autoschedulers/adams2019
export HL_DEBUG_CODEGEN=1
# Default to 1 to use LibTorch cost model. Set to 0 to use original Halide model
export HL_USE_LIBTORCH_COST_MODEL=${HL_USE_LIBTORCH_COST_MODEL:-1}

# =================================================================
# Set up more variables for arguments to compile, bench and retrain
# =================================================================
BASELOC=`pwd`
if [ -f "${BASELOC}/build_benchapp_samples/samples/updated.pt" ]; then
	rm -rf "${BASELOC}/build_benchapp_samples/samples/updated.pt"
	echo "removed existing updated.pt in build_benchapp_samples/samples/"
fi

#BIN=${BLD_TOP}/${}
PIPELINE="${BENCHMARK}"  # CHANGED: from random_pipeline to benchapp
WEIGHTS_ARCHIVE=${BASELOC}/weights_archive
VALID_CUSTOM_TYPES=("custom0" "adams2019")

if [[ "$BENCH_MODE" == "custom" ]]; then
    if [[ " ${VALID_CUSTOM_TYPES[*]} " == *" ${CUSTOM_TYPE} "* ]] && [[ -f "$BEST_WEIGHTS" ]]; then
        echo "bash: valid custom type '${CUSTOM_TYPE}' and weights file found: ${BEST_WEIGHTS}"
        export HL_USE_LIBTORCH_COST_MODEL=1
        export HL_COST_MODEL_TYPE=custom
        export HL_WEIGHTS_DIR=${BEST_WEIGHTS}
        START_WEIGHTS_FILE=${BEST_WEIGHTS}
        export HL_COST_MODEL_TYPE=custom
        export HL_CUSTOM_MODEL_TYPE=${CUSTOM_TYPE}
        export HL_WEIGHTS_INPUT_FORMAT=torchscript
    else
        echo "bash: ERROR: invalid custom type '${CUSTOM_TYPE}'"
        exit 1
    fi
elif [[ "$BENCH_MODE" == "adams2019Libtorch" ]]; then
	echo "bash: adams2019 libtorch version detected for ${BENCHMARK}"
	export HL_WEIGHTS_DIR=${WEIGHTS_ARCHIVE}/baseline_libtorch.pt
	START_WEIGHTS_FILE=${WEIGHTS_ARCHIVE}/baseline_libtorch.pt
	export HL_COST_MODEL_TYPE=adams2019
	export HL_WEIGHTS_INPUT_FORMAT=archive
elif [[ "$BENCH_MODE" == "adams2019Halide" ]]; then
	echo "bash: adams2019 halide version detected for ${BENCHMARK}"
	export HL_WEIGHTS_DIR=${WEIGHTS_ARCHIVE}/baseline.weights
	START_WEIGHTS_FILE=${WEIGHTS_ARCHIVE}/baseline.weights
	export HL_USE_LIBTORCH_COST_MODEL=0
else 
	echo "Warning: Mode not supported, setting weights to default halide weights"
	START_WEIGHTS_FILE=${WEIGHTS_ARCHIVE}/baseline.weights
	export HL_WEIGHTS_DIR=${WEIGHTS_ARCHIVE}/baseline.weights
	export HL_USE_LIBTORCH_COST_MODEL=0
fi


# Use LibTorch weights if LibTorch is enabled, otherwise use baseline.weights
#if [ "${HL_USE_LIBTORCH_COST_MODEL:-1}" = "1" ]; then
	#if [[ "$BENCH_MODE" == "custom" ]]; then
		#START_WEIGHTS_FILE=${AUTOSCHED_TOOLS}/baseline_custom0.pt
	#else
		#START_WEIGHTS_FILE=${AUTOSCHED_TOOLS}/baseline_libtorch.pt
	#fi
#else
    #START_WEIGHTS_FILE=${AUTOSCHED_TOOLS}/baseline.weights
#fi

# IMPORTANT: Path to your CMake build directory where benchapp was built
# Adjust this to match your actual build location
BENCH_BUILD_DIR=${HALIDE_ROOT}/apps/${BENCHMARK}/build

# Generator and runtime locations from CMake build
GENERATOR=${BENCH_BUILD_DIR}/${BENCHMARK}.generator

if [[ -d "${BENCH_BUILD_DIR}" ]]; then
	if [[ -f "${GENERATOR}" ]]; then
		echo "found generator..."
	else
		echo "build dir exists but generator not found. Run make to produce one"
	fi
else
	echo "generator does not exist. Compiling..."
	mkdir -p ${BENCH_BUILD_DIR}
	cd ${BENCH_BUILD_DIR}
	cmake .. -DCMAKE_PREFIX_PATH=${HALIDE_INSTALL_ROOT} && make
	if [[ -f "${GENERATOR}" ]]; then
		echo "generator successfully compiled..."
	else
		echo "unable to compile generator, probably because cmake or make failed..."
	fi
fi


# Output directory for samples
BLD_TOP=${BASELOC}/build_benchapp_samples
RUNTIME=${BLD_TOP}/auto_schedule_runtime.a  # Generated on first run

# CHANGED: benchapp specific parameters
# You may need to adjust these based on your benchapp generator's arguments
BATCH_SIZE=8  # Generate 10 schedules for benchapp
NUM_BATCHES=1  # Number of batches to generate

# Lens blur specific generator arguments
# Adjust these based on what your benchapp.cpp accepts
LENS_BLUR_ARGS=""  # Example args - modify as needed

COMPILATION_TIMEOUT=1000s 
BENCHMARKING_TIMEOUT=180s 

# =================
# Utility functions
# =================

# Build a single featurization of the pipeline with a random schedule
make_featurization() {
    D=${1}
    SEED=${2}
    FNAME=${3}
    BATCH_ID=${4}
    EXTRA_GENERATOR_ARGS=${5}
    
    mkdir -p ${D}
    if [ ! -d "${D}" ] || [ ! -w "${D}" ]; then
        echo "ERROR: Cannot create or write to directory ${D}" >&2
        return 1
    fi
    
    rm -f "${D}/${FNAME}.featurization"
    rm -f "${D}/${FNAME}.sample"
    
	dropout=100
	beam=32

    echo "Generating schedule for ${D} with seed=${SEED}, dropout=${dropout}, beam=${beam}"

    HL_RANDOM_DROPOUT=${dropout} \
    HL_SEED=${SEED} \
    HL_BEAM_SIZE=${beam} \
    HL_MACHINE_PARAMS=4,24000000,40 \
    HL_PERMIT_FAILED_UNROLL=1 \
    HL_WEIGHTS_DIR=${WEIGHTS} \
    HL_PREFETCHING=1 \
    HL_USE_LIBTORCH_COST_MODEL=${HL_USE_LIBTORCH_COST_MODEL:-1} \
    GEN_EXIT=0

	# DEBUGGING =====
	export HL_DEBUG_CODEGEN=1 #${GENERATOR} -g ${PIPELINE} -f ${PIPELINE} \
    #-o /tmp -e static_library,c_header,registration,schedule,featurization target=host 2>&1 | grep "Codegen target" >> "debug.out"
	# ===============
    
    # CHANGED: Modified generator call for benchapp
	echo "using target $TARGET"
    ${TIMEOUT_CMD} -k ${COMPILATION_TIMEOUT} ${COMPILATION_TIMEOUT} \
    ${GENERATOR} -g ${PIPELINE} -o ${D} \
    -e static_library,c_header,registration,schedule,featurization \
    -f ${PIPELINE} target=${TARGET}-no_runtime \
    ${EXTRA_GENERATOR_ARGS} \
	autoscheduler=Adams2019 \
	-p ${AUTOSCHED_BIN}/libautoschedule_adams2019.so \
	autoscheduler.parallelism=32 \
	autoscheduler.beam_size=${beam} \
	autoscheduler.random_dropout=${dropout} \
	autoscheduler.random_dropout_seed=42 \
	autoscheduler.weights_path=${HL_WEIGHTS_DIR} \
    2> ${D}/stderr.txt > ${D}/stdout.txt
    GEN_EXIT=$?
    
    if [ $GEN_EXIT -ne 0 ]; then
        echo "Generator failed with exit code $GEN_EXIT for ${D}" >> ${D}/stderr.txt
        echo "Check ${D}/stderr.txt for details"
        return 1
    fi
    
    A_FILE=$(ls ${D}/*.a 2>/dev/null | head -1)
    REG_FILE=$(ls ${D}/*registration.cpp 2>/dev/null | head -1)
    if [ -z "$A_FILE" ] || [ -z "$REG_FILE" ]; then
        echo "ERROR: Generator did not produce required files (.a or .registration.cpp) in ${D}" >> ${D}/stderr.txt
        echo "Files in ${D}:" >> ${D}/stderr.txt
        ls -la ${D}/ >> ${D}/stderr.txt 2>&1
        return 1
    fi
    
    echo "Compiling benchmark for ${D}..."
    ${CXX_X86} ${CXXFLAGS_X86} \
    -I ${D} -I ${HALIDE_INSTALL_ROOT}/include -I${HALIDE_ROOT}/tools \
    ${HALIDE_INSTALL_ROOT}/share/tools/RunGenMain.cpp ${RUNTIME}\
	-L${HALIDE_INSTALL_ROOT}/lib -lHalide \
	-Wl,-rpath,${HALIDE_INSTALL_ROOT}/lib \
    ${D}/*registration.cpp ${D}/*.a -o ${D}/bench ${LDFLAGS_X86} 2>> ${D}/stderr.txt
    COMPILE_EXIT=$?
    
	#rm -f "${D}/${FNAME}.registration.cpp"

    if [ $COMPILE_EXIT -ne 0 ]; then
        echo "Compilation failed with exit code $COMPILE_EXIT for ${D}" >> ${D}/stderr.txt
        echo "Check ${D}/stderr.txt for details"
        return 1
    fi
    
    echo "✓ Successfully generated and compiled ${D}"
}

# run the benchmarking program on the device
run_bench() {
    BIN=${1}
    DEVICE="host"
    mkdir -p ${BIN}/${DEVICE}/
    rm -rf ${BIN}/${DEVICE}/*
    
    echo "Running benchmark for ${BIN}..."
    ${TIMEOUT_CMD} -k ${BENCHMARKING_TIMEOUT} ${BENCHMARKING_TIMEOUT} \
    ${BIN}/bench --estimate_all --benchmarks=all 2>&1
    
    rm -rf ${BIN}/bench
}

# Benchmark one of the random samples
benchmark_sample() {
    sleep 1 # Give CPU clocks a chance to spin back up if we're thermally throttling
    D=${1}
    
    if [ -f ${D}/bench ]; then
        run_bench ${D} | tee ${D}/bench.txt || echo "Benchmarking failed or timed out for ${D}"
    else
        echo "Not benchmarking because compilation failed for ${D}!"
        return 1
    fi

    # Add the runtime, pipeline id, and schedule id to the feature file
    R=$(grep "Benchmark for " ${D}/bench.txt | cut -d' ' -f8)
    P=$3  # Pipeline ID
    S=$2  # Schedule ID
    FNAME=$4
    
    if [ -z "$R" ]; then
        echo "ERROR: Could not extract runtime from bench.txt for ${D}"
        return 1
    fi
    
    echo "Runtime for ${D}: ${R} ms"
    
    ${HALIDE_BIN}/adams2019_featurization_to_sample ${D}/${FNAME}.featurization $R $P $S ${D}/${FNAME}.sample || echo "featurization_to_sample failed for ${D} (probably because benchmarking failed)"
}


####################
# Main loop begins #
####################

#########################################
# Step 1: Verify benchapp generator exists

echo "======================================================"
echo "Step 1: Checking for benchapp.generator"
echo "======================================================"

# Check if the generator exists
if [ ! -f ${GENERATOR} ]; then
    echo "ERROR: Generator not found at ${GENERATOR}"
    echo ""
    echo "Please build benchapp first using CMake:"
    echo ""
    echo "  cd ${HALIDE_ROOT}/apps/benchapp"
    echo "  mkdir -p build && cd build"
    echo "  cmake .. -DCMAKE_PREFIX_PATH=${HALIDE_INSTALL_ROOT}"
    echo "  make benchapp.generator"
    echo ""
    echo "This will create: build/benchapp.generator"
    echo ""
    echo "Then update BENCH_BUILD_DIR in this script to point to that build directory."
    exit 1
fi

echo "✓ Generator found: ${GENERATOR}"

# Verify it's executable
if [ ! -x ${GENERATOR} ]; then
    echo "ERROR: Generator exists but is not executable"
    echo "Run: chmod +x ${GENERATOR}"
    exit 1
fi

# Test the generator
#echo "Testing generator..."
#${GENERATOR} --help > /dev/null 2>&1
#if [ $? -ne 0 ]; then
    #echo "ERROR: Generator does not run correctly"
    #echo "Try running: ${GENERATOR} --help"
    #exit 1
#fi

#echo "✓ Generator is working"
#echo "✓ Runtime: ${RUNTIME}"

SAMPLES=${BLD_TOP}/samples
mkdir -p ${SAMPLES}

# Set weights path based on format
if [ "${HL_USE_LIBTORCH_COST_MODEL:-1}" = "1" ]; then
    WEIGHTS=${SAMPLES}/updated.pt
else
    WEIGHTS=${SAMPLES}/updated.weights
fi

# Copy starting weights if updated version doesn't exist
if [[ -f ${WEIGHTS} ]]; then
    echo "✓ Using existing weights: ${WEIGHTS}"
else
    if [[ -f ${START_WEIGHTS_FILE} ]]; then
        cp ${START_WEIGHTS_FILE} ${WEIGHTS}
        echo "✓ Copied starting weights from ${START_WEIGHTS_FILE} to ${WEIGHTS}"
    else
        echo "⚠ Warning: ${START_WEIGHTS_FILE} not found, weights will be random"
    fi
fi

TIMEOUT_CMD="timeout"
if [ $(uname -s) = "Darwin" ] && ! which $TIMEOUT_CMD 2>&1 >/dev/null; then
    TIMEOUT_CMD="gtimeout"
    if ! which $TIMEOUT_CMD 2>&1 >/dev/null; then
        echo "Can't find the command 'gtimeout'. Run 'brew install coreutils' to install it."
        exit 1
    fi
fi

####################################################
# Step 2: Generate and benchmark benchapp schedules

CXX_X86=clang++
CXXFLAGS_X86="-std=c++17 -DHALIDE_NO_PNG -DHALIDE_NO_JPEG"
LDFLAGS_X86="-lpthread -ldl -fPIE -pie"
#TARGET="host"
#TARGET="x86-64-linux-avx-avx2-avx512f-avx512bw-avx512dq-avx512cd-avx512vl-f16c-fma-sse41"
TARGET="x86-64-linux-avx-avx2-avx512-f16c-fma-sse41"

# Generate standalone Halide runtime if it doesn't exist
if [ ! -f ${RUNTIME} ]; then
    echo "Generating Halide runtime..."
    mkdir -p ${BLD_TOP}
    ${GENERATOR} -r auto_schedule_runtime -o ${BLD_TOP} target=${TARGET}
    echo "✓ Generated runtime: ${RUNTIME}"
fi

AUTOSCHED_BIN=${HALIDE_INSTALL_ROOT}/lib

if [[ $(ls -A build_benchapp_samples/samples/batch*) ]];
then
    FIRST=$(ls -d ${SAMPLES}/batch_* 2>/dev/null | sed -e "s|.*/batch_||;s|_.*||" | sort -n | tail -n1)
	echo "Found existing batches"
else
    FIRST="0";
	echo "Did not find existing batches"
fi


if [ $(uname -s) = "Darwin" ]; then
    LOCAL_CORES=`sysctl -n hw.ncpu`
else
    LOCAL_CORES=`nproc`
fi
echo "Local number of cores detected as ${LOCAL_CORES}"

OFFSET=0

echo ""
echo "======================================================"
echo "Step 2: Generating and benchmarking benchapp schedules"
echo "======================================================"
echo "Batch size: ${BATCH_SIZE} schedules per batch"
echo "Number of batches: ${NUM_BATCHES}"
echo "Generator args: ${LENS_BLUR_ARGS}"
echo ""

for ((BATCH_ID=$((FIRST+OFFSET+1));BATCH_ID<$((FIRST+OFFSET+1+NUM_BATCHES));BATCH_ID++)); do

    echo ""
    echo "------------------------------------------------------"
    echo "Processing BATCH ${BATCH_ID}"
    echo "------------------------------------------------------"

    # Track time
    COMPILE_SEC=0
    RUN_SEC=0

    # 2a & 2b: Generate and compile samples
    echo "[BATCH $BATCH_ID] Generating and compiling ${BATCH_SIZE} schedules..."

    SECONDS=0
    DIR=${SAMPLES}/batch_${BATCH_ID}

    # Copy the weights being used
    mkdir -p ${DIR}/
    if [[ -f ${WEIGHTS} ]]; then
        if [ "${HL_USE_LIBTORCH_COST_MODEL:-1}" = "1" ]; then
            cp ${WEIGHTS} ${DIR}/used.weights.pt
        else
            cp ${WEIGHTS} ${DIR}/used.weights
        fi
    fi

    echo "${LENS_BLUR_ARGS}" > ${DIR}/generator_args.txt

    # Compile in parallel
    echo -n "Compiling ${BATCH_SIZE} samples: "
    for ((SAMPLE_ID=0;SAMPLE_ID<${BATCH_SIZE};SAMPLE_ID++)); do
        while [[ 1 ]]; do
            RUNNING=$(jobs -r | wc -l)
            if [[ ${RUNNING} -ge ${LOCAL_CORES} ]]; then
                sleep 1
            else
                break
            fi
        done

        # Use different seed for each sample
        S=$((BATCH_ID * 10000 + SAMPLE_ID + 1))
        FNAME=${PIPELINE}
        make_featurization "${DIR}/${SAMPLE_ID}" $S $FNAME $BATCH_ID "$LENS_BLUR_ARGS" &
        echo -n "."
    done
    wait
    echo " done."

    COMPILE_SEC=${SECONDS}

    # 2c: Benchmark each sample serially
    echo "[BATCH $BATCH_ID] Benchmarking ${BATCH_SIZE} schedules..."

    SECONDS=0
    SUCCESSFUL=0
    FAILED=0

    for ((SAMPLE_ID=0;SAMPLE_ID<${BATCH_SIZE};SAMPLE_ID++)); do
        S=$(printf "%04d%04d" $BATCH_ID $SAMPLE_ID)
        FNAME=${PIPELINE}

        if benchmark_sample "${DIR}/${SAMPLE_ID}" $S $BATCH_ID $FNAME; then
            SUCCESSFUL=$((SUCCESSFUL + 1))
        else
            FAILED=$((FAILED + 1))
        fi
    done

    RUN_SEC=${SECONDS}

    echo ""
    echo "[BATCH ${BATCH_ID}] Summary:"
    echo "  Compilation time: ${COMPILE_SEC} seconds"
    echo "  Benchmarking time: ${RUN_SEC} seconds"
    echo "  Successful samples: ${SUCCESSFUL}/${BATCH_SIZE}"
    echo "  Failed samples: ${FAILED}/${BATCH_SIZE}"
    echo ""

    # List the generated .sample files
    echo "[BATCH ${BATCH_ID}] Generated .sample files:"
    find ${DIR} -name "*.sample" -type f | sort
    echo ""

done

echo ""
echo "======================================================"
echo "All batches complete!"
echo "======================================================"
echo ""
echo "Sample files are in: ${SAMPLES}/"
echo ""
echo "To train your cost model with these samples:"
echo "  find ${SAMPLES} -name '*.sample' | \\"
echo "  ${HALIDE_BIN}/adams2019_retrain_cost_model \\"
echo "    --epochs 30 \\"
echo "    --rates '0.001 0.0005 0.00025' \\"
echo "    --initial_weights ${WEIGHTS} \\"
echo "    --weights_out ${SAMPLES}/retrained.pt \\"
echo "    --num_cores ${LOCAL_CORES}"
echo ""
