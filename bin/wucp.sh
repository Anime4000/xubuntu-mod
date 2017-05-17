#/bin/bash

echo "----------------------------------------"
echo "| Backup Windows user files and folder |"
echo "----------------------------------------"
echo "         Property of CureComp Technology"
echo "                            by Anime4000"
echo ""
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
	echo "wucp user-folder dest-disk"
	echo ""
	echo "Example:"
	echo "wucp /mount/sda1/Users/Hitoha /mount/sdb1"
	echo ""
	echo "Note:"
	echo "user-folder must end at"
	echo "           /mount/sda1/Users/User"
	echo "           /mount/sda1/Users/Hitoha"
	echo ""
	exit 0
fi

src=""

if [ -d "Desktop" ]; then
	src="'$1/Desktop'"
	echo "Folder found: Desktop"
fi

if [ -d "Documents" ]; then
	src="$src '$1/Documents'"
	echo "Folder found: Documents"
fi

if [ -d "Downloads" ]; then
	src="$src '$1/Downloads'"
	echo "Folder found: Downloads"
fi

if [ -d "Music" ]; then
	src="$src '$1/Music'"
	echo "Folder found: Music"
fi

if [ -d "Pictures" ]; then
	src="$src '$1/Pictures'"
	echo "Folder found: Pictures"
fi

if [ -d "Videos" ]; then
	src="$src '$1/Videos'"
	echo "Folder found: Videos"
fi

clock=`date +%Y-%m-%d_%H-%M-%S`

mkdir "$2/backup_$clock"
rsync -avh --info=progress2 --exclude-from="/etc/cc/exclude.txt" $src "$2/backup_$clock"

echo "---------"
echo " DONE!!! "
echo "---------"
exit 0
