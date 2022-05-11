.PHONY: default build image check publish-images

TAG_NAME := $(shell git tag -l --contains HEAD)

IMAGE_NAME := lurenyang07/whoami

default: check build

build:
	CGO_ENABLED=0 go build -a --trimpath --installsuffix --ldflags="-s -w" -o whoami

check:
	golangci-lint run

image:
	docker build -t $(IMAGE_NAME) .