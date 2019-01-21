#!/bin/bash

echo "Welcome to deployment!"
clonezilla.sh

echo "Trying to unmount..."
umount -fdR /home/partimag
umount -fdR /tmp/ocsroot_bind_root

sleep 1.5s

echo "CloneZilla Exited..."
exit 0
