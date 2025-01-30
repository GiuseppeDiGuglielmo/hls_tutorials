help:
	@echo "Usage: make <tab> for targets"
.PHONY: help

COMMON_DIR := $(PWD)/../Common

DIFF ?= vimdiff

GUI ?= 0

DESIGN := EdgeDetect_Hierarchy

DATA_IN := $(COMMON_DIR)/data/image/people_gray.bmp

include sim/sim.mk
include syn/syn.mk

compare:
	@$(DIFF) \
		../04_EdgeDetect_MemoryArch/src/EdgeDetect_MemoryArch.h \
		src/$(DESIGN).h
.PHONY: compare

compare-mgc:
	vimdiff -R `find $(MGC_HOME) -name $(DESIGN).h` src/$(DESIGN).h
	vimdiff -R `find $(MGC_HOME) -name $(DESIGN)_tb.cpp` tb/$(DESIGN)_tb.cpp
	vimdiff -R `find $(MGC_HOME) -name $(DESIGN).tcl` syn/$(DESIGN).tcl
.PHONY: compare-mgc

clean: clean-sim clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
