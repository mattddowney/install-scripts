#!/bin/bash
# install docker on ubuntu 64 bit

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

# install required packages
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# add the docker repo key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# add the docker repository
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update the apt package repository
apt-get update

# install the latest version of docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
