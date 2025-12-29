SHELL := /bin/bash

#PROJECT := wiimnowplaying-test
PROJECT := wiimnowplaying
REPOSITORY := apwiggins
IMAGE := $(REPOSITORY)/$(PROJECT)


# Manually set the version
VERSION := v1.7.2

# Build for AMD64
build_amd64: Dockerfile.amd64
	docker build -f Dockerfile.amd64 -t $(IMAGE):$(VERSION) --build-arg VERSION=$(VERSION) .
	docker build -f Dockerfile.amd64 -t $(IMAGE):$(VERSION)-amd64 --build-arg VERSION=$(VERSION) .
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest

# Build for ARM64
build_arm64: Dockerfile.arm64
	docker build -f Dockerfile.arm64 -t $(IMAGE):$(VERSION)-arm64 --build-arg VERSION=$(VERSION) .
	docker tag $(IMAGE):$(VERSION)-arm64 $(IMAGE):latest-arm64

# Push AMD64 image
push_amd64: build_amd64
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-amd64
	docker push $(IMAGE):latest

# Push ARM64 image
push_arm64: build_arm64
	docker push $(IMAGE):$(VERSION)-arm64
	docker push $(IMAGE):latest-arm64

# Create and push a multi-arch manifest for 'latest'
manifest: push_arm64 push_amd64
	docker manifest rm $(IMAGE):$(VERSION) || true
	docker manifest rm $(IMAGE):latest || true
	docker manifest create $(IMAGE):$(VERSION) \
		--amend $(IMAGE):$(VERSION)-amd64 \
		--amend $(IMAGE):$(VERSION)-arm64
	docker manifest push $(IMAGE):$(VERSION)

	docker manifest create $(IMAGE):latest \
		--amend $(IMAGE):$(VERSION)-amd64 \
		--amend $(IMAGE):$(VERSION)-arm64
	docker manifest push $(IMAGE):latest

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
