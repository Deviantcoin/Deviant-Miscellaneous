# Hot MasterNode under NAT
## When a user should follow this guide:
1. The user has a static ip address from his ISP provider.
2. The user wants to run a Masternode at home, although a VPS can assure consistent online time.

## Prerequisites
1. The [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) are fullfilled (this guide inherited the same naming convention).
2. Knowledge about port forwarding rules on own router (or how to enable UPnP support).
3. The workstation/home server must have static lan ip address
4. Any security software (such as anti-virus or anti-malware programs) must not limit/lock deviant-qt.exe.

## Check your public ip
To check your own public ip, you can just open this link in a browser: [http://ident.me](http://ident.me)<br />
Your IP will appear in the browser.<br />
From now on, it will be referenced by {YOUR PUBLIC IP} .

## Enable UPnP
If your router supports UPnP, use it. If not, a forward rule (external port:22618 <-> internal:22618) must be created on the router.<br />
Go to Settings ->  -> Options -> Network -> Set the flag on "Map port using UPnP" (UPnP is disabled in defaults settings)<br />

Settings Options | Network tab
---------------- | -----------
![GUI-options](/images/GUI-options.png) | ![network](/images/network.png)

## Check LAN  address
Search your lan address in the preferred way (network options or ipconfig cmd utility).
Lan address must be static in network options of your lan interface, or dhcp server (usually it runs on the router) must be configured to always assign the same ip to the mac address of the workstation/home server lan interface.
From now on it will be referenced by {YOUR LAN IP}

## Fill file deviant.conf
Open file deviant.conf<br />
![open deviant.conf](/images/edit-local-conf.png)

Add these parameters:<br />
```
masternode=1
masternodeaddr={YOUR PUBLIC IP}:22618
masternodeprivkey={MN PRIV KEY}
externalip={YOUR PUBLIC IP}
bind={YOUR LAN IP}
rpcallowip=127.0.0.1
daemon=1
server=1
listen=1
rpcport=22619
rpcbind=127.0.0.1
shrinkdebuglog=1
logtimestamps=1
```
## Fill file masternode.conf
Open file masternode.conf<br />
![open masternode.conf](/images/edit-masternode-conf.png)
![sample masternode.conf](/images/sample-masternode-conf.png)

Add these lines:<br />
```{MN ALIAS} {YOUR PUBLIC IP}:22618 {MN PRIV KEY} {MN TX-iD} {TX-ID IDX}```<br />
using the proper values instead the generic {PARAMETER}.
In [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) it is explained how to get most of them.<br />
The ones not found there, are explained in here.<br />
Restart your wallet to apply new conf files.

## Start alias
Go to Masternode menu, select the line related to your Masternode, then righ-click -> start-alias<br />

![mn-start-alias](/images/mn-start-alias.png)

You must unlock the wallet (also for staking only) to start-alias.<br />

![mn-start-unlock](/images/mn-start-unlock.png)

If start ends successfully, check the status of your Masternode with Debug Console:<br />

![rpc console](/images/rpc-console.png)

![mn-masternode-status](/images/mn-rpc-status.png)

Once you read also these lines:<br />
```
"status": 4,
"message": "Masternode successfully started"
```
with rpc command:<br />
```masternode status```<br />
Then your setup finished succesfully!<br />
Well done!!!<br />



