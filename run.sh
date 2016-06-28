#!/bin/bash

docker run \
  -it \
  -v /home/mfinkel/.ssh:/root/.ssh/ \
  -v /home/mfinkel/src/opsys/cirrus:/workspace/ \
  -u `stat -c "%u:%g" /home/mfinkel/src/opsys/cirrus` \
  devenv:mfinkel /bin/bash
