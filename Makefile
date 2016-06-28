#!/usr/bin/make -f

DOCKER_IMAGE := devenv:mfinkel

UID := $(shell id -u)
GID := $(shell id -g)

run: build
	docker run \
		-it \
		-v /home/mfinkel/.ssh:/root/.ssh/ \
		-v /home/mfinkel/src/opsys/cirrus:/workspace/ \
		$(DOCKER_IMAGE)

#		-e UID=$(UID) \
#		-e GID=$(GID) \
#-u `stat -c "%u:%g" /home/mfinkel/src/opsys/cirrus` \

build:
	docker build \
		--build-arg uid=$(UID) \
		--build-arg gid=$(GID) \
		-t $(DOCKER_IMAGE) \
		.

clean:
	docker rmi \
		$(DOCKER_IMAGE)

