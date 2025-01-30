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
		../05_EdgeDetect_Hierarchy/src/EdgeDetect_Hierarchy.h \
		src/EdgeDetect_SinglePort.h
.PHONY: compare

clean: clean-sim clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
