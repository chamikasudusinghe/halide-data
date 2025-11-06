HALIDE_ROOT ?= /home/chamika2/upstream/halide-install
HALIDE_INSTALL_ROOT ?= /home/chamika2/upstream/halide-install
CXX ?= /home/chamika2/upstream/llvm-install/bin/clang++
#OPTIMIZE ?= "-std=c++11 -stdlib=libc++" 
CXXFLAGS += $(OPTIMIZE) -std=c++17 -I $(HALIDE_INSTALL_ROOT)/include/ -I $(HALIDE_INSTALL_ROOT)/share/tools/ -I $(SANITIZER_FLAGS) -Wall -Werror -Wno-unused-function -Wcast-qual -Wignored-qualifiers -Wno-comment -Wsign-compare -Wno-unknown-warning-option -Wno-psabi
LDFLAGS ?= -ldl -lpthread -lz

CXX-x86 ?= clang++
CXXFLAGS-x86 ?= -std=c++17 -DHALIDE_NO_PNG -DHALIDE_NO_JPEG
LDFLAGS-x86 ?= -lpthread -ldl -fPIE -pie

LIB_HALIDE ?= $(HALIDE_INSTALL_ROOT)/lib/libHalide.so
GENERATOR_DEPS ?= $(LIB_HALIDE) $(HALIDE_INSTALL_ROOT)/include/Halide.h $(HALIDE_INSTALL_ROOT)/share/tools/GenGen.cpp
GENERATOR_LDFLAGS ?= -Wl,-rpath,$(dir $(LIB_HALIDE))
AUTOSCHED_TOOLS_BIN ?= $(HALIDE_INSTALL_ROOT)/bin
WEIGHTS ?= ${HALIDE_INSTALL_ROOT}/src/autoschedulers/adams2019/baseline.weights
AUTOSCHED_BIN ?=$(HALIDE_INSTALL_ROOT)/lib
USE_EXPORT_DYNAMIC ?= -rdynamic

SRC = $(PWD)
AUTOTUNE_SCRIPT = $(SRC)/autotune_loop.sh
BLD_TOP ?= $(PWD)
BLD_DIR ?= $(BLD_TOP)/random_pipeline
BIN ?= $(BLD_DIR)/bin

PIPELINE_STAGES ?= 20
PIPELINE_SEED ?= 0001
HL_RANDOM_DROPOUT ?= 100
HL_SEED ?= 0
HL_BEAM_SIZE ?= 1
HL_USE_MANUAL_COST_MODEL ?= 0

# Use apps/autoscheduler by default
NEW_AUTOSCHEDULER ?= 1

ifeq ($(NEW_AUTOSCHEDULER),1)
ID = $(HL_TARGET)-new_autoscheduler/pipeline_$(PIPELINE_SEED)_$(PIPELINE_STAGES)/schedule_$(HL_SEED)_$(HL_RANDOM_DROPOUT)_$(HL_BEAM_SIZE)_$(HL_USE_MANUAL_COST_MODEL)
GEN_GEN_ARGS = -p $(AUTOSCHED_BIN)/libauto_schedule.so
AUTOSCHEDULER_DEPS = $(AUTOSCHED_BIN)/libauto_schedule.so
AUTOSCHEDULER_PARAM = autoscheduler=Adams2019
else
ID = $(HL_TARGET)-$(CACHE)-$(BALANCE)/pipeline_$(PIPELINE_SEED)_$(PIPELINE_STAGES)/schedule_$(HL_SEED)_$(HL_RANDOM_DROPOUT)_$(HL_BEAM_SIZE)_$(HL_USE_MANUAL_COST_MODEL)
GEN_GEN_ARGS =
AUTOSCHEDULER_PARAM =
endif

ifeq ($(HL_SEED), root)
AUTO_SCHEDULE=false
else
AUTO_SCHEDULE=true
endif

HL_TARGET ?= x86-64-linux-avx-avx2-f16c-fma-sse41

ifneq (,$(findstring hexagon,$(HL_TARGET)))
USE_HEXAGON = -DHEXAGON
endif

ifneq (,$(findstring hvx,$(HL_TARGET)))
USE_HEXAGON = -DHEXAGON
endif

GENERATOR ?= $(BIN)/random_pipeline.generator
PIPELINE ?= random_pipeline
RUNTIME ?= $(BIN)/runtime.a

$(BIN)/runtime.a: $(GENERATOR)
	$^ -r runtime target=$(HL_TARGET) -o $(BIN)

$(BIN)/random_pipeline.generator: random_pipeline_generator.cpp $(GENERATOR_DEPS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(USE_EXPORT_DYNAMIC) $(USE_HEXAGON) -fno-rtti $(filter-out %.h,$^) -o $@ $(LDFLAGS) $(HALIDE_SYSTEM_LIBS) $(GENERATOR_LDFLAGS)

$(BIN)/random_pipeline.a $(BIN)/random_pipeline.registration.cpp: $(GENERATOR) $(AUTOSCHEDULER_DEPS)
	@mkdir -p $(@D)
	HL_RANDOM_DROPOUT=$(HL_RANDOM_DROPOUT) \
	HL_SEED=$(HL_SEED) \
	HL_BEAM_SIZE=$(HL_BEAM_SIZE) \
	HL_USE_MANUAL_COST_MODEL=$(HL_USE_MANUAL_COST_MODEL) \
	HL_PERMIT_FAILED_UNROLL=1 \
	HL_WEIGHTS_DIR=$(WEIGHTS) \
	$(GENERATOR) -g $(PIPELINE) -o $(BIN) \
	-e stmt,assembly,static_library,c_header,registration,schedule,featurization \
	-f random_pipeline target=$(HL_TARGET)-no_runtime \
	seed=$(PIPELINE_SEED) max_stages=$(PIPELINE_STAGES) $(AUTOSCHEDULER_PARAM) \
	$(GEN_GEN_ARGS) 2> $(BIN)/stderr.txt > $(BIN)/stdout.txt

$(BIN)/test: test.cpp $(BIN)/random_pipeline.a $(RUNTIME)
	@mkdir -p $(@D)
	$(CXX-x86) $(CXXFLAGS-x86) $(CXXFLAGS) -I$(BIN) -Wall -O3 $^ -o $@ $(LDFLAGS-x86)

#####$(CXX-arm) $(CXXFLAGS-arm) $(CXXFLAGS) $(USE_HEXAGON) -I$(BIN) -Wall -O3 $^ -o $@ $(LDFLAGS-arm)

clean:
	rm -rf $(BIN)

$(BIN)/times.txt: $(BIN)/test
	$(BIN)/test > $(BIN)/times.txt
	@cat $(BIN)/times.txt

#build: $(BIN)/test
#bench: $(BIN)/times.txt

$(BIN)/bench: $(HALIDE_INSTALL_ROOT)/share/tools/RunGenMain.cpp $(BIN)/random_pipeline.registration.cpp $(BIN)/random_pipeline.a $(RUNTIME)
	$(CXX-x86) $(CXXFLAGS-x86) $(CXXFLAGS) -I $(BIN) $^ -o $@ $(LDFLAGS-x86)

build: $(BIN)/bench

DEVICE_PATH ?= /data/tmp/random_pipeline

autotune: $(GENERATOR) $(RUNTIME) $(AUTOSCHED_TOOLS_BIN)/featurization_to_sample $(AUTOSCHED_TOOLS_BIN)/retrain_cost_model $(AUTOSCHED_BIN)/libauto_schedule.so $(AUTOTUNE_SCRIPT) # $(DEVICE_SETUP)
	bash $(AUTOTUNE_SCRIPT) \
		$(GENERATOR) \
		random_pipeline \
		$(WEIGHTS) \
		$(AUTOSCHED_TOOLS_BIN) \
		$(BLD_DIR) \
		$(RUNTIME)
