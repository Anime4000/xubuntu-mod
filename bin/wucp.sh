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

DIR_SOURCE=""

if [ -d "$1/Desktop" ]; then
	echo "[FOUND]: $1/Desktop"
	DIR_SOURCE="$DIR_SOURCE \"$1/Desktop\""
fi

if [ -d "$1/Documents" ]; then
	echo "[FOUND]: $1/Documents"
	DIR_SOURCE="$DIR_SOURCE \"$1/Documents\""
fi

if [ -d "$1/Downloads" ]; then
	echo "[FOUND]: $1/Downloads"
	DIR_SOURCE="$DIR_SOURCE \"$1/Downloads\""
fi

if [ -d "$1/Music" ]; then
	echo "[FOUND]: $1/Music"
	DIR_SOURCE="$DIR_SOURCE \"$1/Music\""
fi

if [ -d "$1/Pictures" ]; then
	echo "[FOUND]: $1/Pictures"
	DIR_SOURCE="$DIR_SOURCE \"$1/Pictures\""
fi

if [ -d "$1/Videos" ]; then
	echo "[FOUND]: $1/Videos"
	DIR_SOURCE="$DIR_SOURCE \"$1/Videos\""
fi

if [ -d "$1/Favorites" ]; then
	echo "[FOUND]: $1/Favorites"
	DIR_SOURCE="$DIR_SOURCE \"$1/Favorites\""
fi

if [ -d "$1/Links" ]; then
	echo "[FOUND]: $1/Links"
	DIR_SOURCE="$DIR_SOURCE \"$1/Links\""
fi

if [ -d "$1/My Documents" ]; then
	if [ -L "$1/My Documents" ]; then
		echo "[INFO]: It's symbolic link."
		echo "[INFO]: Probably Windows Vista & above, Skip!"
	else
		echo "[FOUND]: $1/My Documents"
		DIR_SOURCE="$DIR_SOURCE \"$1/My Documents\""
	fi
fi

cd "$PWD"
mkdir -p "$2/backup_$clock"
rsync -avh --no-i-r --info=progress2 --exclude-from="/etc/cc/exclude.txt" $DIR_SOURCE "$2/backup_$clock"

echo "-----------"
echo "| DONE!!! |"
echo "-----------"
exit 0
