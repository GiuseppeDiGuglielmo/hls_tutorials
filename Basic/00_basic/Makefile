help:
	@echo "Usage: make <tab> for targets"
.PHONY: help

GUI ?= 0

include sim/sim.mk
include syn/syn.mk

clean: clean-sim clean-syn
	@echo "INFO: Cleaning done!"
.PHONY: clean
