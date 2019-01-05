#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# extract sqfs first on current work dir
# mkdir ~/sqfs
# cd ~/sqfs
# sudo unsquashfs /media/anime4000/PM_2017_06_12/pmagic/pmodules/PMAGIC_2017_06_12.SQFS

# Font:
# /usr/share/fonts/TTF
# ROXTerm
# /etc/xdg/roxtem.sourceforge.net/Profiles/Default

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root!" 
	exit 1
fi

echo "Place this script where squashfs-root folder sit"

cd "$DIR/squashfs-root/usr/share/backgrounds"
rm -vrf *
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/desktop1280x1024.jpg -O "desktop1280x1024.jpg "
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/desktop1366x768.jpg -O "desktop1366x768.jpg"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/desktop1600x1200.jpg -O "desktop1600x1200.jpg"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/desktop1920x1080.jpg -O "desktop1920x1080.jpg"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/desktop1920x1200.jpg -O "desktop1920x1200.jpg"

mkdir -p "$DIR/squashfs-root/etc/cc/"
cd "$DIR/squashfs-root/etc/cc/"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude.txt -O "exclude.txt"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude_audio.txt -O "exclude_audio.txt"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude_video.txt -O "exclude_video.txt"

cd "$DIR/squashfs-root/bin/"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/diskspeed.sh -O "diskspeed.sh"
chmod 755 "diskspeed.sh"
ln -s "diskspeed.sh" "diskspeed"
ln -s "diskspeed.sh" "sdxtest"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/cpx.sh -O "cpx.sh"
chmod 755 "cpx.sh"
ln -s "cpx.sh" "cpx"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/wucp.sh -O "wucp.sh"
chmod 755 "wucp.sh"
ln -s "wucp.sh" "wucp"

cd "$DIR"
mksquashfs squashfs-root filesystem.squashfs -b 1024k -comp xz -Xbcj x86 -e boot

echo "done..."
