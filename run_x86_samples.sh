#!/bin/bash

set -e

# ====================================================
# Set up environment vars necessary to build generator
# ====================================================
export HALIDE_ROOT=/home/chamika2/upstream/Halide
export HALIDE_INSTALL_ROOT=/home/chamika2/upstream/halide-install
export HALIDE_BIN=${HALIDE_INSTALL_ROOT}/bin
export AUTOSCHED_TOOLS=${HALIDE_ROOT}/src/autoschedulers/adams2019
export HL_DEBUG_CODEGEN=1

# =================================================================
# Set up more variables for arguments to compile, bench and retrain
# =================================================================
BASELOC=`pwd`
PIPELINE="random_pipeline"
BLD_TOP=${BASELOC}/build_x86_samples
BIN=${BLD_TOP}/${PIPELINE}/bin
GENERATOR=${BIN}/${PIPELINE}.generator
RUNTIME=${BIN}/runtime.a
START_WEIGHTS_FILE=${AUTOSCHED_TOOLS}/baseline.weights

BATCH_SIZE=32
NUM_BATCHES=5 # limited NUM_BATCHES for testing
MAX_STAGES=20

# Read the generator-arg sets into an array. Each set is delimited
# by space; multiple values within each set are are delimited with ;
# e.g. "set1arg1=1;set1arg2=foo set2=bar set3arg1=3.14;set4arg2=42"
if [ ! -z ${GENERATOR_EXTRA_ARGS} ]; then
    IFS=' ' read -r -a GENERATOR_ARGS_SETS_ARRAY <<< $GENERATOR_EXTRA_ARGS
else
    declare -a GENERATOR_ARGS_SETS_ARRAY=
fi

# Ensure the length is at least 1
if [ ${#GENERATOR_ARGS_SETS_ARRAY[@]} -eq 0 ]; then
    GENERATOR_ARGS_SETS_ARRAY=( '' )
fi

COMPILATION_TIMEOUT=300s 
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
    rm -f "${D}/${FNAME}.featurization"
    rm -f "${D}/${FNAME}.sample"
    if [[ $D == */0 ]]; then
        # Sample 0 in each batch is best effort beam search, with no randomness
        dropout=100
        beam=32
    else
        # The other samples are random probes biased by the cost model
        dropout=1  # 1% chance of operating entirely greedily
        beam=1
    fi

    HL_RANDOM_DROPOUT=${dropout} \
	HL_SEED=${SEED} \
	HL_BEAM_SIZE=${beam} \
    HL_MACHINE_PARAMS=4,24000000,40 \
	HL_PERMIT_FAILED_UNROLL=1 \
	HL_WEIGHTS_DIR=${WEIGHTS} \
	HL_PREFETCHING=1 \
    ${TIMEOUT_CMD} -k ${COMPILATION_TIMEOUT} ${COMPILATION_TIMEOUT} \
	${GENERATOR} -g ${PIPELINE} -o ${D} \
	-e static_library,c_header,registration,schedule,featurization \
	-f random_pipeline target=${TARGET}-no_runtime \
	seed=${BATCH_ID} max_stages=${MAX_STAGES} autoscheduler=Adams2019 \
    -p ${AUTOSCHED_BIN}/libauto_schedule.so \
    2> ${D}/stderr.txt > ${D}/stdout.txt && \
    ${CXX_X86} ${CXXFLAGS_X86} \
    -I ${D} -I ${HALIDE_INSTALL_ROOT}/include -I/${HALIDE_ROOT}/support \
    ${HALIDE_INSTALL_ROOT}/share/tools/RunGenMain.cpp ${RUNTIME} \
    ${D}/*registration.cpp ${D}/*.a -o ${D}/bench ${LDFLAGS_X86}

    # remove the files that are not needed anymore
#    rm -rf ${D}/*.a ${D}/*registration.cpp 
}

# run the benchmarking program on the device
run_bench() {
    BIN=${1}
    DEVICE="host";
    mkdir -p ${BIN}/${DEVICE}/; \
    rm -rf ${BIN}/${DEVICE}/* ; \
    ${TIMEOUT_CMD} -k ${BENCHMARKING_TIMEOUT} ${BENCHMARKING_TIMEOUT} \
    ${BIN}/bench --estimate_all --benchmarks=all 2>&1
    rm -rf ${BIN}/bench
}

# Benchmark one of the random samples
benchmark_sample() {
    sleep 1 # Give CPU clocks a chance to spin back up if we're thermally throttling
    D=${1}
    if [ -f ${D}/bench ]; then
        run_bench ${D}  \
           | tee ${D}/bench.txt || echo "Benchmarking failed or timed out for ${D}"
    else
        echo "Not benchmarking because compilation failed!"
    fi

    # Add the runtime, pipeline id, and schedule id to the feature file
    R=$(grep "Benchmark for " ${D}/bench.txt | cut -d' ' -f8)
    P=$3
    S=$2
    FNAME=$4
    ${HALIDE_BIN}/adams2019_featurization_to_sample ${D}/${FNAME}.featurization $R $P $S ${D}/${FNAME}.sample || echo "featurization_to_sample failed for ${D} (probably because benchmarking failed)"
}


####################
# Main loop begins #
####################

#########################################
# Step 1: Build random pipeline generator

echo "###### Step 1: Building random_pipeline.generator and runtime for it..." 

if [ ! -d ${BLD_TOP} ];
then
    BLD_TOP=${BLD_TOP} CXX=clang++ PIPELINE_SEED=0001 HALIDE_ROOT=${HALIDE_ROOT} make clean build
echo "...Done. Continue to next step"
else
    echo "...Already built. Continue to next step."
fi;

SAMPLES=${BLD_TOP}/samples
mkdir -p ${SAMPLES}

WEIGHTS=${SAMPLES}/updated.weights
if [[ -f ${WEIGHTS} ]]; then
    echo Using existing weights "${WEIGHTS}"
else
    # Only copy over the weights if we don't have any already,
    # so that restarted jobs can continue from where they left off
    cp ${START_WEIGHTS_FILE} ${WEIGHTS}
    echo Copying starting weights from ${START_WEIGHTS_FILE} to ${WEIGHTS}
fi

TIMEOUT_CMD="timeout"
if [ $(uname -s) = "Darwin" ] && ! which $TIMEOUT_CMD 2>&1 >/dev/null; then
    # OSX doesn't have timeout; gtimeout is equivalent and available via Homebrew
    TIMEOUT_CMD="gtimeout"
    if ! which $TIMEOUT_CMD 2>&1 >/dev/null; then
        echo "Can't find the command 'gtimeout'. Run 'brew install coreutils' to install it."
        exit 1
    fi
fi


####################################################
# Step 2: Repeat a-d for each batch
#  a. Generate random samples using updated.weights 
#     for each batch. Initial updated.weights file 
#     is same as $START_WEIGHTS_FILE.
#  b. Compile samples in parallel.
#  c. Run each sample sequentially.
#  d. Retrain and generate new updated.weights file.

CXX_X86=clang++
CXXFLAGS_X86="-std=c++17 -DHALIDE_NO_PNG -DHALIDE_NO_JPEG"
LDFLAGS_X86=" -lpthread -ldl -fPIE -pie"
#TARGET="x86-64-linux-avx-avx2-f16c-fma-sse41"
TARGET="host"

AUTOSCHED_BIN=${HALIDE_INSTALL_ROOT}/lib

OFFSET=0

# Don't clobber existing samples
if [[ $(ls -A build_x86_samples/samples/batch*) ]];
then
    FIRST=$(ls -d ${SAMPLES}/batch_* 2>/dev/null | sed -e "s|.*/batch_||;s|_.*||" | sort -n | tail -n1)
else
    FIRST="50000";
fi

if [ $(uname -s) = "Darwin" ]; then
    LOCAL_CORES=`sysctl -n hw.ncpu`
else
    LOCAL_CORES=`nproc`
fi
echo Local number of cores detected as ${LOCAL_CORES}

echo Using $OFFSET starting Batch number $((FIRST+OFFSET+1))

for ((BATCH_ID=$((FIRST+OFFSET+1));BATCH_ID<$((FIRST+OFFSET+1+NUM_BATCHES));BATCH_ID++)); do

    # Track time for compile and run/retrain
    COMPILE_SEC=0
    RUN_SEC=0
    TRAIN_SEC=0

    for ((EXTRA_ARGS_IDX=0;EXTRA_ARGS_IDX<${#GENERATOR_ARGS_SETS_ARRAY[@]};EXTRA_ARGS_IDX++)); do

    	# 2a: Generate random samples and 
    	# 2b: Compile generated samples in parallel
	echo "###### [BATCH $BATCH_ID] Step 2a-2b: Generating random samples and compile them in parallel..."

	SECONDS=0

        # Compile a batch of samples using the generator in parallel
        DIR=${SAMPLES}/batch_${BATCH_ID}_${EXTRA_ARGS_IDX}

        # Copy the weights being used into the batch folder so that we can repro failures
        mkdir -p ${DIR}/
        cp ${WEIGHTS} ${DIR}/used.weights

        EXTRA_GENERATOR_ARGS=${GENERATOR_ARGS_SETS_ARRAY[EXTRA_ARGS_IDX]/;/ }
        if [ ! -z "${EXTRA_GENERATOR_ARGS}" ]; then
            echo "Adding extra generator args (${EXTRA_GENERATOR_ARGS}) for batch_${BATCH_ID}"
        fi

        echo ${EXTRA_GENERATOR_ARGS} > ${DIR}/extra_generator_args.txt


        # Do parallel compilation in batches, so that machines with fewer than BATCH_SIZE cores
        # don't get swamped and timeout unnecessarily
        echo -n Compiling ${BATCH_SIZE} samples
        for ((SAMPLE_ID=0;SAMPLE_ID<${BATCH_SIZE};SAMPLE_ID++)); do
            while [[ 1 ]]; do
                RUNNING=$(jobs -r | wc -l)
                if [[ RUNNING -ge LOCAL_CORES ]]; then
                    sleep 1
                else
                    break
                fi
            done

            S=$(printf "%04d%04d" $BATCH_ID $SAMPLE_ID)
            FNAME=${PIPELINE}
            make_featurization "${DIR}/${SAMPLE_ID}" $S $FNAME $BATCH_ID "$EXTRA_GENERATOR_ARGS" &
            echo -n .
        done
        wait
        echo  done.

	COMPILE_SEC=`expr ${COMPILE_SEC} + ${SECONDS}`

   	# 2c: Benchmark each sample serially
	echo "###### [BATCH $BATCH_ID] Step 2c: Benchmarking generated samples serially..."

	SECONDS=0

	for ((SAMPLE_ID=0;SAMPLE_ID<${BATCH_SIZE};SAMPLE_ID++)); do
            S=$(printf "%04d%04d" $BATCH_ID $SAMPLE_ID)
            FNAME=${PIPELINE}
	
            benchmark_sample "${DIR}/${SAMPLE_ID}" $S $BATCH_ID $FNAME
	done
	echo done.

	RUN_SEC=`expr ${RUN_SEC} + ${SECONDS}`

    done

    echo "###### BATCH ${BATCH_ID} took ${COMPILE_SEC} seconds to compile."
    echo "###### BATCH ${BATCH_ID} took ${RUN_SEC} seconds to run."
done
