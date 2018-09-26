# Setup wallet
## Setup QT wallet on Windows
### Download wallet
The wallet is available on [github](https://github.com/Deviantcoin/Source/releases).
Search for latest release, then download the wallet that matches your Windows arch.

![latest](/images/latest.png)

Win32 wallet can be executed also on win64; win64 wallet can be executed only on win64.
### Extract Package content
The windows zip packages contain the standalone executables and the installer.

![win package](/images/win-content.png)

You can extract it with the default utility "Compressed folder". In this example, the package will be extracted in C:\Deviantcoin

![extract1](/images/exctract1.png)

![extract2](/images/extract2.png)

According to your Windows release, you may need to unlock the executables - every one of them.<br />
Right click on the file --> set flag on "Unblock" in General tab (see the example below).

![unblock](/images/unblock.png)

### Setting up the wallet
There are two ways to install a QT Deviant wallet:<br />
1. Just execute the file `deviant-qt.exe` from exctracting folder.
2. Run the setup, that will install the wallet package in the windows way (next -> next -> next).

![setup1](/images/setup1.png)

![setup2](/images/setup2.png)

The first time you execute the wallet, you have to set the default directory.

![setup dir](/images/setup-dir.png)

The default installation path is `%APPDATA%\DeviantCore%`. <br />
Once the directory has been choosen, the wallet will load its data and start the sync of the blockchain.

![first sync](/images/first-sync.png)

If the sync does not start in minutes, you may need to add peers to the deviant.conf file.

![deviant.conf](/images/open-dev-conf.png)

Add the nodes below, save and close the file, then restart the wallet.
```
addnode=209.97.139.2
addnode=45.35.64.39
addnode=138.197.146.236
addnode=167.99.234.81
addnode=206.189.155.48
addnode=209.97.131.147
addnode=209.97.131.20
addnode=209.97.139.20
addnode=219.74.243.91
addnode=109.10.53.168
addnode=178.239.54.249
```
### Encrypting the wallet
When the sync is finished, it is recommended to encrypt the wallet before transfering funds to it.<br />
This action will enhance the security of your wallet, once the wallet is encrypted you need to unlock it before moving funds.

Step | On screen
---- | ---------
Open the menu | ![menu encrypt](/images/open-encrypt-wallet.png)
Enter passhphrase | ![enter passphrase](/images/passphrase-encrypt-wallet.png)
Confirm | ![confirm encryption](/images/confirm-encrypt-wallet.png)
Read warning info! | ![warning](/images/warning-encrypt-wallet.png)

## Setup Cli wallet on Linux



