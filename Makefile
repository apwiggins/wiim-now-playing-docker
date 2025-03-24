SHELL := /bin/bash

PROJECT := wiimnowplaying
REPOSITORY := apwiggins

# Manually set the version
VERSION := v1.6

build: Dockerfile
	docker build -t $(REPOSITORY)/$(PROJECT):$(VERSION) --build-arg VERSION=$(VERSION) .

push: 
	# Push the versioned image
	docker push $(REPOSITORY)/$(PROJECT):$(VERSION)
	
	# Tag and push the 'latest' version
	docker tag $(REPOSITORY)/$(PROJECT):$(VERSION) $(REPOSITORY)/$(PROJECT):latest
	docker push $(REPOSITORY)/$(PROJECT):latest

.PHONY: push

