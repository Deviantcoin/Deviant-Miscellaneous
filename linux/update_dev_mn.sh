#!/bin/bash

TMP_FOLDER=$(mktemp -d)
CONFIGFOLDER=$HOME/.DeviantCore
CONFIG_FILE='deviant.conf'
COIN_DAEMON='deviantd'
COIN_CLI='deviant-cli'
COIN_PATH='/usr/local/bin/'
COIN_NAME='Deviant'
COIN_TGZ=$(curl -s https://api.github.com/repos/Deviantcoin/Source/releases/latest | grep browser_download_url | grep -e "x86_64-linux"| cut -d '"' -f 4)
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
COIN_PORT=22618
RPC_PORT=22617


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
  tar xzvf $COIN_ZIP
  find . -name $COIN_DAEMON | xargs mv -t $COIN_PATH >/dev/null 2>&1
  find . -name $COIN_CLI | xargs mv -t $COIN_PATH >/dev/null 2>&1
  chmod +x $COIN_PATH$COIN_DAEMON $COIN_PATH$COIN_CLI
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
   if [[ "$MD5SUMOLD" != "$MD5SUMNEW" ]]
    then   if [[ $? -ne 0 ]]; then
    tar xzvf $COIN_ZIP
    find . -name $COIN_DAEMON | xargs mv -t $COIN_PATH >/dev/null 2>&1
    find . -name $COIN_CLI | xargs mv -t $COIN_PATH >/dev/null 2>&1
    chmod +x $COIN_PATH$COIN_DAEMON $COIN_PATH$COIN_CLI
  fi
    if [[ "$RESTARTSYSD" == "Y" ]]
    then for service in $(systemctl -a | grep $COIN_NAME | awk '{ print $1 }'); do systemctl start $service >/dev/null 2>&1; done
    fi
    sleep 3
   fi
  else
    tar xzvf $COIN_ZIP
    find . -name $COIN_DAEMON | xargs mv -t $COIN_PATH >/dev/null 2>&1
    find . -name $COIN_CLI | xargs mv -t $COIN_PATH >/dev/null 2>&1
    chmod +x $COIN_PATH$COIN_DAEMON $COIN_PATH$COIN_CLI
  fi
  cd ~ >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  clear
}

download_node

