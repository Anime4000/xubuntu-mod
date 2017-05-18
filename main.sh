#! /bin/bash

# Customise Xubuntu 16.04.1
# Property of CureComp Technology Trading & Services
# Made by Anime4000
#
# Be sure run this script on chroot! (on cubic)

# Nicer
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/wucp.sh -O "/bin/wucp.sh"
chmod 755 "/bin/wucp.sh"
ln -s "/bin/wucp.sh" "/bin/wucp"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/bin/cclogo.sh -O "/bin/cclogo.sh"
chmod 755 "/bin/cclogo.sh"
ln -s "/bin/cclogo.sh" "/bin/cclogo"

wget --no-check-certificate https://raw.githubusercontent.com/LionSec/katoolin/master/katoolin.py -O "/bin/katoolin"
chmod 755 "/bin/katoolin"

wget --no-check-certificate https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O "/bin/speedtest-cli"
chmod 755 "/bin/speedtest-cli"
ln -s "/bin/speedtest-cli" "/bin/speedtest"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/curecomp.jpg -O "/usr/share/xfce4/backdrops/curecomp.jpg"
chmod 644 "/usr/share/xfce4/backdrops/curecomp.jpg"

wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/cmdhelp.txt -O "/etc/skel/useful commands.txt"

mkdir "/etc/cc"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude.txt -O "/etc/cc/exclude.txt"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude_audio.txt -O "/etc/cc/exclude_audio.txt"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/rsync_exclude_video.txt -O "/etc/cc/exclude_video.txt"

# Add stuff
wget --no-check-certificate http://drbl.nchc.org.tw/GPG-KEY-DRBL -O - | sudo apt-key add -
echo "# Clonezilla Repo (added manually)" >> /etc/apt/sources.list
echo "deb http://free.nchc.org.tw/ubuntu xenial main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://free.nchc.org.tw/drbl-core drbl stable" >> /etc/apt/sources.list

# i-nex (cpu-z for linux)
add-apt-repository ppa:nemh/gambas3 -y
add-apt-repository ppa:i-nex-development-team/stable -y

apt-get update
apt-get install \
build-essential git zlib1g-dev libwrap0-dev xfonts-terminus screen xmlstarlet python \
smartmontools gsmartcontrol htop iptraf gcp unzip openvpn qbittorrent i-nex sysbench \
hdparm drbl clonezilla reiserfsprogs e2fsprogs hfsprogs exfat-utils nilfs-tools pigz \
gnome-disk-utility gparted gddrescue testdisk recoverjpeg foremost scalpel florence \
aircrack-ng reaver ettercap-graphical hydra etherape nmap pppoeconf openssh-server \
ubuntu-restricted-extras -y

# Edit XFCE4 UI
# to view xml
#	xmlstarlet el -v "/etc/xdg/xdg-xubuntu/xfce4/panel/default.xml"
# to validate
#	xmlstarlet ed -u "path" -v "value" "file"
# add -L to edit in-line

echo "Modifying xfce4 desktop interface"

xmlstarlet ed -L -u "channel/property/property/property[@name='position' and @type='string' and @value='p=6;x=0;y=0']/@value" -v "p=8;x=0;y=0" "/etc/xdg/xdg-xubuntu/xfce4/panel/default.xml"
xmlstarlet ed -L -u "channel/property/property/property[@name='size' and @type='uint' and @value='24']/@value" -v "32" "/etc/xdg/xdg-xubuntu/xfce4/panel/default.xml"

xmlstarlet ed -L -u "channel/property/property/property[@name='show-filesystem' and @type='bool' and @value='true']/@value" -v "false" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"
xmlstarlet ed -L -u "channel/property/property/property[@name='show-removable' and @type='bool' and @value='true']/@value" -v "false" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"
xmlstarlet ed -L -u "channel/property/property/property[@name='show-trash' and @type='bool' and @value='true']/@value" -v "false" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"
xmlstarlet ed -L -u "channel/property/property/property/property[@name='image-path' and @type='string' and @value='/usr/share/xfce4/backdrops/xubuntu-wallpaper.png']/@value" -v "/usr/share/xfce4/backdrops/curecomp.jpg" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"

xmlstarlet ed -L -u "channel/property/property[@name='theme' and @type='string' and @value='Greybird']/@value" -v "Numix" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"
xmlstarlet ed -L -u "channel/property/property[@name='title_alignment' and @type='string' and @value='center']/@value" -v "left" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"

xmlstarlet ed -L -u "channel/property/property[@name='enabled' and @type='bool' and @value='true']/@value" -v "false" "/etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/thunar-volman.xml"

echo "Modify xfce4-terminal"
mv "/etc/xdg/xdg-xubuntu/xfce4/terminal/terminalrc" "/etc/xdg/xdg-xubuntu/xfce4/terminal/terminalrc.bak"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/terminalrc -O "/etc/xdg/xdg-xubuntu/xfce4/terminal/terminalrc"
chmod 644 "/etc/xdg/xdg-xubuntu/xfce4/terminal/terminalrc"

# Make desktop shortcut
echo "Adding desktop shortcut icon"

mkdir -p /etc/skel/Desktop
cd /etc/skel/Desktop/

cp /usr/share/applications/firefox.desktop ./
cp /usr/share/applications/gnome-calculator.desktop ./

echo "[Desktop Entry]" > cpu-z.desktop
echo "Name=CPU-Z" >> cpu-z.desktop
echo "GenericName=I-NEX" >> cpu-z.desktop
echo "X-GNOME-FullName=Alternative for Windows CPU-Z" >> cpu-z.desktop
echo "Comment=View system information such as CPU clock speed, feature & more" >> cpu-z.desktop
echo "Exec=/usr/bin/i-nex.gambas" >> cpu-z.desktop
echo "Icon=processor" >> cpu-z.desktop
echo "Terminal=false" >> cpu-z.desktop
echo "Type=Application" >> cpu-z.desktop
echo "Categories=GNOME;System" >> cpu-z.desktop
echo "Keywords=CPU-Z" >> cpu-z.desktop

echo "[Desktop Entry]" > diskhealth.desktop
echo "Name=Disk Health" >> diskhealth.desktop
echo "GenericName=S.M.A.R.T." >> diskhealth.desktop
echo "X-GNOME-FullName=Self-Monitoring, Analysis and Reporting Technology" >> diskhealth.desktop
echo "Comment=View disk health and status" >> diskhealth.desktop
echo "Exec=xterm -e 'sudo gsmartcontrol'" >> diskhealth.desktop
echo "Icon=gsmartcontrol" >> diskhealth.desktop
echo "Terminal=false" >> diskhealth.desktop
echo "Type=Application" >> diskhealth.desktop
echo "Categories=GNOME;System" >> diskhealth.desktop
echo "Keywords=Disk;Disk Health" >> diskhealth.desktop

echo "[Desktop Entry]" > gparted.desktop
echo "Name=Partition Editor" >> gparted.desktop
echo "GenericName=Partition Editor" >> gparted.desktop
echo "X-GNOME-FullName=GParted Partition Editor" >> gparted.desktop
echo "Comment=Create, reorganise, and delete partition" >> gparted.desktop
echo "Exec=gparted-pkexec" >> gparted.desktop
echo "Icon=gparted" >> gparted.desktop
echo "Terminal=false" >> gparted.desktop
echo "Type=Application" >> gparted.desktop
echo "Categories=GNOME;System;Filesystem;Settings" >> gparted.desktop
echo "Keywords=Partition" >> gparted.desktop

echo "[Desktop Entry]" > clonezilla.desktop
echo "Name=Clonezilla" >> clonezilla.desktop
echo "GenericName=Disk Cloning" >> clonezilla.desktop
echo "X-GNOME-FullName=Disk and Image Cloning" >> clonezilla.desktop
echo "Comment=A free software disaster recovery, disk cloning and deployment solution." >> clonezilla.desktop
echo "Exec=xterm -fullscreen -fa Terminus -fs 12 -e 'sudo clonezilla && sudo /etc/init.d/umount-clonezilla.sh && xfce4-session-logout'" >> clonezilla.desktop
echo "Icon=drive-multidisk" >> clonezilla.desktop
echo "Terminal=false" >> clonezilla.desktop
echo "Type=Application" >> clonezilla.desktop
echo "Categories=GNOME;System;Filesystem;Settings" >> clonezilla.desktop
echo "Keywords=Partition;Clone;Cloning;Disk;Clonezilla" >> clonezilla.desktop

echo "[Desktop Entry]" > taskmanager.desktop
echo "Name=Task Manager" >> taskmanager.desktop
echo "GenericName=htop task manager" >> taskmanager.desktop
echo "X-GNOME-FullName=htop task manager" >> taskmanager.desktop
echo "Comment=A powerful task manager for linux" >> taskmanager.desktop
echo "Exec=xfce4-terminal --hide-menubar --title='Task Manager' --geometry=90x30 -e 'sudo htop'" >> taskmanager.desktop
echo "Icon=xfce4-cpugraph-plugin" >> taskmanager.desktop
echo "Terminal=false" >> taskmanager.desktop
echo "Type=Application" >> taskmanager.desktop
echo "Categories=GNOME;System" >> taskmanager.desktop
echo "Keywords=task;manager;task manager;taskmanager;kill;process;nice" >> taskmanager.desktop

echo "[Desktop Entry]" > terminalroot.desktop
echo "Name=Root Terminal" >> terminalroot.desktop
echo "GenericName=Linux Terminal" >> terminalroot.desktop
echo "X-GNOME-FullName=Linux Terminal" >> terminalroot.desktop
echo "Comment=A powerful command-line interface" >> terminalroot.desktop
echo "Exec=xfce4-terminal --hide-menubar --title='Root Terminal' --geometry=90x30 -e 'sudo -i'" >> terminalroot.desktop
echo "Icon=utilities-terminal" >> terminalroot.desktop
echo "Terminal=false" >> terminalroot.desktop
echo "Type=Application" >> terminalroot.desktop
echo "Categories=GNOME;System" >> terminalroot.desktop
echo "Keywords=commandPrompt;command prompt;cmd;terminalemulator;terminal emulator;Terminal;tty" >> terminalroot.desktop

echo "[Desktop Entry]" > gnome-disks.desktop
echo "Name=Disk Management" >> gnome-disks.desktop
echo "GenericName=Gnome Disks" >> gnome-disks.desktop
echo "X-GNOME-FullName=Gnome Disks" >> gnome-disks.desktop
echo "Comment=Manage Drives and Media" >> gnome-disks.desktop
echo "Exec=gnome-disks" >> gnome-disks.desktop
echo "Icon=gnome-disks" >> gnome-disks.desktop
echo "DBusActivateble=true" >> gnome-disks.desktop
echo "Terminal=false" >> gnome-disks.desktop
echo "Type=Application" >> gnome-disks.desktop
echo "Categories=GNOME;System" >> gnome-disks.desktop
echo "Keywords=hard;disk;dvd;cd;vcd;ssd;volume;partition;ntfs;exfat;fat32;ext2;ext3;ext4;iso;image;backup" >> gnome-disks.desktop

echo "[Desktop Entry]" > xfce4-session-logout.desktop
echo "Name=Log Out" >> xfce4-session-logout.desktop
echo "GenericName=Log Out" >> xfce4-session-logout.desktop
echo "X-GNOME-FullName=Log Out" >> xfce4-session-logout.desktop
echo "Comment=xfce4 desktop manager logout sessions menu" >> xfce4-session-logout.desktop
echo "Exec=xfce4-session-logout" >> xfce4-session-logout.desktop
echo "Icon=system-shutdown" >> xfce4-session-logout.desktop
echo "DBusActivateble=true" >> xfce4-session-logout.desktop
echo "Terminal=false" >> xfce4-session-logout.desktop
echo "Type=Application" >> xfce4-session-logout.desktop
echo "Categories=GNOME;System" >> xfce4-session-logout.desktop
echo "Keywords=logout;log out;poweroff;power off;shutdown;restart;lock;screen" >> xfce4-session-logout.desktop

chmod +x *

echo "Modify .bashrc"
echo "" >> /root/.bashrc
echo "cclogo" >> /root/.bashrc
echo "" >> /etc/skel/.bashrc
echo "cclogo" >> /etc/skel/.bashrc

echo "Cleaning..."
rm -rf ~/.cache
rm -rf ~/.nano
rm -rf ~/.config
rm -rf ~/.local

echo "modifying shutdown/restart script"
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/umount-clonezilla.sh -O "/etc/init.d/umount-clonezilla.sh"
chmod +x /etc/init.d/umount-clonezilla.sh
ln -s /etc/init.d/umount-clonezilla.sh /etc/rc0.d/K01umount-clonezilla
ln -s /etc/init.d/umount-clonezilla.sh /etc/rc6.d/K01umount-clonezilla

echo "Modify Splash Screen"
rm -f /usr/share/plymouth/themes/xubuntu-logo/logo.png
rm -f /usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/logo.png -O /usr/share/plymouth/themes/xubuntu-logo/logo.png
wget --no-check-certificate https://github.com/Anime4000/xubuntu-mod/raw/master/plymouth/wallpaper.png -O /usr/share/plymouth/themes/xubuntu-logo/wallpaper.png
chmod 644 /usr/share/plymouth/themes/xubuntu-logo/logo.png
chmod 644 /usr/share/plymouth/themes/xubuntu-logo/wallpaper.png

echo ""
echo ""
echo ""
echo "DONE!"
echo ""
echo ""
echo ""

exit 0
