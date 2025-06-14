#!/bin/bash
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\e[36m'
LIGHT='\033[0;37m'
owner="vpnlegasi"
host="https://raw.githubusercontent.com"
MYIP=$(wget -qO- ipinfo.io/ip)
echo "Checking VPS"
clear

data=( `cat /root/dnslegasi/client_ip | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
now=`date +"%Y-%m-%d"`
for IPADRESS in "${data[@]}"
do
exp=$(grep -w "^### $IPADRESS" "/root/dnslegasi/client_ip" | cut -d ' ' -f 3 | sort | uniq)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
    sed -i "/$IPADRESS/d" /root/dnslegasi/client_ip
    dnslegasi rm-ip $IPADRESS
    echo "Success"
fi
done
dnslegasi restart
clear