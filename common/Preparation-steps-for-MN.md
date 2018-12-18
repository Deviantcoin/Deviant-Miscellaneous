# Preparation steps to run a Deviant Masternode<br />
This guide covers the following points:<br />
1. Enabling Coin Control
2. Creating a Masternode Address
3. Generating a Masternode Private Key
4. Masternode collateral
<br />
The steps described here can be applied on QT GUI wallet for Windows, MacOS, and Linux.

## Enabling Coin Control<br />
The Coin Control feature allows the user to select the input that must be used to withdraw DEV when sending transactions. Without Coin Control enabled, you can't select the sending input, so you may corrupt the setup of input stakes, or destroy an unlocked Masternode collateral, for example. The Send menu, without Coin Control, looks like the below picture:
<br />
![No Coin Control](/images/noCoinControl.png)
<br />
The option to enable the Coin Control feature is in the GUI Wallet:<br />
Settings -> Options -> Wallet<br />

Settings Options | Wallet tab
---------------- | ----------
![GUI-options](/images/GUI-options.png) | ![flagCoinControl](/images/flagCoinControl.png)

<br />
In the wallet tab, just flag "Enable Coin Control" to enable such feature.
Once enabled, the Send menu will look like this:<br />
<br />
<p><img src="/images/boxCoinControl.png" alt="CoinControl" /></p>
<br />
Just click on Coin Control, which will open a new menu.
<br />
<p><img src="/images/intoCoinControl.png" /></p>
<br />
In such menu, you're free to select the sending inputs, leaving untouched collateral and staking ones.

## Creating a Masternode Address
Open the Receiving address menu from your wallet.<br />
<p><img src="/images/rec-address.png" /></p>
<br />
Click the "New" push button, fill in the label field with a name, and Confirm with "OK" push button. The results will look like the image below (MN label as example):
<br />
<p><img src="/images/mn-label.png" /></p>
<br />
From now on, the masternode address will be referenced by <br />
`{MN ALIAS}`<br />

## Generating a Masternode Private Key
The Masternode private key is a unique key that identifies a Masternode. Such key can be generated from a RPC console (aka Debug Console) embedded in the wallet, with command: <br />
`masternode genkey`<br />
<p><img src="/images/rpc-console.png" /></p>
<br />
<p><img src="/images/mn-genkey.png" /></p>
<br />
<p><img src="/images/mn-genkey-out.png" /></p>
<br />
From now on, the private key will be referenced by <br />
`{MN PRIV KEY}`<br />

## Masternode collateral
The Masternode collateral is an amount of 5000 DEV that must be locked in order to run a Masternode. The 5000 DEV become collateral after a user sends such amount in one atomic transaction to {MN ADDR}.
Any additional fees must be added to the amount.<br />
<p><img src="/images/send-5000.png" /></p>
<br />
<p><img src="/images/confirm-5000.png" /></p>
<br />
Once the transaction reaches 6 confirmations, the "transaction hash" and the related "output index" can be shown via RPC console firing the command:<br />
`masternode outputs`<br />
<p><img src="/images/mn-output.png" /></p>
<br /> 
From now on, the "transaction hash" key will be referenced by <br />
`{MN TX-iD}`<br />
the "output index" will be referenced by <br />
`{TX-ID IDX}`<br />
