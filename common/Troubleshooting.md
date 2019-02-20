# Troubleshooting
## QT wallet - The options in the "Tools" menu are not available
### Issue
You use Deviant-QT wallet on Windows operating system. <br />
You are unable to open any of the "Tools" options:

![tools](/images/QT-tools.png)

### Solutions
To solve this issue, you need to reset the Deviant-QT entries in the Windows registry.
To reset these entries, open the "regedit" utility. <br />

![regedit](/images/QT-regedit.png)

The Deviant-QT entries are located in the tree `Computer\HKEY_CURRENT_USER\Software\Deviant\Deviant-Qt`<br />

![deviant-qt tree](/images/regedit-deviant-tree.png)

Once you've found the tree: <br />
1. Close your QT wallet
2. Right-click on `Deviant-QT`, then use the Export function (this is a backup)
3. Right-click on `Deviant-QT`, then use the Delete function
4. Open your QT wallet

The issue should be solved.

## QT wallet does not sync anymore
### Issue
You use Deviant wallet, QT or cli as well, on any supported Operating System. <br />
Your wallet does not sync anymore. <br />
In `Tools -> Peers list` there are a lot of banned peers. <br />
In the debug.log file, there are tens of lines like this one below:

```
ERROR: AcceptBlock : prev block deb3a98644eba2810926365d5e8ae38ce773c5573b6855cccb2c0ec541a0349c is invalid, unable to add block 35df2e0f3cae13aba926369554762394a93837c6ddaffba08a3f4dfb328a5f15
ERROR: ProcessNewBlock : AcceptBlock FAILED
Misbehaving: xxx.xxx.xxx.xxx:22618 (1 -> 101) BAN THRESHOLD EXCEEDED && Flag = 13
socket recv error An existing connection was forcibly closed by the remote host.  (10054)
```

### Solution
Check the "prev block" (deb3a98644eba2810926365d5e8ae38ce773c5573b6855cccb2c0ec541a0349c in this example) on one of official explorers ([Master](http://explorer.deviantcoin.io)/[Backup](https://chainz.cryptoid.info/dev)).
#### Case one - Block found
If "prev block" is found on the explorer, the "reconsiderblock" action should solve the issue.<br />
Open the debug console (`Tools -> Debug console`) then execute:
```
reconsiderblock deb3a98644eba2810926365d5e8ae38ce773c5573b6855cccb2c0ec541a0349c
```
If you are running the cli wallet (or you have the parameter `server=1` in the QT wallet), you can execute:
```
deviant-cli reconsiderblock deb3a98644eba2810926365d5e8ae38ce773c5573b6855cccb2c0ec541a0349c
```
Under some circumstancies, the above procedure will produce a new error:
```
ERROR: Load : cannot find checksum 2368503306
ERROR: InitializeAccumulators: failed to reset to previous checkpoint
ERROR: CalculateAccumulatorCheckpoint: failed to initialize accumulators
ERROR: ValidateAccumulatorCheckpoint : failed to calculate accumulator checkpoint
ERROR: ConnectBlock: Failed to validate accumulator checkpoint for block=deb3a98644eba2810926365d5e8ae38ce773c5573b6855cccb2c0ec541a0349c height=341750
```
You can try to restart your wallet with the following options:
```
-reindexaccumulators -reindexzerocoin
```
If this procedure does not work, follow "Case two - Block not found".
#### Case two - Block not found
If "prev block" is not found on the explorer, to solve this issue, the only way is to sync the wallet from scratch.<br />
You may try the `-reindex` option in the Wallet repair menu by clicking (`Tools -> Wallet Repair`). It is less time expensive, but doesn't guarantee the success of fixing your wallet issue.
