#!/usr/bin/make -f

DOCKER_IMAGE := devenv:mfinkel

run: build
	./run.sh

build:
	docker build --tag $(DOCKER_IMAGE)

clean:
	docker rmi $(DOCKER_IMAGE)

