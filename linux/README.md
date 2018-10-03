# Deviant Masternode setup/administration scripts for linux (x86_64)<br />
## Script: masternode_setup.sh<br />
This script will setup a Deviant masternode on your linux VPS.

Prerequisites:
1. you need "unzip" and "curl" utilities.
On ubuntu just type:
```apt install unzip curl```
2. you need several public ips (ipv4/ipv6/both) to run several MNs. The script will check it for you, if it find only one public ip, you can install only one MN. NAT is not supported, the IPs must be assigned to a local interface.

To execute the script you can use such commands:
1. ```wget https://raw.githubusercontent.com/Deviantcoin/Deviant-Miscellaneous/master/linux/masternode_setup.sh```
2. ```bash masternode_setup.sh```

Check [Masternode Setup](/linux/Masternode_setup.md) guide for explanations and sample execution.

## Guide: masternode_setup.md<br />
This guide covers the point:<br />
* execution of masternode_setup.sh<br />

This guide will drive you, step by step, during the setup of a Deviant Masternode on linux VPS

## Script: masternode_tor_setup.sh<br />
This script is an enhanced version of `masternode_setup.sh`. When you execute this script, you have the chance to type `tor` in the IP address selection screen. The advantage to setup the Masternode on tor net is that you can run 2 Masternodes with only one IP address. The cost is a bit more CPU and NET to run the Masternode. 
