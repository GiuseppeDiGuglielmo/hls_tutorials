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
		../03_EdgeDetect_Synthesizable/src/EdgeDetect_Synthesizable.h \
		src/EdgeDetect_MemoryArch.h
.PHONY: compare

clean: clean-sim clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
