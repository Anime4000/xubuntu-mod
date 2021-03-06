#!/bin/bash

# put this script inside Cubic project folder
# make sure run outside Cubic chroot
# make sure run as root

SCRIPT_HOME=`pwd`

rm -f "${SCRIPT_HOME}/bootlogo.new"

rm -rf "${SCRIPT_HOME}/bootlogo.data"
mkdir -p "${SCRIPT_HOME}/bootlogo.data"
cd "${SCRIPT_HOME}/bootlogo.data"

cpio -i < ../original-iso-mount/isolinux/bootlogo

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bootlogo/splash.png -O "../custom-live-iso/isolinux/splash.png"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bootlogo/splash.pcx -O "../custom-live-iso/isolinux/splash.pcx"
cp -vf "../custom-live-iso/isolinux/splash.png" ./splash.png
cp -vf "../custom-live-iso/isolinux/splash.pcx" ./splash.pcx

ls | cpio -ov > ../bootlogo.new

echo "OKAY!"
sleep 3s
exit 0

## Example command
# mkdir bootlogo.dir
# cd bootlogo.dir
# cpio -i < ../bootlogo
# ls | cpio -ov > ../bootlogo.new
