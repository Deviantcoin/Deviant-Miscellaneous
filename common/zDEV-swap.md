# How to swap zDEV balance
## Disable zDEV
Before swapping your zDEV, you must be sure no more new zDEV will be minted until you update the wallet (coming soon - latest tests are ongoing).<br />

In each wallet you are running, close the wallet, then add the parameter <br />
```enablezeromint=0``` in file deviant.conf.<br />

Keep in mind that the parameter can be overwritten in the QT wallet, via "Settings -> Options -> Enable zDEV automint"<br />
![zDEV enable zDEV](/images/zdev-enable-zdev.png)

and via "Privacy -> Mint Zerocoin"<br />
![zDEV mintzerocoin](/images/zdev-mint-zdev.png)

## Get your zdevseed
Open the debug console via "Tools" menu.<br />
![zDEV-Console](/images/zdev-debug-console.png)
1. Fire the command `getzdevseed`. <br />
2. Copy the zdevseed output. <br />
![zDEV 1-2](/images/zdev-get-1-2.png)

3. Paste the zdevseed on a text editor. <br />
![zDEV-Paste-1](/images/zdev-paste-notepad1.png)

If you are using CLI wallet, you can get your zdevseed firing the following command:<br />
```
deviant-cli getzdevseed
```

## Sign the message
Open the "Sign message" function, via "File" menu.<br />
![zdev sign menù](/images/zdev-sign-menu.png)

1. Select the signing address from "Choose previously used address" function.<br />
![zDEV sign 1](/images/zdev-sign-addr.png)
2. Paste the address on the same text editor you used previously.<br />
![zDEV sign 2](/images/zdev-paste-addr.png)
3. Fill the signing menu with the info collected.<br />
![zDEV paste seed](/images/zdev-paste-zdevseed.png)
4. Sign the message.<br />
![zDEV sign](/images/zdev-sign-message.png)
5. Paste the Signature on the text editor.<br />
![zDEV paste sign](/images/zDEV-paste-sign.png)

If you are running a CLI wallet, you can get an address to sign with one of following commands:<br />
```
deviant-cli listaddressgroupings
```
```
deviant-cli getaccountaddress ""
```

You can sign the message with this command:<br />
```
deviant-cli signmessage "deviantaddress" "message"
```
According the example given for QT wallet, the command will be: <br />
```
deviant-cli signmessage "dXBKqN9aRZbKfpZz2SKF5obDbn8YSzxYYT" "b1ab05a7e2d1715b2b83517559874890f4500445dc5c9f0d9ea4c6ed724a4130"
```
![zDEV sign CLI](/images/zdev-sign-cli.png)



## Get your zDEV balance.<br />
![zDEV Balance](/images/zDEV-balance.png)

If you are running a CLI wallet, you can check your zDEV balance with this command:<br />
```
deviant-cli getzerocoinbalance
```

## Send the e-mail to `zdev@deviantcoin.io`.<br />
Using the info collected in the text editor, fill and send an e-mail with following info:<br />
```
To: zdev@deviantcoin.io
Subject: zDEV SWAP <address>
Body text:
addr: <address>
zdevseed: <zdevseed>
sign: <message sign>
zDEV balance: <zDEV balance>
Discord ID: 123456789123456789
Telegram Username: @username
```
![zDEV mail](/images/zDEV-mail.png)
The balance claimed with the mail will be checked via zdevseed.

## Last but not least:

## DISCLAIMER:

1. The support team will not contact you directly. If you need additional info or support, please write a Private Message to the support team, via Discord, Telegram, or contact them at support@deviantcoin.io. Do not write in public chat in order to avoid attracting attention from scammers.
2. Do not share your info with anyone. Just use it to fill the criteria in the e-mail.
3. Keep in mind, that if you share your zdevseed with a scammer and he claims the balance before you do, he will be the owner of the balance. 
4. The cutoff for swapping your zdev is ##11/27!! Make sure you submit this information before or by that deadline.


