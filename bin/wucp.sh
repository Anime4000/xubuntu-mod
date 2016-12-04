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

folders=""
cd "$1"

if [ -d "Desktop" ]; then
	folders="$folders Desktop"
	echo "Folder found: Desktop"
fi

if [ -d "Documents" ]; then
	folders="$folders Documents"
	echo "Folder found: Documents"
fi

if [ -d "Downloads" ]; then
	folders="$folders Downloads"
	echo "Folder found: Downloads"
fi

if [ -d "Music" ]; then
	folders="$folders Music"
	echo "Folder found: Music"
fi

if [ -d "Pictures" ]; then
	folders="$folders Pictures"
	echo "Folder found: Pictures"
fi

if [ -d "Videos" ]; then
	folders="$folders Videos"
	echo "Folder found: Videos"
fi

if [[ -z "$folders" ]]; then
	echo "No folders found :("
	exit 2
fi

cd "$1"
clock=`date +%Y-%m-%d_%H-%M-%S`

mkdir "$2/backup_$clock"
gcp -r -f -P $folders "$2/backup_$clock"

echo ""
echo "DONE!!!"
echo ""
exit 0
