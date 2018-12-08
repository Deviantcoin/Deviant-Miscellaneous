# Setup wallet
## Setup QT wallet on Windows
### Download wallet
The wallet is available on [github](https://github.com/Deviantcoin/Source/releases).
Search for latest release, then download the wallet that matches your Windows arch.<br />
You will find four lines for windows.<br />

![latest](/images/latest-win.png)

- `deviant-<release>-win32-setup-unsigned.exe`
- `deviant-<release>-win32.zip`
- `deviant-<release>-win64-setup-unsigned.exe`
- `deviant-<release>-win64.zip`

Win32 wallet can be executed also on win64; win64 wallet can be executed only on win64.<br />
The exe packages, are typical windows installer setup files, the double click will execute the setupe wizard.<br />
The zip packages contains the standalone executables that can be executed without a windows setup.</ br>
Both ways will be described here.</ br>

### Execute the setup
Executing the setup file, will install the wallet in the windows way (next -> next -> next).

![setup1](/images/setup1.png)

![setup2](/images/setup2.png)

The first time you execute the wallet, you have to set the default directory.

![setup dir](/images/setup-dir.png)

The default installation path is `%APPDATA%\DeviantCore%`. <br />
Once the directory has been choosen, the wallet will load its data and will start the sync of the blockchain.

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
### Execute the standalone executables
The windows zip packages contains the standalone executables and the installer.<br />
You can extract it with the default utility "Compressed folder". In this example, the package will be extracted in C:\Deviantcoin

![extract1](/images/exctract1.png)

![extract2](/images/extract2.png)

According to your Windows release, you may need to unlock the executables - every one of them.<br />
Right click on the file --> set flag on "Unblock" in General tab (see the example below).

![unblock](/images/unblock.png)

Just execute the file `deviant-qt.exe` from exctracting folder to run the wallet.<br />

### Encrypting the wallet
When the sync is finished, it is recommended to encrypt the wallet before transfering funds to it.<br />
This action will enhance the security of your wallet. Once the wallet is encrypted. you need to unlock it before moving funds.

Step | On screen
---- | ---------
Open the menu | ![menu encrypt](/images/open-encrypt-wallet.png)
Enter passhphrase | ![enter passphrase](/images/passphrase-encrypt-wallet.png)
Confirm | ![confirm encryption](/images/confirm-encrypt-wallet.png)
Read warning info! | ![warning](/images/warning-encrypt-wallet.png)

## Setup Cli wallet Linux
### Identify your architecture
The wallets are available on [github](https://github.com/Deviantcoin/Source/releases).<br />
The precompiled Deviant cli wallet can run on several kind of Linux builds.<br />
To identify the architecture of your operating system, execute the command:<br />
`uname -m`<br />
### Download the wallet
If the previous output fits a line in the below "Output" column field, the wallet you need is available as precompiled package.<br /> 
You can use the utility `wget` to download the wallet.<br />
 
 Output | Command
 ------ | -------
 armv7l | ```wget $(curl -s https://api.github.com/repos/Deviantcoin/Source/releases/latest | grep browser_download_url | grep -e "arm-linux-gnueabihf"| cut -d '"' -f 4)```
 i686 | `wget $(curl -s https://api.github.com/repos/Deviantcoin/Source/releases/latest | grep browser_download_url | grep -e "i686-pc-linux"| cut -d '"' -f 4)`
 x86_64 | `wget $(curl -s https://api.github.com/repos/Deviantcoin/Source/releases/latest | grep browser_download_url | grep -e "x86_64-linux"| cut -d '"' -f 4)`

### Install and run the wallet
You need the unzip utility to extract the wallet.
 
Distro | Command
------ | -------
Ubuntu/Debian | `sudo apt -y install unzip`
Fedora/Centos | `sudo yum -y install unzip`

Output | Command
------ | -------
armv7l | `sudo unzip -o -j dev-3.0.0.1-linux-arm32.zip *deviantd *deviant-cli -d /usr/local/bin`
aarch64 | `sudo unzip -o -j dev-3.0.0.1-linux-arm64.zip *deviantd *deviant-cli -d /usr/local/bin`
x86_64 | `sudo unzip -o -j dev-3.0.0.1-linux-x86_64.zip *deviantd *deviant-cli -d /usr/local/bin`
 
So, in order to run a cli wallet you need (example for arm32):<br />
```
wget https://github.com/Deviantcoin/Wallet/raw/master/dev-3.0.0.1-linux-arm32.zip
sudo unzip -o -j dev-3.0.0.1-linux-arm32.zip *deviantd *deviant-cli -d /usr/local/bin
deviantd -printtoconsole
``` 
The option "-printtoconsole" during the first run is useful because you have a real time report on screen.<br />  

Tip: after the first sync, to run the wallet in background, you can execute it with command:<br />
```deviantd -daemon```

### Encrypting the wallet
When the sync is finished, it is recommended to encrypt the wallet before transfering funds to it.<br />
This action will enhance the security of your wallet. Once the wallet is encrypted, you need to unlock it before moving funds.
To encrypt the wallet you use deviant-cli utility:
```
deviant-cli encryptwallet '<your passphrase>'
```
Tip: to avoid to save `'<your passphrase>'` in the history, press space before the commands that require `'<your passphrase>'`.
When wallet encryption ends, the wallet will close itself, so you will need to start it again.

Before you transfer funds, you must be aware about zeromint.
Zeromint will mint DEVs into zDEVs. The CLI wallet has this feature enabled by default.
If you don't need to mix DEVs into zDEV, to change the default behaviour, you must set the parameter `enablezeromint=0` in file `deviant.conf`.

### Alternatives
The default CLI wallets are built on recent software stack.
If you use a distro built on an older software stack, you may encounter errors like:<br />
```
Segmentation fault
```
```
deviantd: /lib64/libstdc++.so.6: version 'GLIBCXX_3.4.20' not found (required by deviantd)
deviantd: /lib64/libstdc++.so.6: version 'CXXABI_1.3.8' not found (required by deviantd)
deviantd: /lib64/libstdc++.so.6: version 'GLIBCXX_3.4.21' not found (required by deviantd)
```
In this case, you can use an alternative CLI wallet that is built on an older software stack.<br />

Arch | Download | Install
---- | -------- | -------
armv7l | `wget https://github.com/Deviantcoin/Deviant-Miscellaneous/raw/work-in-progress/linux/alternatives/dev-3.0.0.1-linux-arm32-alternatives.zip` | `sudo unzip -o -j dev-3.0.0.1-linux-arm32-alternatives.zip *deviantd *deviant-cli -d /usr/local/bin`
x86_64 | `wget https://github.com/Deviantcoin/Deviant-Miscellaneous/raw/work-in-progress/linux/alternatives/dev-3.0.0.1-linux-x86_64-alternatives.zip` | `sudo unzip -o -j dev-3.0.0.1-linux-x86_64-alternatives.zip *deviantd *deviant-cli -d /usr/local/bin`

Another alternative is to compile the sources on your own.
Following the instruction for Debian/Ubuntu.<br />
```
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt update
sudo apt install git \
 build-essential \
 libtool \
 autotools-dev \
 automake \
 pkg-config \
 libssl-dev \
 libevent-dev \
 bsdmainutils \
 libboost-system-dev \
 libboost-filesystem-dev \
 libboost-chrono-dev \
 libboost-program-options-dev \
 libboost-test-dev \
 libboost-thread-dev \
 libminiupnpc-dev \
 libzmq3-dev \
 libdb4.8-dev \
 libdb4.8++-dev \
 jq
git clone https://github.com/Deviantcoin/Source.git
chmod 755 -R Source/
cd Source
./autogen.sh
./configure --without-gui --disable-tests
make
sudo make install
```

Following the instructions for Raspbian/Ubuntu:<br />
```
sudo apt install git \
 build-essential \
 libtool \
 autotools-dev \
 automake \
 pkg-config \
 libssl-dev \
 libevent-dev \
 bsdmainutils \
 libboost-system-dev \
 libboost-filesystem-dev \
 libboost-chrono-dev \
 libboost-program-options-dev \
 libboost-test-dev \
 libboost-thread-dev \
 libminiupnpc-dev \
 libzmq3-dev \
 jq
mkdir db4
cd db4 
wget https://github.com/Deviantcoin/Deviant-Miscellaneous/raw/master/linux/install_db4.sh
./install_db4.sh $(pwd)
cd ..
git clone https://github.com/Deviantcoin/Source.git
chmod 755 -R Source/
cd Source
./autogen.sh
./configure CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" \ 
 --enable-cxx --without-gui --disable-shared --with-pic --enable-upnp-default \ 
 --with-unsupported-ssl --disable-tests
make
sudo make install
```
 
 




