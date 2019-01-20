#!/bin/bash

# edit splash screen live CD
# casper/initrd.lz

if [ $# -eq 0 ]; then
	echo "No arguments provided"
	echo "with -h to print help and arguments"
	echo ""
	exit 1
fi

if [ $# -eq 1 ]; then
	echo "Missing 2nd arguments"
	echo "with -h to print help and arguments"
	echo ""
	exit 1
fi

if [ "$1" == "-h" ]; then
	echo "Usage:"
	echo "modscr old-initrd.lz initrd.lz"
	echo ""
	echo "new file must initrd.lz, you need to rename source file first."
	echo ""
	exit 0
fi

OLDIR="$PWD"
SOURCE=`realpath $1`
DEST=`realpath $2`

mkdir /tmp/000-initrd
cd /tmp/000-initrd

echo "Extracting"
lzma -dc -S .lz $SOURCE | cpio -imvd --no-absolute-filenames

echo "Modifying"
rm -f usr/share/plymouth/themes/xubuntu-logo/logo.png
rm -f usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/logo.png -O usr/share/plymouth/themes/xubuntu-logo/logo.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/wallpaper.png -O usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
chmod 644 usr/share/plymouth/themes/xubuntu-logo/logo.png
chmod 644 usr/share/plymouth/themes/xubuntu-logo/wallpaper.png

echo "Building... Please Wait..."
find . | cpio --create --format='newc' | lzma -7 > $DEST
sleep 5

echo "Done!!!"
rm -rf /tmp/000-initrd

cd "$OLDIR"

exit 0
