# Deviant Masternode setup on Linux VPS
## When a user should follow this guide:
1. The user wants to setup a cold Masternode on a Linux x86_64 VPS.

## Prerequisites
1. The [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) are fullfilled (this guide inherited the same naming convention).
2. A Linux VPS is mandatory for this setup. Ubuntu 16.04 is the recommended one. Successful setup have been reported also on Ubuntu 18.04 and Centos 7
3. A client SSH for your Operating System. In this guide it will be [putty portable for win32](https://the.earth.li/~sgtatham/putty/latest/w32/putty.exe). You can use Terminal on MacOS or gnome-terminal on Linux.
3. On VPS you need `unzip` and `curl` utilities.

## Establish connection
Open your ssh client then fill it with the parameters of your VPS (ip address and ssh port, default is 22).
Establish the connection (the "Open" push button on putty), then login with your credentials.<br />

Connection parameters | Host certificate warnig | Login process
--------------------- | ----------------------- | ------------- 
![putty](/images/putty-connection.png) | ![login](/images/putty-security.png) | ![login](/images/putty-login.png)

## Check the utilities
To check unzip and curl we use:<br />
```
which unzip 
which curl
```
The expected result is a filled line with full path.
If the output is without path, then you need to install the missing utility/utilities.

![check utilities](/images/utilities.png)

## Launch the script
To launch the script exec this commands:<br />
`wget https://raw.githubusercontent.com/ScaMar/Deviant-Masternode/master/linux/masternode_setup.sh`<br />
`bash masternode_setup.sh`

![launch script](/images/launch-script.png)

## Select the IP
This function let you choice on which IP you are going to listen the Masternode.
Pressing ENTER without any other input will install the daemon on the main ip address. Any other IP address will be related to a increasing number 1 to _n_ . To select an ip realted to a number, type the number than press ENTER

![select ip](/images/mn-select-ip.png)

In this case, ENTER is just pressed<br />

The IP you select here, will be referenced by:
`{YOUR PUBLIC IP}`

Note: If there is only one available public IP on your VPS, this screen selection will be skipped during setup. The available ip will be used by default. In this case `{YOUR PUBLIC IP}` fits this ip (usually it is the same IP you use to connect to VPS).

## Insert Masternode privatekey
In this step, the script asks you to enter the Masternode private key. This key has been generated during the [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md). It is known as {MN PRIV KEY}. If you didn't save the key, or you just like to use another key, the script will generate one key for you.

![mn priv key](/images/mn-priv-key.png)

In this case the key generate during preparation steps has been used

## Setup done
After the private key step, the setup is finished.

![setup done](/images/mn-setup-done.png)

By the way, before proceed with this guide, you must wait for chain full sync, otherwise you can't start your Masternode<br />
```devian-cli getinfo```<br />
will give you info about the block number reached.<br />
```deviant-cli mnsync status```<br />
will give you an overview about the sync process.<br />

![mnsync status](/images/mn-mnsync-status.png)

You're free to proceed when _"IsBlockchainSynced": true,_

## Fill file masternode.conf
Open file masternode.conf<br />
![open masternode.conf](/images/edit-masternode-conf.png)
![sample masternode.conf](/images/sample-masternode-conf.png)

Add these lines:<br />
```{MN ALIAS} {YOUR PUBLIC IP}:22618 {MN PRIV KEY} {MN TX-iD} {TX-ID IDX}```<br />
using the proper values instead the generic {PARAMETER}.
In [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) it is explained how to get most of them.<br />
The ones not found there, are explained in here.<br />

![fill masternode.conf](/images/mn-fill-masternode-conf.png)

Restart your wallet to apply new conf files.

## Start alias
Go to Masternode menu, select the line related to your Masternode, then righ-click -> start-alias<br />

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

Note: according your setup, you may need to use another alias. `deviant-cli` can be used for default ip. If you installed the Masternode on ip with n=1, your cli command become: ```deviant-cli1.sh```
You will find find the alias you need, in the on screen report at the end of setup steps.
