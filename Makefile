ALL_PY_SRCS := action.py \
	sigstore-python-conformance \
	$(shell find test/ -name '*.py') \
	$(shell find tools/ -name '*.py')

.PHONY: all
all:
	@echo "Run my targets individually!"

env/pyvenv.cfg: dev-requirements.txt requirements.txt
	python3 -m venv env
	./env/bin/python -m pip install --upgrade pip
	./env/bin/python -m pip install --requirement dev-requirements.txt --requirement requirements.txt

.PHONY: dev
dev: env/pyvenv.cfg

.PHONY: lint
lint: env/pyvenv.cfg $(ALL_PY_SRCS)
	./env/bin/python -m black $(ALL_PY_SRCS)
	./env/bin/python -m ruff --fix $(ALL_PY_SRCS)
	./env/bin/python -m mypy action.py test/
