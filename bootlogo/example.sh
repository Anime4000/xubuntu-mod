#!/bin/bash

# put this script inside Cubic project folder
# make sure run outside Cubic chroot
# make sure run as root

SCRIPT_HOME=`pwd`

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bootlogo/splash.png -O "${SCRIPT_HOME}/custom-live-iso/isolinux/splash.png"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bootlogo/splash.pcx -O "${SCRIPT_HOME}/custom-live-iso/isolinux/splash.pcx"

rm -rf "${SCRIPT_HOME}/bootlogo"
mkdir "${SCRIPT_HOME}/bootlogo"
cd "${SCRIPT_HOME}/bootlogo"
cpio -i < ../original-iso-mount/isolinux/bootlogo

cp -vf "${SCRIPT_HOME}/custom-live-iso/isolinux/splash.png" ./splash.png
cp -vf "${SCRIPT_HOME}/custom-live-iso/isolinux/splash.pcx" ./splash.pcx

rm -f ../custom-live-iso/isolinux/bootlogo
ls | cpio -ov > ../custom-live-iso/isolinux/bootlogo

## Example command
# mkdir bootlogo.dir
# cd bootlogo.dir
# cpio -i < ../bootlogo
# ls | cpio -ov > ../bootlogo.new
