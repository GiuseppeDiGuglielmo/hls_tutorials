HLS := catapult

HLS_PROJECT := run_filter_prj

DATA_OUT_CSIM := sim/people_gray_catapult_csim.bmp
DATA_OUT_COSIM := sim/people_gray_catapult_cosim.bmp

CATAPULT_FLAGS := -e "set COMMON_DIR $(COMMON_DIR)" -f $(DESIGN).tcl
syn:
	@cd syn && \
	$(if $(filter $(GUI),1), catapult $(CATAPULT_FLAGS), catapult -shell $(CATAPULT_FLAGS))
.PHONY: syn

gui:
	cd syn/catapult && catapult
.PHONY: gui

clean-syn:
	@echo "INFO: Cleaning synthesis directory..."
	@cd syn && rm -rf Catapult* *.ccs *.log *.pinfo $(DATA_OUT_CSIM) $(DATA_OUT_COSIM)
.PHONY: clean-syn
