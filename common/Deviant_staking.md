# Deviant Staking Guide
## QT wallet
### Prerequisites
1. The wallet has been setup (verify [here](/common/Setup_wallet.md))
### Creating a Staking Address
Open the receiving address menu from your wallet.<br />

![receiving address](/images/rec-address.png)

Click the "New" push button, fill in the label field with a name, and Confirm with the "OK" push button.
The results will look like the image below (STAKE label as example):

![staking address](/images/receiving-stake.png)

### Enabling Coin Control<br />
The Coin Control feature allows the user to select the input that must be used to withdraw DEV when sending transactions. Without Coin Control enabled, you can't select the sending input, so you may corrupt the setup of input stakes, or destroy an unlocked Masternode collateral, for example. The Send menu, without Coin Control, looks like the below picture:
<br />
![No Coin Control](/images/noCoinControl.png)
<br />
The option to enable the Coin Control feature is in the Gui Wallet. You can activate it by hitting<br />
Settings -> Options -> Wallet<br />

Settings Options | Wallet tab
---------------- | ----------
![GUI-options](/images/GUI-options.png) | ![flagCoinControl](/images/flagCoinControl.png)

<br />
In the wallet tab, just flag "Enable Coin Control" to enable such feature.
Once enabled, the Send menu will look like this:<br />

![box coin control](/images/boxCoinControl.png)

Just click on Coin Control, which will open a new menu.

![flagCoinControl](/images/intoCoinControl2.png)

In this menu, just select the input(s) you want to stake, then press Ok.
### Split your DEV into stake inputs
Copy the amount visible in "After Fee" field in "Amount" field.<br />
Set the previously created address in "Pay To:" field. <br />
Set flag in "Split UTXO" field, then write in the editable field the number (an integer) of inputs you want split your amount.

![UTXO](/images/utxo.png)

Note: There is not a formula to calculate the optimal size of inputs. It depends on the values staking on the network. Also optimal size is not a constant and it changes with time.<br />
Sharing experience about staking with other users may improve the staking experience.
### Start staking
Once the inputs setup is finished, in order to stake you have two prerequisites:
1. Your inputs needs 60 confirmations<br />

A way to count confirmations, is to open "Coin Control" in "list mode", then read confirmations in the homonimous column.

![confirmations](/images/confirmations.png)

2. Your wallet needs to be unlocked (recommended option is "For anonymization, automint, and staking only")<br />

Step | On screen
---- | ---------
Open the menu | ![menu unlock](/images/unlock-wallet-menu.png)
Enter passhphrase | ![enter passphrase](/images/unlock-wallet-password.png)
Verify | ![verify unlock](/images/unlock-wallet-verify.png)


