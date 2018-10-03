#!/bin/bash
TMP_FOLDER=$(mktemp -d)
CONFIGFOLDER=$HOME/.DeviantCore
CONFIG_FILE='deviant.conf'
COIN_DAEMON='deviantd'
COIN_CLI='deviant-cli'
COIN_PATH='/usr/local/bin/'
COIN_NAME='Deviant'
COIN_TGZ='https://github.com/Deviantcoin/Wallet/raw/master/dev-3.0.0.1-linux-x86_64.zip'
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
COIN_PORT=22618
RPC_PORT=22617


BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

## ToDo: warnign about missing bind parameter if a MN is already installed

function apt_update() {
echo
echo -e "${GREEN}Checking and installing operating system updates. It may take awhile ...${NC}"
apt-get update >/dev/null 2>&1
apt-get -y upgrade >/dev/null 2>&1 
apt-get -y install zip unzip curl >/dev/null 2>&1
apt-get -y autoremove >/dev/null 2>&1
if [[ -f /var/run/reboot-required ]]
  then echo -e "${RED}Warning:${NC}${GREEN}some updates require a reboot${NC}"
  echo -e "${GREEN}Do you want to reboot at the end of masternode installation process?${NC}"
  echo -e "${GREEN}(${NC}${RED} y ${NC} ${GREEN}/${NC}${RED} n ${NC}${GREEN})${NC}"
  read rebootsys
  case $rebootsys in
   y*)
    REBOOTSYS=y
    ;;
   n*)
    REBOOTSYS=n
    ;;
   *)
    echo -e "${GREEN}Your choice,${NC}${CYAN} $rebootsys${NC},${GREEN} is not valid. Assuming${NC}${RED} n ${NC}"
    REBOOTSYS=n
    sleep 5
    ;;
  esac
fi
}

function update() {
crontab -l | grep "$COIN_PATH/upd-deviant.sh"
if [[ $? -ne 0 ]]
 then echo -e "${GREEN}Do you want to setup a daily check for updates? (y/n)${NC}"
 echo -e "${RED}y${GREEN} i want setup a daily check for updates"
 echo -e "${RED}n${GREEN} no, i will check manually for updates${NC}"
 read checkupdate
 case $checkupdate in
  y*)
   ORA=$(echo $((1 + $RANDOM % 23)))
   MIN=$(echo $((1 + $RANDOM % 59)))
   base64 -d <<<"H4sICAPes1sAA3VwZC1kZXZpYW50LnNoAK1TW2/aMBR+z684zSLSbgou61pNm9IKQdiQykWBqaJVhUJiwGtip4kD7Pbfd0xCuEzwNOUh8YnPd76L/eaMTBgnEy+da8NOf9zq3Tcd1zbOoxdJoxis4EJr9Nrd8fDLo23OpYzTT4TMmJxnk6ovItKkC+Zx6QtEefDCkEqSeEsSeamkCQnowrqqXuJTs0LGs5W1+ngzvvlQ/cliMwdu1p1Or2ubQQ4UFOXGfbusWX7IinK/PvxqmyRLExIK3wvX7It/3XrHsYuWvPLY7qMU6s8FGBsV8Bu85QtYLZOYYP6KE8YlGN3WH/NC0zQ/AGPrA9wqBYRnYQjvbys1bTmjEqzXLZrGpvD0BMYdWJzCJTw/fwY5p1yD9VSLgukkiUggEEseCi9gfAZcBLRq4pYVk1DTpqxAsaYFsFJp7Lizhc04OgfW92IjCoS3ezsPGXea14NvHVSjMg2u0yw6NiP3pXSkpgzJu7vOw2H3iZ6YBWIKJ0m5Ddu4K0TrRklRhzO7XONQHSoVXLsNHY183XMXSn/1gRQxJBnnylrGU+lxn6a62jNF41OaLJhP8Q8Y5+kPPJaRL0NkPktoXNBUJ6fUAhsxoNQgCmYH28ZUjTM2qIfK1rs5Ve80pDjgSn26zmBYd4eD0aBpjzTAwMvMT8pXevdyF6eiL1Z4c/Da7qT8D0l/HokA3q2OnYTDMiKWbHek6GAj35Giqa1ZbjNxKcaQSJVIcSE3Oahg/kcsB5ngsOOhrBPJTf8LUsovN/AEAAA=" | gunzip > $COIN_PATH/upd-deviant.sh
   crontab -l > /tmp/cron2upd
   echo "$MIN $ORA * * * $COIN_PATH/upd-deviant.sh" >> /tmp/cron2upd
   crontab /tmp/cron2upd
   echo -e "${GREEN}/tmp/cron2upd is a temporary copy of crontab${NC}"
   sleep 5
   ;;
  n*)
   echo -e "${CYAN}Keep in mind to check for updates ${NC}"
   sleep 5
   ;;
  *)
   update
   ;;
 esac
fi
}

function welcome() {
clear
base64 -d <<<"H4sICGd9r1sCA0RldmlhbnQudHh0AI2OQQqAQAwD731FjgpCPiTEh+zjTbMqerPLlknb0AKAHHjFR6B7UpnYvPewUl+0Rkw/QflXKM/DGDcLx/R37krdDqQwLpf4+M1WKGYDezNHp/CW7mRf4osKP6NO+hpoYPYAAAA=" | gunzip
echo -e "${GREEN}Installation script for deviant masternode${NC}"
sleep 3
}

function check_distro() {
if [[ $(lsb_release -i) != *Ubuntu* ]]; then
  echo -e "${RED}You are not running Ubuntu. This script is meant for Ubuntu.${NC}"
  exit 1
fi
}

function check_user() {
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi
}

function check_firewall() {
clear
UFWSTATUS=$(ufw status | head -1 | awk '{print $2}')
case $UFWSTATUS in
        inactive*)
                echo -e "${GREEN}It seems ufw is disabled. Do you want to enable it? (y/n)${NC}"
                read ufwenable
                 case $ufwenable in
                  y*)
                   clear
                   ufw -f enable
                   declare -a SERVICES=$(netstat -ntpl| grep -v 127.0.[0-99].[0-99] |grep -v '::1' | grep [0-9]|awk '{print $4}'|cut -d":" -f2)
                   for PORT in ${SERVICES};do echo -e "${GREEN} $PORT $(lsof -i:$PORT|tail -1 | awk '{print $1}') is listening on $PORT; enabling ...${NC}"; ufw allow $PORT >/dev/null 2>&1; done
                   echo -e "${GREEN}Enabling $COIN_PORT ...${NC}"; ufw allow $PORT >/dev/null 2>&1
                   sleep 5
                   ;;
                  n*)
                   exit
                   ;;
                  *)
                   check_firewall
                   ;;
                 esac
                ;;
        active*)
                ufw status | grep $COIN_PORT | grep ALLOW >/dev/null 2>&1
                if [[ $? -eq 0 ]]; then echo "ufw seems already active and configured"
                 sleep 5
                 else echo "ufw is already active. Enabling deviant port ...."
                 ufw allow $COIN_PORT >/dev/null 2>&1
                fi
                ;;
        *)
                echo "It seems ufw is not installed"
                ;;
esac
}

function it_exists() {
if [[ -d $CONFIGFOLDER$IP_SELECT ]]; then
  echo
  echo -e "${GREEN}It seems a $COIN_NAME instance is already installed in $CONFIGFOLDER$IP_SELECT"
  echo -e "Save masternodeprivkey if you want to use it again${NC}${RED}"
  echo -e $(cat $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE|grep masternodeprivkey |cut -d "=" -f2)
  echo -e "${NC}${GREEN}Type${NC} ${YELLOW}y${NC} ${GREEN}to scratch it (be carefull, if you are staking on this VPS, also your wallet will be erased)"
  echo -e "Type${NC} ${YELLOW}n${NC} ${GREEN}to exit${NC}"
read -e ANSWER
case $ANSWER in
     y)      
          systemctl stop $COIN_NAME$IP_SELECT.service >/dev/null 2>&1
          systemctl disable $COIN_NAME$IP_SELECT.service >/dev/null 2>&1
          kill -9 $(pidof $COIN_DAEMON) >/dev/null 2>&1
          rm -rf $CONFIGFOLDER$IP_SELECT
          ;;
     n)      
          exit 0
          ;;
     *)
          clear
          it_exists
          ;; 
esac
clear
fi
}

function download_node() {
  echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
  apt -y install zip unzip curl >/dev/null 2>&1
  sleep 5
  cd $TMP_FOLDER >/dev/null 2>&1
  wget -q $COIN_TGZ
  if [[ $? -ne 0 ]]; then
   echo -e 'Error downloading node. Please contact support'
   exit 1
  fi
  if [[ -f $COIN_PATH$COIN_DAEMON ]]; then
  unzip -j $COIN_ZIP *$COIN_DAEMON >/dev/null 2>&1
  MD5SUMOLD=$(md5sum $COIN_PATH$COIN_DAEMON | awk '{print $1}')
  MD5SUMNEW=$(md5sum $COIN_DAEMON | awk '{print $1}')
  pidof $COIN_DAEMON >/dev/null 2>&1
  RC=$?
  if [[ "$MD5SUMOLD" != "$MD5SUMNEW" && "$RC" -eq 0 ]]; then
     echo -e 'Those daemon(s) are about to die'
     echo -e $(ps axo cmd:100 | grep $COIN_DAEMON | grep -v grep)
     echo -e 'If systemd service or a custom check is not implemented, take care of their restart'
     for service in $(systemctl | grep $COIN_NAME | awk '{ print $1 }'); do systemctl stop $service >/dev/null 2>&1; done
     sleep 3
     RESTARTSYSD=Y
   fi
  fi
  if [[ "$MD5SUMOLD" != "$MD5SUMNEW" ]] 
   then unzip -o -j $COIN_ZIP *$COIN_DAEMON *$COIN_CLI -d $COIN_PATH >/dev/null 2>&1
   chmod +x $COIN_PATH$COIN_DAEMON $COIN_PATH$COIN_CLI
    if [[ "$RESTARTSYSD" == "Y" ]]
    then for service in $(systemctl | grep $COIN_NAME | awk '{ print $1 }'); do systemctl start $service >/dev/null 2>&1; done
    fi
   sleep 3
  fi
  cd ~ >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  clear
}

function custom_exe() {
  echo '#!/bin/bash' > $COIN_PATH$COIN_CLI$IP_SELECT.sh
  echo "$COIN_PATH$COIN_CLI -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT \$@" >> $COIN_PATH$COIN_CLI$IP_SELECT.sh
  chmod 755 $COIN_PATH$COIN_CLI$IP_SELECT.sh
  echo '#!/bin/bash' > $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  echo "$COIN_PATH$COIN_DAEMON -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT \$@" >> $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  chmod 755 $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  clear
}

function configure_systemd() {
  cat << EOF > /etc/systemd/system/$COIN_NAME$IP_SELECT.service
[Unit]
Description=$COIN_NAME$IP_SELECT service
After=network.target
[Service]
User=root
Group=root
Type=forking
ExecStart=$COIN_PATH$COIN_DAEMON -daemon -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT
ExecStop=-$COIN_PATH$COIN_CLI -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT stop
Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable $COIN_NAME$IP_SELECT.service >/dev/null 2>&1
systemctl start $COIN_NAME$IP_SELECT.service
sleep 8
netstat -napt | grep LISTEN | grep $NODEIP | grep $COIN_DAEMON >/dev/null 2>&1
 if [[ $? -ne 0 ]]; then
   ERRSTATUS=TRUE
 fi
}

function check_swap() {
SWAPSIZE=$(cat /proc/meminfo | grep SwapTotal | awk '{print $2}')
FREESPACE=$(df / | tail -1 | awk '{print $4}')
if [ $SWAPSIZE -lt 400000 ]
  then if [ $FREESPACE -gt 6000000 ]
    then dd if=/dev/zero of=/bigfile.swap bs=250MB count=16 
    chmod 600 /bigfile.swap
    mkswap /bigfile.swap
    swapon /bigfile.swap
    echo '/bigfile.swap none swap sw 0 0' >> /etc/fstab
    else echo 'Swap seems smaller than recommended. It cannot be increased because of lack of space'
    fi
fi  
}

function create_config() {
  mkdir $CONFIGFOLDER$IP_SELECT >/dev/null 2>&1
  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  if [[ -z "$IP_SELECT" ]]; then
   RPC_PORT=$RPC_PORT
   else let RPC_PORT=$RPC_PORT-$IP_SELECT
  fi
  cat << EOF > $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
#Uncomment RPC credentials if you don't want to use local cookie for auth
#rpcuser=$RPCUSER
#rpcpassword=$RPCPASSWORD
rpcport=$RPC_PORT
server=1
daemon=1
port=$COIN_PORT
EOF
}

function create_key() {
  echo -e "${YELLOW}Enter your ${RED}$COIN_NAME Masternode GEN Key${NC}"
  echo -e "${YELLOW}Press enter to let the script generate one${NC}"
  read -e COINKEY
  if [[ -z "$COINKEY" ]]; then
  $COIN_PATH$COIN_DAEMON$IP_SELECT.sh -daemon >/dev/null 2>&1
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $COIN_DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  COINKEY=$($COIN_PATH$COIN_CLI$IP_SELECT.sh masternode genkey)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the GEN Key${NC}"
    sleep 30
    COINKEY=$($COIN_PATH$COIN_CLI$IP_SELECT.sh masternode genkey)
  fi
  $COIN_PATH$COIN_CLI$IP_SELECT.sh stop >/dev/null 2>&1
fi
clear
}

function update_config() {
  sed -i 's/daemon=1/daemon=0/' $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
  if [[ "$NODEIP" =~ [A-Za-z] ]]; then
    NODEIP=[$NODEIP]
    RPCBIND=[::1]
   else RPCBIND=127.0.0.1
  fi
  cat << EOF >> $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
logintimestamps=1
maxconnections=256
bind=$NODEIP
rpcbind=$RPCBIND
rpcallow=$RPCBIND
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$COINKEY
#Addnodes: clear comment if dnsseeds fails. Check output in debug.log file
#addnode=209.97.139.2
#addnode=45.35.64.39
#addnode=138.197.146.236
#addnode=167.99.234.81
#addnode=206.189.155.48
#addnode=209.97.131.147
#addnode=209.97.131.20
#addnode=209.97.139.20
#addnode=219.74.243.91:22618
#addnode=109.10.53.168:22618
#addnode=178.239.54.249:22618
EOF
}


function get_ip() {
  unset NODE_IPS
  declare -a NODE_IPS
  for ips in $(ip a | grep inet | awk '{print $2}' | cut -f1 -d "/")
  do
    NODE_IPS+=($(curl --interface $ips --connect-timeout 4 -sk ident.me))
  done

  if [ ${#NODE_IPS[@]} -gt 1 ]
    then
      echo -e "${GREEN}More than one IP have been found."
      echo -e "Please press ${YELLOW}ENTER${NC} ${GREEN}to use ${NC}${YELLOW}${NODE_IPS[0]}${NC}" 
      echo -e "${GREEN}Type${NC} ${YELLOW}1${NC}${GREEN} for the second one${NC} ${YELLOW}${NODE_IPS[1]}${NC} ${GREEN}and so on..."
      echo -e "If a $COIN_NAME masternode/node is already running on this host, we recommend to press ENTER"
      echo -e "At the end of installation process, the script will ask you if you want to install another masternode${NC}"
      INDEX=
      for ip in "${NODE_IPS[@]}"
      do
        echo ${INDEX} $ip
        let INDEX=${INDEX}+1
      done
      read -e choose_ip
      echo ${NODE_IPS[@]} | grep ${NODE_IPS[$choose_ip]} >/dev/null 2>&1
      if [[ $? -ne 0 ]];
        then echo "Choosen value not in list"
        get_ip
      fi
      IP_SELECT=$choose_ip
      NODEIP=${NODE_IPS[$choose_ip]}
  else
    NODEIP=${NODE_IPS[0]}
    IP_SELECT=
  fi
  clear
}

another_run() {
echo -e "If you want to install another masternode, please type ${RED}y${NC}"
echo -e "Any other key will close such script"
read -e another
if [[ "$another" != "y" ]]
  then if [[ "$REBOOTSYS" == "y" ]]
   then echo -e "Good bye!"
   sleep 3
   shutdown -r now
   fi
   if [[ "$REBOOTSYS" == "n" && -f /var/run/reboot-required ]]
   then echo -e "${RED}Keep in mind, this server still need a reboot${NC}"
   echo "Good bye!"
   fi
  else setup_node
fi
}

function important_information() {
clear
 echo
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}multiple vps setup${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}$COIN_NAME Masternode is up and running listening on port${NC}${PURPLE}$COIN_PORT${NC}."
 echo -e "${GREEN}Configuration file is:${NC}${RED}$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE${NC}"
 echo -e "${GREEN}VPS_IP:${NC}${GREEN}$NODEIP:$COIN_PORT${NC}"
 echo -e "${GREEN}MASTERNODE GENKEY is:${NC}${PURPLE}$COINKEY${NC}"
 echo -e "${BLUE}================================================================================================================================"
 echo -e "${CYAN}Temp${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${CYAN}Ensure Node is fully SYNCED with BLOCKCHAIN (with cli or with custom cli command).${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}Server start (with cli or with custom cli command).${NC}"
 echo -e "${GREEN}deviantd -datadir=$CONFIGFOLDER$IP_SELECT -daemon${NC}"
 echo -e "${GREEN}$COIN_DAEMON$IP_SELECT.sh -daemon${NC}"
 echo -e "${PURPLE}Server start (with systemctl).${NC}"
 echo -e "${GREEN}systemctl start $COIN_NAME$IP_SELECT.service${NC}"
 echo -e "${PURPLE}Server stop.${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT stop${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh stop${NC}"
 echo -e "${PURPLE}Server stop (with systemctl).${NC}"
 echo -e "${GREEN}systemctl stop $COIN_NAME$IP_SELECT.service${NC}"
 echo -e "${PURPLE}Usage Commands.${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT masternode status${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh masternode status${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT getinfo${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh getinfo${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT mnsync status${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh mnsync status${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 if [[ "$ERRSTATUS" == "TRUE" ]]; then
    echo -e "${RED}$COIN_NAME$IP_SELECT seems not running, please investigate. Check its status by running the following commands as root:${NC}"
    echo -e "systemctl status $COIN_NAME$IP_SELECT.service"
    echo -e "${RED}You can restart it by firing following command (as root):${NC}"
    echo -e "${GREEN}systemctl start $COIN_NAME$IP_SELECT.service${NC}"
    echo -e "${RED}Check errors by runnig following commands:${NC}"
    echo -e "${GREEN}less /var/log/syslog${NC}"
    echo -e "${GREEN}journalctl -xe${NC}"
 fi
 unset NODE_IPS 
}

function setup_node() {
  unset NODE_IPS
  check_distro
  welcome
  check_user
  apt_update
  check_swap
  check_firewall
  download_node
  get_ip
  it_exists
  create_config
  custom_exe
  create_key
  update_config
  configure_systemd
  update
  important_information
  another_run
}


##### Main #####
setup_node
