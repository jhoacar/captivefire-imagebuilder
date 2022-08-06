#!/bin/bash

# Autor: Jhoan Carrero

DOCKER_TAG="bcm27xx-bcm2710-openwrt-21.02"

DOCKER_IMAGE="openwrtorg/imagebuilder:$DOCKER_TAG"

DOCKER_FOLDER="/home/build/builder"

FOLDER_DEVICE=$(dirname -- "$( readlink -f -- "$0"; )")

OUTPUT_FOLDER_IMAGE="image"
INPUT_FILES_IMAGE="files"

#Specifies the target image to build
PROFILE="rpi-3" 	

#A list of packages to embed into the image
PHP_EXTENSIONS="php8-mod-iconv php8-mod-mbstring php8-mod-curl php8-mod-zip php8-mod-phar"
PACKAGES="uhttpd luci luci-ssl php8 php8-cgi $PHP_EXTENSIONS"

#Directory with custom files to include
FILES="$DOCKER_FOLDER/$INPUT_FILES_IMAGE" 	

#Alternative output directory for the images
BIN_DIR="$DOCKER_FOLDER/$OUTPUT_FOLDER_IMAGE" 	

#Add this to the output image filename (sanitized)
EXTRA_IMAGE_NAME="" 	

#The names of services from /etc/init.d to disable, e.g. dhcp for dnsmasq 
DISABLED_SERVICES=""

COMMAND="make image "
COMMAND+="PROFILE='$PROFILE' "
COMMAND+="PACKAGES='$PACKAGES' "
COMMAND+="FILES='$FILES' "
COMMAND+="BIN_DIR='$BIN_DIR' "
COMMAND+="EXTRA_IMAGE_NAME='$EXTRA_IMAGE_NAME' "
COMMAND+="DISABLED_SERVICES='$DISABLED_SERVICES' "

# Show available profiles
# COMMAND="make info";

docker run --rm -v $FOLDER_DEVICE:$DOCKER_FOLDER $DOCKER_IMAGE bash -c "$COMMAND"