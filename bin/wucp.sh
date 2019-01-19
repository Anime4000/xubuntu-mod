#/bin/bash
clock=`date +%Y-%m-%d_%H-%M-%S`

echo "----------------------------------------"
echo "| Backup Windows user files and folder |"
echo "----------------------------------------"
echo "         Property of CureComp Technology"
echo "                            by Anime4000"
echo ""
echo ""
echo "[INFO]: Win XP to 10 Users folder conversion is ENABLED!"
echo "[INFO]: Ultra Fast Low Level backup is ENABLED!"
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

CMD=rsync
ARGS="-avh --no-i-r --info=progress2 --exclude-from='/etc/cc/exclude.txt'"
DEST="$(readlink -f $2/backup_$clock)"
DIRS=""

declare -a USERS=("Desktop"
				"Documents"
				"Downloads"
				"Music"
				"Pictures"
				"Videos"
				"Favorites"
				"Links"
				"My Documents")

for i in "${USERS[@]}"
do
	if [ -d "$(readlink -f $1/$i)" ]; then
		if [ -L "$(readlink -f $1/$i)" ]; then
			echo "[INFO]: It's symbolic link."
			echo "[INFO]: Probably Windows Vista & above, Skip!"
		else
			echo "[FOUND]: $(readlink -f $1/$i)"
			DIRS="${DIRS} \"$(readlink -f $1/$i)\""
		fi
	fi
done

mkdir -p "${DEST}"

bash -c "${CMD} ${ARGS} ${DIRS} ${DEST}"

echo "-----------"
echo "| DONE!!! |"
echo "-----------"
exit 0
