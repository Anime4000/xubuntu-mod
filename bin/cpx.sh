#!/bin/bash

echo "-------------------------------------------"
echo "|  Advanced and Faster Copy Command-Line  |"
echo "|     Much better copy than TeraCopy!     |"
echo "-------------------------------------------"
echo "            Property of CureComp Technology"
echo "                       Written by Anime4000"
echo ""
echo ""
echo "[INFO]: DeepSpar Data Recovery is enabled at compile time"
echo "[INFO]: Error Correction is enabled at compile time"
echo ""
echo ""

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
	echo "cpx [OPTIONS] SRC... DEST"
	echo ""
	echo "Note!"
	echo "====="
	echo "Copy a folder     Example: ./Desktop"
	echo "Copy all content  Example: ./Desktop/"
	echo ""
	echo "Examples:"
	echo "========="
	echo "Copy one or more folder to another disk or folder:"
	echo "cpx /home/user/Desktop /home/user/Documents /mount/sdb1"
	echo ""
	echo "Copy inside folder and a folder to another disk or folder:"
	echo "cpx /home/user/Desktop/ /home/user/Documents /mount/sdb1"
	exit 0
fi

rsync -avh --no-i-r --info=progress2 --exclude=\$RECYCLE.BIN --exclude="System Volume Information" --exclude-from="/etc/cc/exclude.txt" $*
