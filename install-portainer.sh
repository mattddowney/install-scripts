#!/bin/bash

DOCKER_IMAGE="portainer/portainer-ce:latest"

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

# ensure docker is installed
command -v docker > /dev/null
if [ "$?" -ne 0 ]
  then echo "Docker not installed. Aborting."
  exit 2
fi

docker pull "$DOCKER_IMAGE"
docker run \
  --name=portainer \
  --restart=always \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=portainer_data:/data \
  --publish=9000:9000 \
  --detach \
  portainer/portainer-ce
