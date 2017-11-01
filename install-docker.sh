#!/bin/bash
# install docker on ubuntu 64 bit

# install required packages
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# add the docker repo key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the docker repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# update the apt package repository
apt-get update

# install the latest version of docker
apt-get install -y docker-ce
