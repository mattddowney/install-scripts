#!/bin/bash
# install the latest version of a hashicorp product
# examples:
# sudo ./install-hashicorp-product.sh packer
# sudo ./install-hashicorp-product.sh terraform
# sudo ./install-hashicorp-product.sh vault

INSTALL_LOCATION="/usr/local/bin"
PLATFORM="linux_amd64"
RELEASE_SERVER="https://releases.hashicorp.com"

product=$1

if [ -z "$product" ]
then
    echo "Usage:"
    echo "    $0 <product>"
    exit
fi

# get current product version, if it exists
absolute_path="$INSTALL_LOCATION/$product"
if [ -e "$absolute_path" ]
then
    product_version=$($absolute_path version | head -1 | cut -d'v' -f2)
fi

# get the first link
release_link=$(curl -s "$RELEASE_SERVER/$product/" | grep "<a href=\"/$product/" | head -1)

# parse the link
release_href=$(echo $release_link | cut -d'"' -f2)
release_version=$(echo $release_link | cut -d'>' -f2 | cut -d'<' -f1 | cut -d'_' -f2 )

# if current version is the latest, don't install
if [ "$product_version" == "$release_version" ]
then
    echo "$product v$product_version already the latest version"
    exit
fi

# build the archive filename
archive_filename="${product}_${release_version}_${PLATFORM}.zip"

# build release url
release_url="${RELEASE_SERVER}${release_href}${archive_filename}"

# backup archive if it exists
if [ -e "$archive_filename" ]
then
    mv -b "$archive_filename" "$archive_filename"
    rm "$archive_filename"
fi

# download the release
wget $release_url

# backup product if it exists
if [ -e "$absolute_path" ]
then
    product_backup_file="$absolute_path~$product_version"

    echo "Backing up existing $product -> $product_backup_file"
    mv -n "$absolute_path" "$product_backup_file"
fi

# unzip the archive to the install location
unzip $archive_filename -d $INSTALL_LOCATION

# remove the archive
rm $archive_filename