#!/bin/bash

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

docker rm -f portainer
./install-portainer.sh
