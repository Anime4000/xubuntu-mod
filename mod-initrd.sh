#!/bin/bash

# put this script inside Cubic project folder
# make sure run outside Cubic chroot
# make sure run as root

echo "Modify Splash Screen (initrd)"

SCRIPT_HOME=`pwd`

rm -rf "${SCRIPT_HOME}/initrd"
mkdir "${SCRIPT_HOME}/initrd"
cd "${SCRIPT_HOME}/initrd"

unmkinitramfs ../original-iso-mount/casper/initrd ./

rm -f main/usr/share/plymouth/themes/xubuntu-logo/logo.png
rm -f main/usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png
rm -f main/usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
cp ../squashfs-root/usr/share/plymouth/themes/xubuntu-logo/logo.png main/usr/share/plymouth/themes/xubuntu-logo/logo.png
cp ../squashfs-root/usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png main/usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png
cp ../squashfs-root/usr/share/plymouth/themes/xubuntu-logo/wallpaper.png main/usr/share/plymouth/themes/xubuntu-logo/wallpaper.png

rm -f ../custom-live-iso/casper/initrd
mkinitramfs -c xz -o ../custom-live-iso/casper/initrd

cd ..
