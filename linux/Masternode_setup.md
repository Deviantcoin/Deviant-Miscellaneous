# Deviant Masternode setup on Linux VPS
## When a user should follow this guide:
1. The user wants to setup a cold Masternode on a Linux x86_64 VPS.

## Prerequisites
1. The [preparation steps](/common/Preparation-steps-for-MN.md) are fullfilled (this guide inherited the same naming convention).
2. A Linux VPS is mandatory for this setup. Ubuntu 16.04 is the recommended one. Successful setups have been reported also on Ubuntu 18.04.
3. A SSH client for your Operating System. In this guide, it will be [putty portable for win32](https://the.earth.li/~sgtatham/putty/latest/w32/putty.exe). You can use Terminal on MacOS or gnome-terminal on Linux.

## Establish connection
Open your ssh client, then fill it with the parameters of your VPS (ip address and ssh port, default is 22).
Establish the connection (the "Open" push button on putty), then login with your credentials.<br />

Connection parameters | Host certificate warning | Login process
--------------------- | ----------------------- | ------------- 
![putty](/images/putty-connection.png) | ![login](/images/putty-security.png) | ![login](/images/putty-login.png)

## Launch the script
To launch the script, execute these commands:<br />
`wget https://raw.githubusercontent.com/Deviantcoin/Deviant-Miscellaneous/master/linux/masternode_setup.sh`<br />
`bash masternode_setup.sh`

![launch script](/images/launch-script.png)

## Check Ubuntu updates
In this step, the script will check and install available updates. The updates should be applied on a regular basis to avoid known vulnerabilities on your own system.<br />

![check updates](/images/mn-checking-os-updates.png)

If some update needs a system reboot, the script will notify you of this. You can let the script reboot the system, or you can do it manually.<br />

![reboot needed](/images/mn-reboot-needed.png)

## Check the firewall
The script will check the ufw (Ubuntu Firewall) status.
If ufw is already configured, also for deviant p2p port, this screen will not popup.
If you enable ufw via this script, the deviant p2p port will be enabled. Every port that is listening will be configured as well.

![ufw configuration](/images/mn-firewall-disabled.png)

![ufw done](/images/mn-firewall-enabled.png)

## Select the IP
This function lets you choose on which IP you are going to listen the Masternode.
Pressing ENTER without any other input will install the daemon on the main ip address. Any other IP address will be related to a increasing number 1 to _n_ . To select an ip realted to a number, type the number than press ENTER

![select ip](/images/mn-select-ip.png)

In this case, ENTER is just pressed<br />

The IP you select here will be referenced by:
`{YOUR PUBLIC IP}`

Note: If there is only one available public IP on your VPS, this screen selection will be skipped during setup. The available ip will be used by default. In this case `{YOUR PUBLIC IP}` fits this ip (usually it is the same IP you use to connect to the VPS).

## Insert Masternode privatekey
In this step, the script asks you to enter the Masternode private key. This key has been generated during the [preparation steps](/common/Preparation-steps-for-MN.md). It is known as {MN PRIV KEY}. If you didn't save the key, or you would just like to use another key, the script will generate one key for you.

![mn priv key](/images/mn-priv-key.png)

In this guide, the key generated during preparation steps has been used.

## Daily update check
In this step, you can enable a daily check for updates. If you type "y", the script will create a directive in crontab.

![check daily updates](/images/mn-updates.png)

## Setup done
After the private key step, the setup is finished.

![setup done](/images/mn-setup-done.png)

By the way, before proceeding with this guide, you must wait for the blockchain to fully sync, otherwise you can't start your Masternode<br />
```deviant-cli getinfo```<br />
will give you info about the block number reached.<br />
```deviant-cli mnsync status```<br />
will give you an overview about the sync process.<br />

![mnsync status](/images/mn-mnsync-status.png)

You're free to proceed when the lines<br />
_"IsBlockchainSynced": true,_<br />
_"RequestedMasternodeAssets": 999_<br />
appear in the output.

## Fill file masternode.conf
Open file masternode.conf<br />
![open masternode.conf](/images/edit-masternode-conf.png)
![sample masternode.conf](/images/sample-masternode-conf.png)

Add these lines:<br />
```{MN ALIAS} {YOUR PUBLIC IP}:22618 {MN PRIV KEY} {MN TX-iD} {TX-ID IDX}```<br />
using the proper values instead the generic {PARAMETER}.
In [preparation steps](/common/Preparation-steps-for-MN.md), it is explained how to get most of them.<br />
The ones not found there, are explained in here.<br />

![fill masternode.conf](/images/mn-fill-masternode-conf.png)

Restart your wallet to apply new conf files.

## Start alias
Go to the Masternode tab, select the line related to your Masternode, then righ-click -> start-alias<br />

![mn-start-alias](/images/mn-start-alias.png)

You must unlock the wallet (also for staking only) to start-alias.<br />

![mn-start-unlock](/images/mn-start-unlock.png)

If start ends successfully, check the status of your Masternode on VPS<br />

![mn-masternode-status](/images/mn-masternode-status.png)

Once you read also these lines:<br />
```
"status": 4,
"message": "Masternode successfully started"
```
with cli command:<br />
```deviant-cli masternode status```<br />
Then your setup ends succesfully!<br />
Well done!!!<br />

Note: according your setup, you may need to use another alias. `deviant-cli` can be used for the default ip. If you installed the Masternode on an ip with n=1, your cli command becomes: ```deviant-cli1.sh```
You will find the alias you need in the on screen report at the end of setup steps.
