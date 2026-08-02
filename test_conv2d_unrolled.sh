#!/bin/bash

# Regression test for convolve2D_unrolled().
#
# convolve2D_unrolled() unrolls the input channels, so it used to produce a
# Func whose value did not depend on the output channel argument at all.
# That is fatal when the only consumer uses it as a channel index (which is
# what slice() does): inlining the conv constant-folds the index expression
# away, every Func feeding that index loses its last consumer, and codegen
# then dies on the bounds symbols those orphaned Funcs never got
# ("Symbol not found", CodeGen_LLVM.cpp). Whether it blows up depends on the
# schedule the autoscheduler happens to pick, so the deterministic part of
# this test is the invariant itself, not the compile.
#
# Two cases are run:
#   A. A pipeline forced (via the controlled RNG) to be exactly
#      unrolled conv2D -> slice, i.e. the shape that crashed.
#   B. Plain pipeline seeds 0..NUM_SEEDS-1 with no controlled RNG, which is
#      how the original failure was produced.
# Both check that every unrolled conv2D Func varies with its output channel,
# and then autoschedule and compile the pipeline through LLVM codegen.
#
# Env overrides: HALIDE_INSTALL_ROOT, CXX, TARGET, NUM_SEEDS, MAX_STAGES,
#                WEIGHTS, HL_USE_LIBTORCH_COST_MODEL

set -u

BASELOC=$(cd "$(dirname "$0")" && pwd)
cd "${BASELOC}"

export HALIDE_INSTALL_ROOT=${HALIDE_INSTALL_ROOT:-/home/bhavya/cosmos/life/UIUC/academics/research/halide/halide-install-all/halide-install-libtorch-mod}
CXX=${CXX:-clang++}
TARGET=${TARGET:-host}
NUM_SEEDS=${NUM_SEEDS:-16}
MAX_STAGES=${MAX_STAGES:-20}

export HL_USE_LIBTORCH_COST_MODEL=${HL_USE_LIBTORCH_COST_MODEL:-1}
if [ "${HL_USE_LIBTORCH_COST_MODEL}" = "1" ]; then
    WEIGHTS=${WEIGHTS:-${BASELOC}/weights_archive/baseline_libtorch.pt}
else
    WEIGHTS=${WEIGHTS:-${BASELOC}/weights_archive/baseline.weights}
fi
export HL_PERMIT_FAILED_UNROLL=1

AUTOSCHED_PLUGIN=${HALIDE_INSTALL_ROOT}/lib/libautoschedule_adams2019.so

BLD=${BLD:-${BASELOC}/build_tests}
TEST_BIN=${BLD}/test_conv2d_unrolled
OUT=${BLD}/out
mkdir -p "${OUT}"

# ---------------------------------------------------------------
# Build. The test #includes random_pipeline_generator.cpp so that it can
# build pipelines in-process and poke at the Funcs the generator produced.
# ---------------------------------------------------------------
echo "###### Building ${TEST_BIN}..."
${CXX} -std=c++17 \
    -I "${HALIDE_INSTALL_ROOT}/include" \
    -I "${HALIDE_INSTALL_ROOT}/share/tools" \
    -Wall -Wno-unused-function -fno-rtti -rdynamic \
    test_conv2d_unrolled.cpp "${HALIDE_INSTALL_ROOT}/lib/libHalide.so" \
    -o "${TEST_BIN}" \
    -ldl -lpthread -lz -Wl,-rpath,"${HALIDE_INSTALL_ROOT}/lib" || exit 1

if [ ! -f "${WEIGHTS}" ]; then
    echo "ERROR: weights ${WEIGHTS} not found" >&2
    exit 1
fi

PASS=0
FAIL=0
SKIP=0
CONVS=0

run_case() {
    NAME=$1
    SEED=$2
    STAGES=$3
    # Pass "strict" to refuse to skip a pipeline the generator can't build.
    STRICT=${4:-}
    LOG=${OUT}/${NAME}.log

    "${TEST_BIN}" --seed "${SEED}" --max-stages "${STAGES}" --target "${TARGET}" \
        --autoscheduler "${AUTOSCHED_PLUGIN}" --weights "${WEIGHTS}" \
        --out "${OUT}/${NAME}" > "${LOG}" 2>&1
    EXIT=$?

    N=$(sed -n 's/.*checked \([0-9]*\) unrolled conv2D func(s).*/\1/p' "${LOG}")
    N=${N:-0}
    CONVS=$((CONVS + N))

    if [ ${EXIT} -eq 0 ] && grep -q "compiled ok" "${LOG}"; then
        PASS=$((PASS + 1))
        echo "  PASS ${NAME} (${N} unrolled conv2D func(s))"
    elif [ ${EXIT} -eq 2 ] && [ -z "${STRICT}" ]; then
        # The generator could not build this pipeline at all - a different
        # bug from the one this test covers, so don't call it a failure.
        SKIP=$((SKIP + 1))
        echo "  SKIP ${NAME} - generator could not build the pipeline:"
        grep "pipeline construction failed" "${LOG}" | sed 's/^/    /'
    else
        FAIL=$((FAIL + 1))
        echo "  FAIL ${NAME} (exit ${EXIT}) - see ${LOG}"
        grep -E "^FAIL|Error|error:" "${LOG}" | head -5 | sed 's/^/    /'
    fi
}

# ---------------------------------------------------------------
# Case A: force the exact shape that crashed.
#
# Prescribed RNG values, one chunk per stage (see ControlledRNG):
#   chunk 0: boundary condition          -> repeat_edge
#   chunk 1: stage 0 - stage_type=3 (convolve2D), kernel [0, 1],
#            conv_type=0 (unrolled), 6 output channels
#   chunk 2: stage 1 - operands, stage_type=13 (slice)
# The conv has more channels than the input, so slice() uses the conv as the
# thing being indexed, and the input as the index - the chain that used to
# collapse. Later stages fall back to the seeded mt19937.
# ---------------------------------------------------------------
CHOICES=${OUT}/forced_conv_slice.choices
cat > "${CHOICES}" <<'EOF'
1 1
5 3 5 1 0 5
3 0 0 13
EOF

echo "###### Case A: forced unrolled conv2D -> slice"
export HL_RNG_CHOICES_FILE=${CHOICES}
for SEED in 0 1 2 3; do
    run_case "forced_seed_${SEED}" "${SEED}" "${MAX_STAGES}"
done
unset HL_RNG_CHOICES_FILE

# ---------------------------------------------------------------
# Case B: uncontrolled RNG, plain pipeline seeds.
# ---------------------------------------------------------------
echo "###### Case B: pipeline seeds 0..$((NUM_SEEDS - 1)), no controlled RNG"
for ((SEED = 0; SEED < NUM_SEEDS; SEED++)); do
    run_case "seed_${SEED}" "${SEED}" "${MAX_STAGES}"
done

# ---------------------------------------------------------------
# Case C: seeds that used to fail outright, pinned so they can't regress
# back into a SKIP. The stage count matters, so it is not overridable here.
#   15: aggregation_stage picked dimension 2 of a 1-channel stage. The
#       reduction coordinate clamped to a single point, simplify() dropped
#       the RVar, and sum() rejected the resulting expression.
# ---------------------------------------------------------------
echo "###### Case C: previously-failing pipeline seeds"
for SEED in 15; do
    run_case "regression_seed_${SEED}" "${SEED}" 20 strict
done

echo "###### ${PASS} passed, ${FAIL} failed, ${SKIP} skipped; ${CONVS} unrolled conv2D func(s) checked"
if [ ${CONVS} -eq 0 ]; then
    echo "ERROR: no unrolled conv2D funcs were generated - the test checked nothing" >&2
    exit 1
fi
[ ${FAIL} -eq 0 ] || exit 1
echo "###### OK"
