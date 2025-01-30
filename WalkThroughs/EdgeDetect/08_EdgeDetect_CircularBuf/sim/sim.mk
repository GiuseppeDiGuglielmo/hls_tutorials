CXX ?= g++

CXX_FLAGS :=
CXX_FLAGS += -Wall
CXX_FLAGS += -DDEBUG
CXX_FLAGS += -Wno-unknown-pragmas
CXX_FLAGS += -Wno-unused-label
CXX_FLAGS += -Wno-maybe-uninitialized
CXX_FLAGS += -Wno-unused-variable

LD_FLAGS :=

VPATH :=
VPATH += tb
VPATH += src
VPATH += $(MGC_HOME)/shared/include/bmpUtil/

TB_SRCS :=
TB_SRCS += bmp_io.cpp
TB_SRCS += EdgeDetect_CircularBuf_tb.cpp
DUT_SRCS :=

SRCS := $(TB_SRCS) $(DUT_SRCS)

INC_DIR :=
INC_DIR += -Itb
INC_DIR += -Isrc
INC_DIR += -I../01_EdgeDetect_Algorithm/src
INC_DIR += -I$(MGC_HOME)/shared/include
INC_DIR += -I$(COMMON_DIR)/inc
INC_DIR += -I/usr/include/x86_64-linux-gnu

LD_DIR :=
LD_DIR += -B/usr/lib/x86_64-linux-gnu

SIM_DIR := sim
OBJ_DIR := sim

TARGET := $(SIM_DIR)/simple

OBJS := $(SRCS:%.cpp=$(OBJ_DIR)/%.o)

DATA_OUT_REF := sim/people_gray_ref.bmp
DATA_OUT_IMP := sim/people_gray_imp.bmp

$(TARGET): $(OBJS)
	@echo "INFO: LD $(OBJS) -> $@"
	@$(CXX) $(LD_FLAGS) $(LD_DIR) $(OBJS) -o $@

$(OBJ_DIR)/%.o: %.cpp
	@echo "INFO: CXX $< -> $@"
	@$(CXX) $(CXX_FLAGS) $(INC_DIR) -c $< -o $@

sim: $(TARGET)
	@echo "INFO: RUN $(TARGET) $(DATA_IN) $(DATA_OUT_REF) $(DATA_OUT_IMP)"
	@echo "INFO: =========================================================================="
	@./$(TARGET) $(DATA_IN) $(DATA_OUT_REF) $(DATA_OUT_IMP)
	@echo "INFO: =========================================================================="
.PHONY: sim

clean-sim:
	@echo "INFO: Cleaning simulation directory..."
	@rm -f $(OBJS) $(TARGET) $(DATA_OUT_REF) $(DATA_OUT_IMP)
.PHONY: clean-sim
