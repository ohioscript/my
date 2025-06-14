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
directory="${host}/${owner}/resources/main/service"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
MYIP=$(wget -qO- ipinfo.io/ip);
Name=$( curl -sS ${host}/${owner}/ip-admin/main/access | awk '{print $4}' | grep $MYIP )
cek=$( curl -sS ${host}/${owner}/ip-admin/main/access | awk '{print $2}' | grep $MYIP )
echo "Checking VPS"
if [ $cek = $MYIP ]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
rm -rf *.sh > /dev/null 2>&1
clear
echo "Your IP NOT REGISTER / EXPIRED | Contact me at Telegram @vpnlegasi to Unlock"
exit 0
fi
clear

add_ip() {
    clear
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       ADD CLIENT IP SERVER    \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    if [ ! -f /root/dnslegasi/client_ip ]; then
    echo "" >> /root/dnslegasi/client_ip
    fi
    read -p "IP Address  : " ip_address
    if [ "$(grep -wc "$ip_address" /root/dnslegasi/client_ip)" = '0' ]; then
    read -p "Validity    : " ip_exp
    read -p "Client Name : " client
    exp=$(date -d "$ip_exp days" +"%Y-%m-%d")
    hariini=`date -d "0 days" +"%Y-%m-%d"`
    echo "### ${ip_address} ${exp} ${client}" >>/root/dnslegasi/client_ip
    links="wget -O /usr/bin/menu_nf http://${host}/${directory}/menu_nf.sh && chmod +x /usr/bin/menu_nf"
    dnslegasi add-ip $ip_address
    clear
    MYIP=$(wget -qO- ipinfo.io/ip)
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39mClient IP DNS Add Successfully \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo "  Private IP DNS ??  "
    echo -e '```'
    echo -e "$MYIP"
    echo -e '```'
    echo "  Register For IP : $ip_address"
    echo "  Active Days     : $ip_exp Days"             
    echo "  Register Date   : $hariini"
    echo "  Expired Date    : $exp"
    echo "  Client Name     : $client"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo ""
    echo "  Link Tanam DNS & Check Region ?? (Jika Tiada Sahaja) :"
    echo -e '```'
    echo -e "${links}"
    echo -e '```'
    echo " ?? Type ?? menu_nf selepas install ?? "  
    echo ""          
    echo -e "\033[0;34m-------------------------------\033[0m"            
    sleep 1
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
    else
    clear
    exp=$(cat /root/dnslegasi/client_ip | grep $ip_address | awk '{print $3}')
    client=$(cat /root/dnslegasi/client_ip | grep $ip_address | awk '{print $4}') 
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo -e "\E[44;1;39m       ADD CLIENT IP SERVER    \E[0m"
    echo -e "\033[0;34m-------------------------------\033[0m"
    echo "IP are already registered as below"
    echo "  Register IP     : $ip_address"
    echo "  Expired Date    : $exp"
    echo "  Client Name     : $client"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
    fi
}

del_ip() {
    clear
    MYIP=$(wget -qO- ipinfo.io/ip)
    echo -e "\033[0;34m========================================\033[0m"
    echo -e "    No.   IPVPS   EXP DATE   CLIENT NAME"
    echo -e "\033[0;34m========================================\033[0m"
    NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/dnslegasi/client_ip")
    grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2-4 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
        fi
    done
    ip_address=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    client=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    if [ "$(grep -wc "$ip_address" /root/dnslegasi/client_ip)" != '0' ]; then
    sed -i "/$ip_address/d" /root/dnslegasi/client_ip
    dnslegasi rm-ip $ip_address
    clear
    echo -e "\033[0;34m===============================\033[0m"
    echo " Client IP DNS Deleted Successfully"
    echo -e "\033[0;34m===============================\033[0m"
    echo "  IP DNS Server : $MYIP"
    echo "  Ip VPS Client : $ip_address"
    echo "  Client Name   : $client"
    echo -e "\033[0;34m===============================\033[0m"
    sleep 1
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
    else
    echo "IP Does Not Exist"
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
    fi
}

renew_ip() {
    clear
    echo -e "\033[0;34m========================================\033[0m"
    echo -e "    No.   IPVPS   EXP DATE   CLIENT NAME"
    echo -e "\033[0;34m========================================\033[0m"
    NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/dnslegasi/client_ip")
    grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2-4 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
        fi
    done
    read -p "Renew: " masaaktif
    MYIP=$(wget -qO- ipinfo.io/ip)
    hariini=`date -d "0 days" +"%Y-%m-%d"`
    ip_address=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    exp=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    client=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(((d1 - d2) / 86400))
    exp3=$(($exp2 + $masaaktif))
    exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
    sed -i "s/### $ip_address $exp/### $ip_address $exp4/g" /root/dnslegasi/client_ip
    clear
    echo -e "\033[0;34m===============================\033[0m"
    echo "  Client IP DNS Renew Successfully"
    echo -e "\033[0;34m===============================\033[0m"
    echo "  Ip VPS Client : $ip_address"
    echo "  Day Add       : $masaaktif Days" 
    echo "  Renew Date    : $now"
    echo "  Expired Date  : $exp4"
    echo "  Client Name   : $client"
    echo -e "\033[0;34m===============================\033[0m"
    sleep 1
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

change_ip() {
    clear -x
    MYIP=$(wget -qO- ipinfo.io/ip)
    echo -e "\033[0;34m----------------------------------------\033[0m"
    echo -e "\E[44;1;39m              CHANGE IP CLIENT          \E[0m"
    echo -e "\033[0;34m----------------------------------------\033[0m"
    echo -e ""
    NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/root/dnslegasi/client_ip")
    grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2-4 | nl -s ') '
    until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
        if [[ ${CLIENT_NUMBER} == '1' ]]; then
            read -rp "Select one client [1]: " CLIENT_NUMBER
        else
            read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
        fi
    done
    old_ip=$(grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
    cek=$(cat /root/dnslegasi/client_ip | awk '{print $2}' | grep $old_ip)
    if [[ $old_ip = $cek ]]; then
    read -rp "PLEASE KEY IN NEW IP : " ip_address
            oldexp=$(cat /root/dnslegasi/client_ip | grep $old_ip | awk '{print $3}')
            oldclient=$(cat /root/dnslegasi/client_ip | grep $old_ip | awk '{print $4}')
            hariini=`date -d "0 days" +"%Y-%m-%d"`
            echo "### ${ip_address} ${oldexp} ${oldclient}" >>/root/dnslegasi/client_ip
            client=$(cat /root/dnslegasi/client_ip | grep $ip_address | awk '{print $4}')
            exp=$(cat /root/dnslegasi/client_ip | grep $ip_address | awk '{print $3}')
	    links="wget -O /usr/bin/menu_nf http://${host}/${directory}/menu_nf.sh && chmod +x /usr/bin/menu_nf"
	    dnslegasi rm-ip $ip_address
            sed -i "/$old_ip/d" /root/dnslegasi/client_ip
            dnslegasi add-ip $ip_address
	    clear
	    echo -e "\033[0;34m-------------------------------\033[0m"
	    echo -e "\E[44;1;39m Client IP Change Successfully \E[0m"
	    echo -e "\033[0;34m-------------------------------\033[0m"
            echo "  Private IP DNS 👇  "
	    echo -e '```'
	    echo -e "$MYIP"
	    echo -e '```'
            echo "  Change From  IP : $old_ip"
            echo "  Change To IP    : $ip_address"          
            echo "  Change Date     : $hariini"
            echo "  Expired Date    : $exp"
            echo "  Client Name     : $client"
            echo -e "\033[0;34m-------------------------------\033[0m"
    	    echo ""
	    echo "  Link Tanam DNS & Check Region 👇 (Jika Tiada Sahaja) :"
	    echo -e '```'
	    echo -e "${links}"
	    echo -e '```'
            echo " 🌟 Type 👉 menu_nf selepas install 🌟 "  
            echo ""          
    	    echo -e "\033[0;34m-------------------------------\033[0m"            
            sleep 1
	    read -n 1 -s -r -p "Press any key to back on menu"
	    menu
    fi
}

client_dns() {
clear
echo -e "\033[0;34m========================================\033[0m"
echo -e "    No.   IPVPS   EXP DATE   CLIENT NAME"
echo -e "\033[0;34m========================================\033[0m"
grep -E "^### " "/root/dnslegasi/client_ip" | cut -d ' ' -f 2-4 | nl -s '. '
echo -e "\033[0;34m========================================\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

update_sc() {
clear -x
echo -e "\033[0;34m===============================\033[0m"
echo -e "\E[44;1;39m           Update Script       \E[0m"
echo -e "\033[0;34m===============================\033[0m"
wget -O /usr/bin/xp-dns "http://${host}/vpnlegasi/admin/dnslegasi/main-xp-dns.sh" && chmod +x /usr/bin/xp-dns
wget -O /usr/bin/menu http://${host}/vpnlegasi/admin/dnslegasi/main-menu.sh && chmod +x /usr/bin/menu
apt install jq -y && wget -O /usr/bin/menu_nf http://${host}/${directory}/menu_nf.sh && chmod +x /usr/bin/menu_nf
clear -x
echo -e "\033[0;34m===============================\033[0m"
echo -e "\E[44;1;39m       Successfully Update     \E[0m"
echo -e "\033[0;34m===============================\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

update-proxy() {
clear -x
dnslegasi stop
rm -rf /root/dnslegasi/domains > /dev/null
curl "http://${host}/vpnlegasi/admin/dnslegasi/main-proxy-domains.txt" >> /root/dnslegasi/domains
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m      Update Proxy Domain      \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e ""
dnslegasi restart > /dev/null
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39mProxy Domain Successfully Add  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

add-proxy() {
clear -x
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m         Add Proxy Domain      \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e ""
read -p "Please Type Proxy Domain : " domain
DOMAIN_EXISTS=$(grep -w $domain /root/dnslegasi/domains | wc -l)
if [[ ${DOMAIN_EXISTS} == '1' ]]; then
	clear -x
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m         Add Proxy Domain      \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e ""
	echo -e "Domain Already in proxy!!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	read -n 1 -s -r -p "Press any key to back on add other domain"
	add-proxy
	else
	clear -x
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m         Add Proxy Domain      \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	dnslegasi stop > /dev/null
        printf "${domain}\n" | tee -a /root/dnslegasi/domains  > /dev/null
	sleep 2
	dnslegasi restart > /dev/null
	clear
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39mProxy Domain Successfully Add  \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e ""
	echo -e "Successfully Add Proxy $domain"
	echo -e ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	read -n 1 -s -r -p "Press any key to back on menu"
	menu
fi
}

del-proxy() {
clear -x
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m       Delete Proxy Domain     \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
NUMBER_OF_DOMAINS=$(grep -c -E "^*" "/root/dnslegasi/domains")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo -e "\E[44;1;39m       Delete Proxy Domain     \E[0m"
	echo -e "\033[0;34m-------------------------------\033[0m"
	echo ""
	echo "You have no existing proxy domain!"
	echo ""
	echo -e "\033[0;34m-------------------------------\033[0m"
	read -n 1 -s -r -p "Press any key to back on menu"
	del-proxy
	fi
	clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m       Delete Proxy Domain     \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo "  Bil  Proxy Domain " 
echo -e "\033[0;34m-------------------------------\033[0m"
dnslegasi stop > /dev/null
grep -E "^*" "/root/dnslegasi/domains" | nl -s ') '
echo ""
until [[ ${DOMAINS_NUMBER} -ge 1 && ${DOMAINS_NUMBER} -le ${NUMBER_OF_DOMAINS} ]]; do
if [[ ${DOMAINS_NUMBER} == '1' ]]; then
echo -e "\033[0;34m-------------------------------\033[0m"
read -rp "Select one domain [1]: " DOMAINS_NUMBER
else
echo -e "\033[0;34m-------------------------------\033[0m"
read -rp "Select one domain [1-${NUMBER_OF_DOMAINS}]: " DOMAINS_NUMBER
fi
done
DOMAIN=$(grep -E "^*" "/root/dnslegasi/domains" | cut -d ' ' -f 2 | awk '{print $1}' |sed -n "${DOMAINS_NUMBER}"p)
sed -i "/$DOMAIN/d" /root/dnslegasi/domains
dnslegasi restart > /dev/null
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39mProxy domain Successfully Del  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e ""
echo -e "Successfully Del $DOMAIN"
echo -e ""
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

fast_1() {
clear -x
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m   FAST.COM TESTER VPN LEGASI  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
fast
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m   FAST.COM TESTER VPN LEGASI  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

change_resolver() {
clear -x
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m Change IP Resolver VPN LEGASI \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
cd /root/dnslegasi
rm -rf /root/dnslegasi/resolver.conf > /dev/null
read -p "Add Resolver: " IPR
echo $IPR >> /root/dnslegasi/resolver.conf
echo -e "Please Wait While System Run"
systemctl stop docker > /dev/null 2>&1
systemctl disable dnslegasi > /dev/null 2>&1

stop_and_remove_containers() {
local pattern="$1"
if [ -z "$pattern" ]; then
containers=$(docker ps -a -q)
else
containers=$(docker ps -a | grep "$pattern" | awk '{print $1}')
fi

if [ -n "$containers" ]; then
docker stop $containers
docker rm $containers
fi

}

remove_images() {
local pattern="$1"
if [ -z "$pattern" ]; then
images=$(docker images -a -q)
else
images=$(docker images -a | grep "$pattern" | awk '{print $3}')
fi

if [ -n "$images" ]; then
for image in $images; do
associated_containers=$(docker ps -a --filter=ancestor="$image" -q)
if [ -n "$associated_containers" ]; then
docker stop $associated_containers
docker rm $associated_containers
fi
docker rmi "$image"
done
fi
}
stop_and_remove_containers > /dev/null 2>&1
remove_images > /dev/null 2>&1

sed1 () {
IP1=$(cat /root/dnslegasi/sniproxy.sh | grep "nameserver" | awk '{print $2}')
IP2=$(cat /root/dnslegasi/resolver.conf)

sed "s/$IP1/$IP2/g" /root/dnslegasi/sniproxy.sh
sed "s/$IP1/$IP2/g" /root/dnslegasi/sniproxy.sh > /root/dnslegasi/temp.sh
sed -i "s/$IP1/$IP2/g" /root/dnslegasi/sniproxy.sh
}

sed1  > /dev/null 2>&1
rm -rf /root/dnslegasi/temp.sh > /dev/null 2>&1
docker build -t vpnlegasi/dnslegasi . > /dev/null 2>&1
docker run -d -p 53:53 -p 80:80 -p 443:443 vpnlegasi/dnslegasi > /dev/null 2>&1
systemctl start dnslegasi
systemctl enable dnslegasi > /dev/null 2>&1
systemctl restart dnslegasi
sleep 2
containers1=$(docker ps --filter status=exited -q)
docker rm -v $containers1
cd
clear
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m Change IP Resolver VPN LEGASI \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e " New IP Resolver : $IPR"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m Change IP Resolver VPN LEGASI \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

ipresolv () {
clear -x
IPR=$(cat /root/dnslegasi/sniproxy.sh | grep "nameserver" | awk '{print $2}')
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m  Show IP Resolver VPN LEGASI  \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e " IP Resolver : $IPR"
echo -e "\033[0;34m-------------------------------\033[0m"
echo -e "\E[44;1;39m     IP Resolver VPN LEGASI    \E[0m"
echo -e "\033[0;34m-------------------------------\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}

clear -x
echo -e "\033[0;34m===============================\033[0m"
echo -e "\E[44;1;39m       MENU ADD DNS SERVER     \E[0m"
echo -e "\033[0;34m===============================\033[0m"
    echo "[01] Add IP "
    echo "[02] Delete IP"
    echo "[03] Renew IP"
    echo "[04] Show Client DNS"
    echo "[05] Change Client DNS"
    echo "[06] Update Latest Script"
    echo "[07] Speedtest Server (ookla)"
    echo "[08] Speedtest Server (fast.com)"
    echo "[09] Show Resolver IP Access DNS"
    echo "[10] Change Resolver IP Access DNS"
    echo "[11] Add Proxy Domain/Bypass Access DNS"
    echo "[12] Remove Proxy Domain/Bypass Access DNS"
    echo "[13] Update Proxy Domain/Bypass Access DNS"
    echo "[14] Menu Add Nameserver & Check Netflix Region"
    echo ""
echo -e "\033[0;34m===============================\033[0m"
echo ""
    read -p "Please Choose Option Number : " menu

    case $menu in
    1)
        add_ip
        ;;
    2)
        del_ip
        ;;
    3)
        renew_ip
        ;;
    4)
        client_dns
        ;;
    5)
        change_ip
        ;;
    6)
        update_sc
        ;;  
    7)
        speedtest
        ;; 
    8)
        fast_1
        ;; 
    9)
        ipresolv
        ;;
    10)
        change_resolver
        ;;
    11)
        add-proxy
        ;;
    12)
        del-proxy
        ;;
    13)
        update-proxy
        ;;  
    14)
        menu_nf
        ;;     
    esac


