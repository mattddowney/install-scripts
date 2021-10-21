#!/bin/bash
# install jenkins on ubuntu 64 bit

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

# install openjdk
apt-get install -y openjdk-11-jdk

# add the jenkins repo
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'

# update the apt package repository
apt-get update

# install the latest version of docker
apt-get install -y jenkins
