#!/bin/bash
echo -e "\e[96m    ______                __    _                     ____  _____ "
echo -e "\e[96m   / ____/_  __________  / /   (_)___  __  ___  __   / __ \/ ___/ "
echo -e "\e[96m  / /   / / / / ___/ _ \/ /   / / __ \/ / / / |/_/  / / / /\__ \  "
echo -e "\e[96m / /___/ /_/ / /  /  __/ /___/ / / / / /_/ />  <   / /_/ /___/ /  "
echo -e "\e[96m \____/\__,_/_/   \___/_____/_/_/ /_/\__,_/_/|_|   \____//____/   "
echo -e "\e[0m"
echo -e "\e[1;32mCure Linux OS - Data Recovery & Forensic Operating System"
echo -e "\e[1;32mCopyright (c) 2017 CureComp Technology Trading & Services"
echo -e ""
if [ "$EUID" -eq 0 ]; then
	echo -e "\e[1;91m"
	echo -e "\e[5mSuperuser mode, proceed with caution!"
fi
echo -e "\e[0m"
