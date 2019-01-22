#!/bin/bash

SCRIPT_HOME=`pwd`

rm -rf "${SCRIPT_HOME}/initrd.data"
mkdir -p "${SCRIPT_HOME}/initrd.data"
cd "${SCRIPT_HOME}/initrd.data"

# Get offset value of LZMA compressed data
OFFSET=$(binwalk -y lzma ../original-iso-mount/casper/initrd | awk '$3 ~ /LZMA/ { print $1; exit }')

dd if=../original-iso-mount/casper/initrd bs=$OFFSET skip=1 | unlzma -c | cpio -id

rm -f usr/share/plymouth/themes/xubuntu-logo/logo.png
rm -f usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png
rm -f usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/logo.png -O usr/share/plymouth/themes/xubuntu-logo/logo.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/logo_16bit.png -O usr/share/plymouth/themes/xubuntu-logo/logo_16bit.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/wallpaper.png -O usr/share/plymouth/themes/xubuntu-logo/wallpaper.png

find | cpio -H newc -o | lzma -c > ../initrd.lz

dd if=../original-iso-mount/casper/initrd of=../initrd.code bs=512 count=$(($OFFSET/512))

cat ../initrd.code ../initrd.lz > ../initrd.new

echo "OKAY!"
sleep 3s
exit 0
