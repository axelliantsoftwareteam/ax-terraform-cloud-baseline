SHELL := /bin/bash

PYTHON ?= python3
ENV ?= dev

.PHONY: setup lint test run smoke bootstrap plan apply docker-build

setup:
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements-dev.txt
	pre-commit install

lint:
	terraform fmt -check -recursive
	ruff check tools tests

test:
	pytest -q

run:
	$(PYTHON) tools/tf_runner.py plan --env $(ENV) --dry-run

smoke:
	./scripts/terraform_validate_all.sh

bootstrap:
	$(PYTHON) tools/tf_runner.py bootstrap --env $(ENV) --dry-run

plan:
	$(PYTHON) tools/tf_runner.py plan --env $(ENV) --dry-run

apply:
	$(PYTHON) tools/tf_runner.py apply --env $(ENV) --dry-run

docker-build:
	docker build -t ax-terraform-cloud-baseline:local .
