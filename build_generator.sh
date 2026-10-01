#!/bin/bash

set -e

export HALIDE_ROOT=/home/bhirani2/cosmos/deeptuner/Halide
BASELOC=`pwd`
PIPELINE="random_pipeline"
# Both overridable, e.g. to build the old-operator-set generator alongside the
# default one:
#   GENERATOR_SRC=random_pipeline_generator_oldops.cpp \
#   BLD_TOP=$(pwd)/build_x86_generator_oldops bash build_generator.sh
BLD_TOP=${BLD_TOP:-${BASELOC}/build_x86_generator_deeptuner}
GENERATOR_SRC=${GENERATOR_SRC:-random_pipeline_generator.cpp}


#########################################
# Step 1: Build random pipeline generator

echo "###### Step 1: Building random_pipeline.generator and runtime for it..." 

if [ ! -d ${BLD_TOP} ];
then
    BLD_TOP=${BLD_TOP} GENERATOR_SRC=${GENERATOR_SRC} CXX=clang++ PIPELINE_SEED=0001 HALIDE_ROOT=${HALIDE_ROOT} make clean build
echo "...Done. Continue to next step"
else
    echo "...Already built. Continue to next step."
fi;

