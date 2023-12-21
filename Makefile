RIME_USER_DATA_DIR ?= ${CURDIR}
RIME_SHARED_DATA_DIR ?= /usr/share/rime-data

.PHONY: help
help:
	@echo 'make build    -- build (deploy)'
	@echo 'make clean    -- delete generated files'

build: *.yaml
	rime_deployer --build ${RIME_USER_DATA_DIR} ${RIME_SHARED_DATA_DIR}

.PHONY: clean
clean:
	rm -r build/
	rm -r user.yaml installation.yaml *.userdb/ sync/
