#!/bin/bash

echo "------------------------------------------"
echo "|          Disk Read Speed Test          |"
echo "------------------------------------------"
echo "           Property of CureComp Technology"
echo "                      Written by Anime4000"

if [ $# -eq 0 ]; then
	echo "No arguments provided"
	echo "with -h to print help and arguments"
	echo ""
	exit 1
fi

if [ "$1" == "-h" ]; then
	echo "Usage:"
	echo "diskspeed source_disk"
	echo ""
	echo "Examples:"
	echo "========="
	echo "diskspeed /dev/sdb1"
	echo "diskspeed /dev/sdc2"
	exit 0
fi

echo "[INFO]: Press CTRL+C to cancel at anytime"
dd if=$1 of=/dev/null status=progress
