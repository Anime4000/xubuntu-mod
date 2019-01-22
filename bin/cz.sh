#!/bin/bash

echo "Welcome to deployment!"

if hash clonezilla.sh 2> /dev/null; then
	echo "clonezilla.sh is found!"
	clonezilla.sh
else
	echo "clonezilla is found!"
	clonezilla
fi

echo "Trying to unmount..."
umount -fdR /home/partimag
umount -fdR /tmp/ocsroot_bind_root

sleep 1.5s

echo "CloneZilla Exited..."
exit 0
