#!/bin/bash

# Autor: Jhoan Carrero

DEVICES_FOLDER=$(pwd)/devices

DEVICE="tl-mr3020/v1";

# Specifies the target in docker image
DOCKER_TAG=""

# Specifies the target image to build
PROFILE=""

# Show profiles for this target, 0 not show, 1 show
SHOW_INFO=0

# Execute the docker command
EXECUTE_DOCKER_COMMAND=1

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

# Set variables as DOCKER_TAG PROFILE and so on...
eval $(cat $DEVICES_FOLDER/$DEVICE/maker.sh)

# Show available profiles
if [ $SHOW_INFO -eq 1 ]
then
    COMMAND="make info";
fi

# Execute docker command
if [ $EXECUTE_DOCKER_COMMAND -eq 1 ]
then
    DOCKER_COMMAND="docker run --rm -v $HOST_FOLDER_FILES:$DOCKER_FOLDER_FILES -v $HOST_FOLDER_DEVICE:$DOCKER_FOLDER $DOCKER_IMAGE:$DOCKER_TAG bash -c \"$COMMAND\""
    echo "Ejecutando el comando de Docker";
    echo $DOCKER_COMMAND;
    eval $DOCKER_COMMAND;
fi