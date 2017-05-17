#!/bin/bash"
# Unmount Clonezilla disk" 
echo 'Unmount clonezilla disk'

devclone1=$(mount | grep '/home' | grep -o -E '(\/dev\/\w+)')
devclone2=$(mount | grep '/tmp' | grep -o -E '(\/dev\/\w+)')

umount $devclone1
umount $devclone2

echo 'DONE! If fails, need run scan disk.'" 
