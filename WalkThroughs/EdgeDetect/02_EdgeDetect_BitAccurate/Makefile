help:
	@echo "Usage: make <tab> for targets"
.PHONY: help

COMMON_DIR := ../Common

DIFF ?= vimdiff

#GUI ?= 0

include sim/sim.mk
#include syn/syn.mk

compare:
	@$(DIFF) \
		../01_EdgeDetect_Algorithm/src/EdgeDetect_Algorithm.h \
		src/EdgeDetect_BitAccurate.h
.PHONY: compare

clean: clean-sim #clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
