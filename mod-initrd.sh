#!/bin/bash

# Run this outside chroot!
# Run this script inside Cubic project folder

echo "Modify Splash Screen (initramfs)"

SCRIPT_HOME=`pwd`
INITRD_FILE="boot/initrd.img-4.18.0-10-generic"

cd "squashfs-root"

mkdir -p tmp/000-initrd
unmkinitramfs ${INITRD_FILE} tmp/000-initrd

wget --no-check-certificate https://raw.githubusercontent.com/Anime4000/xubuntu-mod/master/plymouth/logo.png -O "tmp/000-initrd/main/usr/share/plymouth/themes/xubuntu-logo/logo.png"
wget --no-check-certificate https://raw.githubusercontent.com/Anime4000/xubuntu-mod/master/plymouth/logo_16bit.png -O "tmp/000-initrd/main/usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png"
wget --no-check-certificate https://raw.githubusercontent.com/Anime4000/xubuntu-mod/master/plymouth/wallpaper.png -O "tmp/000-initrd/main/usr/share/plymouth/themes/xubuntu-logo/wallpaper.png"

mkinitramfs -o ${INITRD_FILE}
