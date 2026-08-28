#!/bin/bash

set -e

export HALIDE_ROOT=/home/bhirani2/cosmos/deeptuner/Halide
BASELOC=`pwd`
PIPELINE="random_pipeline"
BLD_TOP=${BASELOC}/build_x86_generator_deeptuner


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

