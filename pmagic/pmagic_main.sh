#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# extract sqfs first on current work dir
# mkdir ~/sqfs
# cd ~/sqfs
sudo unsquashfs /media/smb1/PMAGIC_2019_01_03.SQFS

# Font:
# /usr/share/fonts/TTF
# ROXTerm
# /etc/xdg/roxterm.sourceforge.net/Profiles/Default
# /root/.config/roxterm.sourceforge.net/Profiles/Default

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

wget --no-check-certificate https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O "speedtest-cli"
chmod 755 "speedtest-cli"
ln -s "speedtest-cli" "speedtest"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/cpx.sh -O "cpx.sh"
chmod 755 "cpx.sh"
ln -s "cpx.sh" "cpx"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/wucp.sh -O "wucp.sh"
chmod 755 "wucp.sh"
ln -s "wucp.sh" "wucp"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/cz.sh -O "cz.sh"
chmod 755 "cz.sh"
ln -s "cz.sh" "cz"

cd "$DIR/squashfs-root/usr/share/fonts/TTF/"
wget --no-check-certificate http://unifoundry.com/pub/unifont/unifont-11.0.03/font-builds/unifont-11.0.03.ttf -O "unifont-11.0.03.ttf"
wget --no-check-certificate http://www.thescifiworld.net/downloads/fonts/anquietas.ttf -O "anquietas.ttf"

cd "$DIR"
mkdir -p "squashfs-root/etc/xdg/roxterm.sourceforge.net/Profiles/"
wget --no-check-certificate https://raw.githubusercontent.com/Anime4000/xubuntu-mod/master/pmagic/roxterm-default.conf -O "squashfs-root/etc/xdg/roxterm.sourceforge.net/Profiles/Default"
wget --no-check-certificate https://raw.githubusercontent.com/Anime4000/xubuntu-mod/master/pmagic/roxterm-ancient.conf -O "squashfs-root/etc/xdg/roxterm.sourceforge.net/Profiles/Ancient"

rm "squashfs-root/root/.config/roxterm.sourceforge.net/Profiles/Default"
cp "squashfs-root/etc/xdg/roxterm.sourceforge.net/Profiles/Default" "squashfs-root/root/.config/roxterm.sourceforge.net/Profiles/Default"
cp "squashfs-root/etc/xdg/roxterm.sourceforge.net/Profiles/Ancient" "squashfs-root/root/.config/roxterm.sourceforge.net/Profiles/Ancient"

cd "$DIR"
cd "squashfs-root/usr"
git clone https://gitlab.com/tianocore_uefi_duet_builds/tianocore_uefi_duet_installer tianocore
ln -s "tianocore/duet-install" "/bin/duet"

cd "$DIR"
rm "squashfs-root/usr/share/lxpanel/images/my-computer.png"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/pmagic/my-computer.png -O "squashfs-root/usr/share/lxpanel/images/my-computer.png"

echo "CureLinux" > "squashfs-root/etc/hostname"
echo "CureLinux.example.org" > "squashfs-root/etc/HOSTNAME"

sed -i -e 's/Welcome - Parted Magic/Welcome - Rescue and Recovery/g' squashfs-root/etc/profile

sed -i -e 's/tintcolor=#000000/tintcolor=#EDEDED/g' squashfs-root/root/.config/lxpanel/default/panels/panel
sed -i -e 's/alpha=0/alpha=127/g' squashfs-root/root/.config/lxpanel/default/panels/panel

cd "$DIR"
mksquashfs squashfs-root filesystem.squashfs -b 1024k -comp xz -Xbcj x86 -e boot

echo "done..."
