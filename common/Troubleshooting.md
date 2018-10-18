# Troubleshooting
## QT wallet - The options in the "Tools" menù are not available
### Issue
You use Deviant-QT wallet on windows operating system. <br />
You are unable to open any of the "Tools" options:

![tools](/images/QT-tools.png)

### Solutions
To solve this issue you need to reset the Deviant-QT entries in Windows registry.
To reset this entries, open the "regedit" utility. <br />

![regedit](/images/QT-regedit.png)

The Deviant-QT entries are located in the tree `Computer\HKEY_CURRENT_USER\Software\Deviant\Deviant-Qt`<br />

![deviant-qt tree](/images/regedit-deviant-tree.png)

Once you found the tree: <br />
1. Close your QT wallet
2. Righ click on `Deviant-QT`, then use Export function (this is a backup)
3. Righ click on `Deviant-QT`, then use Delete function
4. Open your QT wallet

The issue should be solved
