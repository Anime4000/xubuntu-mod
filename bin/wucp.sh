#/bin/bash
clock=`date +%Y-%m-%d_%H-%M-%S`

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

cd "$PWD"
mkdir -p "$2/backup_$clock"
rsync -avh --info=progress2 --exclude-from="/etc/cc/exclude.txt" "$1/Desktop" "$1/Documents" "$1/Downloads" "$1/Music" "$1/Pictures" "$1/Videos" "$1/Favorites" "$1/Links" "$2/backup_$clock"

echo "---------"
echo " DONE!!! "
echo "---------"
exit 0
