#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
## Foreground
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
# Domain & IPVPS
IPVPS=$(curl -s ipinfo.io/ip)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
WKT=$(curl -s ipinfo.io/timezone)
#IPVPS=$(curl -s ipinfo.io/ip)
IPVPS=$(curl -sS ipv4.icanhazip.com)
#IPVPS=$(curl -sS ifconfig.me)
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*/} / ${corediilik:-1}))"
cpu_usage+=" %"
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# RAM Info
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
# Total BANDWIDTH
dtoday="$(vnstat | grep today | awk '{print $2, $3}')"
utoday="$(vnstat | grep today | awk '{print $5, $6}')"
#ttoday="$(vnstat | grep today | awk '{print $8, $9}')"
# Download/Upload yesterday
dyest="$(vnstat | grep yesterday | awk '{print $2, $3}')"
uyest="$(vnstat | grep yesterday | awk '{print $5, $6}')"
#tyest="$(vnstat | grep yesterday | awk '{print $8, $9}')"
# Download/Upload current month
dmon="$(vnstat -m | grep "$(date '+%Y-%m')" | awk '{print $2, $3}')"
umon="$(vnstat -m | grep "$(date '+%Y-%m')" | awk '{print $5, $6}')"
tmon="$(vnstat -m | grep "$(date '+%Y-%m')" | awk '{print $8, $9}')"
# Interface vnstat
interface1="$(ifconfig | awk 'NR==1 {sub(/:$/, "", $1); print $1}')"
# total usage 
ttoday="$(vnstat -i "$interface1" | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
tyest="$(vnstat -i "$interface1" | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#tmon="$(vnstat -m | grep "$(date +"%b '%y")" | awk '{print $9" "substr ($10, 1, 1)}')"
totalmon="$(vnstat | grep "total:" | awk '{print $8, $9}')"


echo ""
echo -e "$y                        MAIN MENU $wh"
echo -e "$y                Simple menu By NevermoreSSH $wh"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "                ${WB} ♦️ Server Information ♦️ ${NC}             "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}OS      :  "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-) ${NC}         
echo -e "  ${RB}♦️${NC} ${YB}KERNEL  :  $(uname -r) ${NC} "
echo -e "  ${RB}♦️${NC} ${YB}UPTIME  :  $uptime ${NC} "
echo -e "  ${RB}♦️${NC} ${YB}DATE    :  $(date) ${NC} "
echo -e "  ${RB}♦️${NC} ${YB}CPU     :  $cpu_usage"
echo -e "  ${RB}♦️${NC} ${YB}RAM     :  $uram MB / $tram MB ${NC} "
echo -e "  ${RB}♦️${NC} ${YB}IPVPS   :  $IPVPS ${NC} "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "                  ${WB} ♦️ Total Bandwidth ♦️ ${NC}            "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Daily Usage         : $ttoday ${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Yesterday Usage     : $tyest ${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Monthly Usage       : $tmon ${NC}"
echo -e "  ${RB}♦️${NC} ${YB}Total Usage         : $totalmon ${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "$YB 1$y.  Task manager  $wh"
echo -e "$YB 2$y.  Install BBR+  $wh"
echo -e "$YB 3$y.  Check Bandwidth  $wh"
echo -e "$YB 4$y.  Check Netflix Proxy  $wh"
echo -e "$YB 5$y.  Speedtest  $wh"
echo -e "$YB 6$y.  Reboot$wh"
echo -e "$YB 7$y.  Log out$wh"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "${YB}"
read -p "Select From Options [ 1 - 24 ] : " menu
case $menu in
1)
clear
htop
;;
2)
clear
bbr2
;;
3)
clear
vnstat
;;
4)
clear
netf
;;
5)
clear
speedtest
;;
6)
clear
reboot
;;
7)
clear
exit
;;
*)
clear
menux
;;
esac
