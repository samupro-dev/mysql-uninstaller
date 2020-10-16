#!/bin/bash
DONE="\e[0;32m ✔\e[0m"
ERROR="\e[0;31m X\e[0m"
YELLOW="\e[1;33m"
RED="\e[0;31m"
LIGHT_RED="\e[1;31m"
LIGHT_GREEN="\e[1;32m"
COLOR_NULL="\e[0m"
LIGHT_BLUE="\e[1;34m"
PURPLE="\e[0;35m"

echo -e "${PURPLE}  ██████  ▄▄▄       ███▄ ▄███▓ █    ██  ██▓███   ██▀███   ▒█████  
▒██    ▒ ▒████▄    ▓██▒▀█▀ ██▒ ██  ▓██▒▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒
░ ▓██▄   ▒██  ▀█▄  ▓██    ▓██░▓██  ▒██░▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒
  ▒   ██▒░██▄▄▄▄██ ▒██    ▒██ ▓▓█  ░██░▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░
▒██████▒▒ ▓█   ▓██▒▒██▒   ░██▒▒▒█████▓ ▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░
▒ ▒▓▒ ▒ ░ ▒▒   ▓▒█░░ ▒░   ░  ░░▒▓▒ ▒ ▒ ▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░ 
░ ░▒  ░ ░  ▒   ▒▒ ░░  ░      ░░░▒░ ░ ░ ░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░ 
░  ░  ░    ░   ▒   ░      ░    ░░░ ░ ░ ░░         ░░   ░ ░ ░ ░ ▒  
      ░        ░  ░       ░      ░                 ░         ░ ░  ${COLOR_NULL}"
echo -e "${LIGHT_BLUE} This script will completely remove MySQL from this VPS/Dedicated. ${COLOR_NULL}"
echo -e ""
sleep 1
echo -e "\n"

echo -e " ${YELLOW} Control of administration permissions. . . ${COLOR_NULL}"
if [ "$(id -u)" != "0" ] ; then
	echo " ${ERROR} ${LIGHT_RED}This script requires root permissions. Please run this as root! ${COLOR_NULL}"
	exit 2
fi
echo -e " ${DONE} ${LIGHT_GREEN}Congratulations, this script will be run as root. ${COLOR_NULL}"
echo -e "\n"

OPTIONS=("Yes" "No")
echo -e "${YELLOW} Do you want to continue? ${COLOR_NULL}"
select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1) break ;;
  2) exit ;;
  esac
done

echo -e "\n"
echo -e "${YELLOW} Checking the sudo package. . . ${COLOR_NULL}"
apt-get install -y sudo

echo -e "\n"
echo -e "${LIGHT_RED} Start of MySQL removal! ${COLOR_NULL}"
sudo apt-get -y remove mariadb-server
sudo apt-get -y purge mariadb-server
sudo apt-get -y remove mariadb-client
sudo apt-get -y purge mariadb-client
sudo apt-get -y remove mysql-server
sudo apt-get -y purge mysql-server
sudo apt-get -y remove mysql-client
sudo apt-get -y purge mysql-client
sudo rm -rf /etc/mysql/
sudo rm -rf /var/lib/mysql/
sudo rm -rf /var/lib/mariadb/

echo -e "\n"
echo -e "${YELLOW} I am updating all the Virtual Machine packages. ${COLOR_NULL}"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

echo -e "\n"
echo -e "${LIGHT_GREEN} Thanks for using this script. MySQL was successfully removed! ${COLOR_NULL}"
echo -e "${YELLOW} It is recommended to restart the VPS/Dedicated. (use command ${RED}reboot${YELLOW}) ${COLOR_NULL}"