#!/bin/bash

INSTALL_LOCATION="/usr/local"
SYMLINK_LOCATION="/usr/local/bin"
PLATFORM="linux-amd64"

# get the currently installed version
installed_version=$($INSTALL_LOCATION/go/bin/go version | cut -d' ' -f3)

# get the link for the latest release
download_link=$(curl -s https://golang.org/dl/ | grep 'class="download downloadBox"' | grep $PLATFORM | cut -d'"' -f4)

# parse the link
download_file=$(echo $download_link | cut -d'/' -f5)
download_version=$(echo $download_file | rev | cut -d'.' -f4- | rev)

# if current version is the latest, don't install
if [ "$installed_version" == "$download_version" ]
then
    echo "$installed_version already the latest version"
    exit
fi

# download the release
wget $download_link

# extract the archive to the install location
tar xzf $download_file -C $INSTALL_LOCATION

# create symlinks
ln -s "$INSTALL_LOCATION/go/bin/go" "$SYMLINK_LOCATION/go"
ln -s "$INSTALL_LOCATION/go/bin/gofmt" "$SYMLINK_LOCATION/gofmt"
ln -s "$INSTALL_LOCATION/go/bin/godoc" "$SYMLINK_LOCATION/godoc"

# remove the archive
rm $download_file
