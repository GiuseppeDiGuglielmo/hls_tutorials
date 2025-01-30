help:
	@echo "Usage: make <tab> for targets"
.PHONY: help

COMMON_DIR := $(PWD)/../Common

DIFF ?= vimdiff

GUI ?= 0

DATA_IN := $(COMMON_DIR)/data/image/people_gray.bmp

include sim/sim.mk
include syn/syn.mk

compare:
	@$(DIFF) \
		../04_EdgeDetect_MemoryArch/src/EdgeDetect_MemoryArch.h \
		src/EdgeDetect_Hierarchy.h
.PHONY: compare

clean: clean-sim clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
