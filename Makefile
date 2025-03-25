SHELL := /bin/bash

PROJECT := wiimnowplaying
REPOSITORY := apwiggins

# Manually set the version
VERSION := v1.6

# Build for AMD64
build_amd64: Dockerfile.amd64
	docker build -f Dockerfile.amd64 -t $(REPOSITORY)/$(PROJECT):$(VERSION) --build-arg VERSION=$(VERSION) .
	docker build -f Dockerfile.amd64 -t $(REPOSITORY)/$(PROJECT):$(VERSION)-amd64 --build-arg VERSION=$(VERSION) .
	docker tag $(REPOSITORY)/$(PROJECT):$(VERSION) $(REPOSITORY)/$(PROJECT):latest

# Build for ARM64
build_arm64: Dockerfile.arm64
	docker build -f Dockerfile.arm64 -t $(REPOSITORY)/$(PROJECT):$(VERSION)-arm64 --build-arg VERSION=$(VERSION) .
	docker tag $(REPOSITORY)/$(PROJECT):$(VERSION)-arm64 $(REPOSITORY)/$(PROJECT):latest-arm64

# Push AMD64 image
push_amd64: build_amd64
	docker push $(REPOSITORY)/$(PROJECT):$(VERSION)
	docker push $(REPOSITORY)/$(PROJECT):$(VERSION)-amd64
	docker push $(REPOSITORY)/$(PROJECT):latest

# Push ARM64 image
push_arm64: build_arm64
	docker push $(REPOSITORY)/$(PROJECT):$(VERSION)-arm64
	docker push $(REPOSITORY)/$(PROJECT):latest-arm64

# Create and push a multi-arch manifest for 'latest'
manifest: push_amd64 push_arm64
	docker manifest create $(REPOSITORY)/$(PROJECT):latest \
		--amend $(REPOSITORY)/$(PROJECT):latest \
		--amend $(REPOSITORY)/$(PROJECT):latest-arm64

	docker manifest push $(REPOSITORY)/$(PROJECT):latest

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@echo "  build_amd64   Build the Docker image for AMD64"
	@echo "  build_arm64   Build the Docker image for ARM64"
	@echo "  push_amd64    Push the AMD64 image to Docker Hub"
	@echo "  push_arm64    Push the ARM64 image to Docker Hub"
	@echo "  manifest      Create and push a multi-arch manifest for 'latest'"
	@echo "  help          Show this help message"

.PHONY: help

