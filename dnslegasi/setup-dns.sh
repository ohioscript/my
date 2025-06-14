#!/bin/bash
apt update -y && apt install sudo && sudo apt install -y wget && sudo apt install -y bzip2 gzip coreutils screen curl -y
clear
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
host="https://raw.githubusercontent.com"
directory="public/netflixchecker"
MYIP=$(wget -qO- ipinfo.io/ip)
echo "Checking VPS"
clear

PERMISSION() {
IZIN=$( curl -sS http://${host}/ipaccess/ip-admin | awk '{print $2}' | grep $MYIP )
MYIP=$(wget -qO- ipinfo.io/ip)
if [ $MYIP = $IZIN ]; then
echo -e "${green}Permission Accepted...${NC}"
else
rm -rf *.sh
clear
echo -e "${red}Permission Denied!${NC}";
echo "Only For Owner Scripts"
sleep 5
exit 0
fi
}

sewa() {
PERMISSION
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        Installation DNS Server     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
mkdir -p /opt/dnslegasi
mkdir -p dnslegasi
cd dnslegasi
rm -rf domains  > /dev/null 2>&1
curl "http://${host}/ohioscript/main/dnslegasi/sewa-proxy-domains.txt" >> domains
wget "http://${host}/ohioscript/main/dnslegasi/dnslegasi"
wget "http://${host}/ohioscript/main/dnslegasi/dnsmasq.sh"
wget "http://${host}/ohioscript/main/dnslegasi/sniproxy.sh"
wget "http://${host}/ohioscript/main/dnslegasi/my_init"
wget "http://${host}/ohioscript/main/dnslegasi/services.ini"
wget "http://${host}/ohioscript/main/dnslegasi/Dockerfile"
wget "http://${host}/ohioscript/main/dnslegasi/instl"
wget -O /usr/bin/speedtest "http://${host}/ohioscript/main/dnslegasi/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/xp-dns "http://${host}/ohioscript/main/dnslegasi/sewa-xp-dns.sh" && chmod +x /usr/bin/xp-dns
wget -O /usr/bin/menu http://${host}/ohioscript/main/dnslegasi/sewa-menu.sh && chmod +x /usr/bin/menu
apt install jq -y && wget -O /usr/bin/menu_nf http://${host}/public/netflixchecker/menu_nf.sh && chmod +x /usr/bin/menu_nf
apt install snapd -y
snap install fast
curl -sSL https://get.docker.com/ | sudo sh
docker build -t vpnlegasi/dnslegasi .
docker container run -d -p 53:53 -p 80:80 -p 443:443 vpnlegasi/dnslegasi:latest
ln -snf $PWD/dnslegasi /usr/local/bin/dnslegasi
chmod +x /usr/local/bin/dnslegasi
rm -rf resolver.conf
echo 127.0.0.1 >> resolver.conf
dnslegasi start
sleep 5
dnslegasi enable
sleep 5
dnslegasi status
sleep 5
echo "" >> client_ip
cd
cat << EOF >> /etc/crontab
# BEGIN_NETMANAGER
0 0 * * * root /usr/bin/xp-dns # delete expired IP VPS License
# END_NETMANAGER
# DNS_BEGIN_REBOOT
5 0 * * * root reboot # Reboot Server
# DNS_END_REBOOT
EOF

clear -x
echo "menu" >> .profile
clear -x
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m      Complete Install DNS Server   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
timedatectl set-timezone Asia/Kuala_Lumpur
echo -e "Server Will Reboot in 10sec"
sleep 10
rm -rf *.sh
reboot
}


main_dnslegasi() {
PERMISSION
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m        Installation DNS Server     \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
mkdir -p /opt/dnslegasi
mkdir -p dnslegasi
cd dnslegasi
rm -rf domains  > /dev/null 2>&1
curl "http://${host}/ohioscript/main/dnslegasi/main-proxy-domains.txt" >> domains
wget "http://${host}/ohioscript/main/dnslegasi/dnslegasi"
wget "http://${host}/ohioscript/main/dnslegasi/dnsmasq.sh"
wget "http://${host}/ohioscript/main/dnslegasi/sniproxy.sh"
wget "http://${host}/ohioscript/main/dnslegasi/my_init"
wget "http://${host}/ohioscript/main/dnslegasi/services.ini"
wget "http://${host}/ohioscript/main/dnslegasi/Dockerfile"
wget "http://${host}/ohioscript/main/dnslegasi/instl"
wget -O /usr/bin/speedtest "http://${host}/ohioscript/main/dnslegasi/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/xp-dns "http://${host}/ohioscript/main/dnslegasi/main-xp-dns.sh" && chmod +x /usr/bin/xp-dns
wget -O /usr/bin/menu http://${host}/ohioscript/main/dnslegasi/main-menu.sh && chmod +x /usr/bin/menu
apt install jq -y && wget -O /usr/bin/menu_nf http://${host}/public/netflixchecker/menu_nf.sh && chmod +x /usr/bin/menu_nf
apt install snapd -y
snap install fast
curl -sSL https://get.docker.com/ | sudo sh
docker build -t vpnlegasi/dnslegasi .
docker container run -d -p 53:53 -p 80:80 -p 443:443 vpnlegasi/dnslegasi:latest
ln -snf $PWD/dnslegasi /usr/local/bin/dnslegasi
chmod +x /usr/local/bin/dnslegasi
rm -rf resolver.conf  > /dev/null 2>&1
echo 127.0.0.1 >> resolver.conf
dnslegasi start
sleep 5
dnslegasi enable
sleep 5
dnslegasi status
sleep 5
echo "" >> client_ip
cd
cat << EOF >> /etc/crontab
# BEGIN_NETMANAGER
0 0 * * * root /usr/bin/xp-dns # delete expired IP VPS License
# END_NETMANAGER
# DNS_BEGIN_REBOOT
5 0 * * * root reboot # Reboot Server
# DNS_END_REBOOT
EOF

clear -x

cat> /root/.profile << END
# ~/.profile: executed by Custom Shell VPN Legasi

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

clear -x
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m      Complete Install DNS Server   \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
timedatectl set-timezone Asia/Kuala_Lumpur
rm -rf *.sh  > /dev/null 2>&1
echo -e "Server Will Reboot in 10sec"
sleep 10
reboot
}

clear
echo -e "\033[0;34m------------------------------------\033[0m"
echo -e "\E[44;1;39m               VPS MENU             \E[0m"
echo -e "\033[0;34m------------------------------------\033[0m"
echo ""
echo -e " [\e[36m 01 \e[0m] Install MODDED Legasi DNS SERVER"
echo -e " [\e[36m 02 \e[0m] Install Dns Penyewa"
echo ""
echo -e "\033[0;34m------------------------------------\033[0m"
read -p " Select menu : " opt
echo -e ""
case $opt in
1)
    clear
    main_dnslegasi
    ;;
2)
    clear
    sewa
    ;;
*)
    echo -e ""
    echo "Sila Pilih Semula"
    sleep 1
    dns-server
    ;;
esac