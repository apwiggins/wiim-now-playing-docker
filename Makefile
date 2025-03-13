SHELL := /bin/bash

PROJECT := wiimnowplaying
REPOSITORY := apwiggins

BRANCH ?= $(shell git symbolic-ref --short -q HEAD)
VERSION ?= $(shell git describe --abbrev=0)
TAG ?= $(shell if [[ "$(BRANCH)" == "main" ]]; then echo "latest"; else echo $(VERSION); fi)

build: Dockerfile
	docker build -t $(REPOSITORY)/$(PROJECT):$(TAG) --build-arg VERSION=$(VERSION) .

push:
	docker push $(REPOSITORY)/$(PROJECT):$(TAG)

.PHONY: push
