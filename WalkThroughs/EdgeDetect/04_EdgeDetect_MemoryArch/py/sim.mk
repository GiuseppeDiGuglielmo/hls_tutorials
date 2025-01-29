PY_HEIGHT := 6
PY_WIDTH := 6
PY_KERNEL := 1 1 1

#PY_RANDOM := --random
#PY_SEED := --seed 42

run-vertical-derivative-py:
	cd py && \
		python vertical_derivative.py \
			$(PY_RANDOM) $(PY_SEED) --kernel $(PY_KERNEL) $(PY_HEIGHT) $(PY_WIDTH)
.PHONY: run-vertical-derivative-py

run-horizontal-derivative-py:
	cd py && \
		python horizontal_derivative.py \
			$(PY_RANDOM) $(PY_SEED) --kernel $(PY_KERNEL) $(PY_HEIGHT) $(PY_WIDTH)
.PHONY: run-horizontal-derivative-py