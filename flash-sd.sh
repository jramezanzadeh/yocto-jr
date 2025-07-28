#!/bin/bash

IMAGE_PATH="build/tmp/deploy/images/raspberrypi3-64"

print_usage(){
 echo "flash-sd.sh <sd device file>"
 echo "For example: ./flash-sd.sh sdb"
 exit
}

if [[ ($# != 1) && ($# != 2) ]]; then
	print_usage
fi

if [[ $# == 2 ]]; then
	TARGET=$2
else
	TARGET="core-image-minimal"
fi

IMAGE_NAME="$TARGET-raspberrypi3-64.wic"
ZIP_IMAGE_NAME="$IMAGE_NAME.bz2"

echo "start flashing $ZIP_IMAGE_NAME ..."
cp $IMAGE_PATH/$ZIP_IMAGE_NAME /tmp
rm /tmp/$IMAGE_NAME > /dev/null 2>&1
echo "unzipping image >>>>"
bzip2 -d /tmp/$ZIP_IMAGE_NAME

# Erase as many blocks as required from the beginning of the SD card
IMAGE_SIZE_MB=$(du -m /tmp/$IMAGE_NAME | cut -f1)
IMAGE_SIZE_MB=$((IMAGE_SIZE_MB+5)) 
echo "Erasing first $IMAGE_SIZE_MB MB of the SD card ..."
sudo dd if=/dev/zero of=/dev/$1 bs=1M status=progress count=$IMAGE_SIZE_MB conv=fsync

echo "flashing the image into the sd ..."
sudo dd  if=/tmp/$IMAGE_NAME of=/dev/$1 bs=1M status=progress conv=fsync
sync

