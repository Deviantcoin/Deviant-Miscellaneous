# How to swap zDEV balance
## Disable zDEV
Before swapping your zDEV you must be sure no more new zDEV will be minted, until you update the wallet (coming soon, latest tests are ongoing).<br />
Every wallet you are running, close the wallet then add the parameter <br />
```enablezeromint=0``` in file deviant.conf.
## Get your zdevseed
Open the debug console via "Tools" menù.<br />
![zDEV-Console](/images/zdev-debug-console.png)
1. Fire the command `getzdevseed`. <br />
2. Copy the zdevseed output. <br />
![zDEV 1-2](/images/zdev-get-1-2.png)

3. Paste the zdevseed on a text editor. <br />
![zDEV-Paste-1](/images/zdev-paste-notepad1.png)

## Sign the message
Open the "Sign message" function, via "File" menù.<br />
![zdev sign menù](/images/zdev-sign-menu.png)

1. Select the signing address from "Choose previously used address" function.<br />
![zDEV sign 1](/images/zdev-sign-addr.png)
2. Paste the address on the same text editor you used previously.<br />
![zDEV sign 2](/images/zdev-paste-addr.png)
3. Fill the signing menù with the info collected.<br />
![zDEV paste seed](/images/zdev-paste-zdevseed.png)
4. Sign the message.<br />
![zDEV sign](/images/zdev-sign-message.png)
5. Paste the sign on the text editor.<br />
![zDEV paste sign](/images/zDEV-paste-sign.png)
## Get your zDEV balance.<br />
![zDEV Balance](/images/zDEV-balance.png)
## Send the mail to `zdev@deviantcoin.io`.<br />
Using the info collected in the text editor, fill and send a mail with following info:<br />
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

## Last but not least
1. The support team will not contact you. If you need info, write a Private Message to support team, via discord or via telegram, do not write in public chat, avoid to attract attention from scammers.
2. Do not share your info with anyone, just use them to fill the mail.


