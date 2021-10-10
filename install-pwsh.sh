#!/bin/bash
# install pwsh on ubuntu

REPOSITORY="packages-microsoft-prod"

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

# install required packages
apt-get install -y \
    wget \
    apt-transport-https \
    software-properties-common

# add the MS repository keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/$REPOSITORY.deb"
dpkg -i "$REPOSITORY.deb"

# update the repository
apt-get update \
    -o Dir::Etc::sourcelist="sources.list.d/$REPOSITORY.list" \
    -o APT::Get::List-Cleanup="0"

# install pwsh
apt-get install -y powershell

# cleanup
rm "$REPOSITORY.deb"
