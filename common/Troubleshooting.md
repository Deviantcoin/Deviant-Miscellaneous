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
