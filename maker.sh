#!/bin/bash

# Autor: Jhoan Carrero

DEVICES_FOLDER=$(pwd)/devices

DEVICE="raspberry-pi/3b+";

# Specifies the target in docker image
DOCKER_TAG=""

# Specifies the target image to build
PROFILE=""

DOCKER_IMAGE="openwrtorg/imagebuilder"

DOCKER_FOLDER="/home/build/builder"
DOCKER_FOLDER_FILES="/home/build/files"

HOST_FOLDER_DEVICE=$DEVICES_FOLDER/$DEVICE
HOST_FOLDER_FILES=$(pwd)/files

# A list of packages to embed into the image

PHP_EXTENSIONS="php8-mod-iconv php8-mod-mbstring php8-mod-curl php8-mod-zip php8-mod-phar"
PACKAGES="uhttpd luci luci-ssl php8 php8-cgi $PHP_EXTENSIONS"

# Directory with custom files to include
FILES=$DOCKER_FOLDER_FILES 	

# Alternative output directory for the images
BIN_DIR="$DOCKER_FOLDER/image" 	

# Add this to the output image filename (sanitized)
EXTRA_IMAGE_NAME="" 	

# The names of services from /etc/init.d to disable, e.g. dhcp for dnsmasq 
DISABLED_SERVICES=""

COMMAND="make image "
COMMAND+="PROFILE='$PROFILE' "
COMMAND+="PACKAGES='$PACKAGES' "
COMMAND+="FILES='$FILES' "
COMMAND+="BIN_DIR='$BIN_DIR' "
COMMAND+="EXTRA_IMAGE_NAME='$EXTRA_IMAGE_NAME' "
COMMAND+="DISABLED_SERVICES='$DISABLED_SERVICES' "

EXECUTE_DOCKER_COMMAND=1

# Set variables as DOCKER_TAG PROFILE and so on...
eval $(cat $DEVICES_FOLDER/$DEVICE/maker.sh)

# Execute docker command
DOCKER_COMMAND="docker run --rm -v $HOST_FOLDER_FILES:$DOCKER_FOLDER_FILES -v $HOST_FOLDER_DEVICE:$DOCKER_FOLDER $DOCKER_IMAGE:$DOCKER_TAG bash -c \"$COMMAND\""

if [ $EXECUTE_DOCKER_COMMAND -eq 1 ]
then
    echo "Executing docker command";
    echo "$DOCKER_COMMAND";
    eval $DOCKER_COMMAND
fi

