CXX ?= g++

CXX_FLAGS :=
CXX_FLAGS += -Wall
CXX_FLAGS += -Wno-unknown-pragmas
CXX_FLAGS += -Wno-unused-label

LD_FLAGS :=

VPATH :=
VPATH += tb
VPATH += src

TB_SRCS := tb.cpp
DUT_SRCS :=

SRCS := $(TB_SRCS) $(DUT_SRCS)

INC_DIR :=
INC_DIR += -Itb
INC_DIR += -Isrc
INC_DIR += -I$(MGC_HOME)/shared/include

LD_DIR :=
LD_DIR += -B/usr/lib/x86_64-linux-gnu

SIM_DIR := sim
OBJ_DIR := sim

TARGET := $(SIM_DIR)/simple

OBJS := $(SRCS:%.cpp=$(OBJ_DIR)/%.o)

$(TARGET): $(OBJS)
	@echo "INFO: LD $< -> $@"
	@$(CXX) $(LD_FLAGS) $(LD_DIR) $< -o $@

$(OBJ_DIR)/%.o: %.cpp
	@echo "INFO: CXX $< -> $@"
	@$(CXX) $(CXX_FLAGS) $(INC_DIR) -c $< -o $@

sim: $(TARGET)
	@echo "INFO: RUN $(TARGET)"
	@./$(TARGET)
.PHONY: sim

clean-sim:
	@echo "INFO: Cleaning simulation directory..."
	@rm -f $(OBJS) $(TARGET)
.PHONY: clean-sim
