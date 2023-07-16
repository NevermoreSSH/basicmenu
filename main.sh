#!/bin/bash

### Color
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'

### System Information
TANGGAL=$(date '+%Y-%m-%d')
TIMES="10"
NAMES=$(whoami)
IMP="wget -q -O"    
CHATID="1036440597"
LOCAL_DATE="/usr/bin/"
MYIP=$(wget -qO- ipinfo.io/ip)
CITY=$(curl -s ipinfo.io/city)
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
KEY="2145515560:AAE9WqfxZzQC-FYF1VUprICGNomVfv6OdTU"
URL="https://api.telegram.org/bot$KEY/sendMessage"
REPO="https://raw.githubusercontent.com/NevermoreSSH/basicmenu/main/"
APT="apt-get -y install"
start=$(date +%s)

# reboot everyday 5am
echo "0 5 * * * root reboot" >> /etc/crontab

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# install basic package
apt install htop -y 
apt install vnstat -y 
apt install resolvconf -y 

# install clouflare JQ
apt install jq curl -y

# download menu
cd /usr/sbin
wget -O menux "${REPO}menu.sh"
wget -O bbr2 "${REPO}bbr.sh"
wget -O netf "${REPO}netf.sh"
wget -O speedtest "${REPO}speedtest"

chmod +x menux
chmod +x bbr2
chmod +x netf
chmod +x speedtest

cd
