HLS_PROJECT := simple_prj

CATAPULT_FLAGS := -e "set HLS_PROJECT $(HLS_PROJECT)" -f syn.tcl

syn:
	@echo "INFO: Run Catapult HLS ($(HLS_PROJECT))"
	@cd syn && \
	$(if $(filter $(GUI),1), catapult $(CATAPULT_FLAGS), catapult -shell $(CATAPULT_FLAGS))
.PHONY: syn

gui:
	@echo "INFO: Start Catapult HLS GUI ($(HLS_PROJECT))"
	@cd syn && catapult Catapult.ccs
.PHONY: gui

clean-syn:
	@echo "INFO: Cleaning synthesis directory..."
	@cd syn && rm -rf Catapult* *.ccs *.log *.pinfo
PHONY: clean-syn
