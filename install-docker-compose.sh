#!/bin/bash

dockerComposeVersion=$1

# ensure a version number is passed in
if [ -z "$dockerComposeVersion" ]
then
    echo "Usage: $0 <docker_compose_version_number>"
    exit 1
fi

curl -L "https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
