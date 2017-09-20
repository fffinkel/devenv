#!/usr/bin/make -f

DOCKER_IMAGE := devenv:fffinkel

UID := $(shell id -u)
GID := $(shell id -g)

run: build
	docker run \
		-it \
		-v /home/$(USER)/.ssh:/root/.ssh/ \
		-v /home/$(USER):/workspace/ \
		$(DOCKER_IMAGE)

build:
	docker build \
		--build-arg uid=$(UID) \
		--build-arg gid=$(GID) \
		--build-arg usr=$(USER) \
		-t $(DOCKER_IMAGE) \
		.

clean:
	docker rmi \
		--force \
		$(DOCKER_IMAGE)

