#!/bin/bash

DOWNLOAD_PACKAGE_NAME="docker-compose-Linux-x86_64"

# ensure user is root
if [ "$EUID" -ne 0 ]
  then echo "Must be run as root. Aborting."
  exit 1
fi

# get the latest release info from the github API
api_output=$(curl https://api.github.com/repos/docker/compose/releases/latest)

# get the currently installed version
installed_version=$(docker-compose -v | cut -d' ' -f3 | cut -d',' -f1)

# get the latest version from the api output
latest_version=$(echo "$api_output" | jq -r .name)

# if current version is the latest, don't install
if [ "$installed_version" == "$latest_version" ]
then
    echo "$installed_version already the latest version"
    exit
fi

# get the download link from the api output
download_url=$(echo "$api_output" | jq -r ".assets[] | select(.name == \"$DOWNLOAD_PACKAGE_NAME\") | .browser_download_url")

# download and install
curl -L "$download_url" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
