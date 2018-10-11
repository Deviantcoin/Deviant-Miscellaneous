# Setting up Windows firewall
## Outbound rules
1. Open "Windows firewall with Advanced Security"

![Open firewall](/images/WIN-open-firewall.png)

2. Select "Outbound Rules" on the left side, then "New rule" on the right side

![New out](/images/WIN-new-out.png)

3. Use option "Program" then press "Next"

![Option program](/images/WIN-option-program.png)

4. Use "Browse" to select the `deviant-qt.exe` executable, then press "Next"

![Browse to deviant-qt](/images/WIN-out-browse-to-deviant-qt.png)

5. Select "Allow the connection", then press "Next"

![Allow out](/images/WIN-out-allow.png)

6. Leave default on "Profile" selection (every checkbox is flagged)

![Select profile](/images/WIN-out-profile.png)

7. Type a name for the rule, then press "Next"

![Select a name](/images/WIN-out-select-name.png)

8. Repeat steps 1. to 7. to create a rule also for `deviantd.exe` (step 4.). When you reach step 7. use a name different from the previous one.

## Inbound rules
1. Open "Windows firewall with Advanced Security"

![Open firewall](/images/WIN-open-firewall.png)

2. Select "Inbound Rules" on the left side, then "New rule" on the right side

![New out](/images/WIN-new-in.png)

3. Use option "Program" then press "Next"

![Option program](/images/WIN-in-option-program.png)

4. Use "Browse" to select the `deviant-qt.exe` executable, then press "Next"

![Browse to deviant-qt](/images/WIN-in-browse-to-deviant-qt.png)

5. Select "Allow the connection", then press "Next"

![Allow out](/images/WIN-in-allow.png)

6. Leave default on "Profile" selection (every checkbox is flagged)

![Select profile](/images/WIN-in-profile.png)

7. Type a name for the rule, then press "Next"

![Select a name](/images/WIN-in-select-name.png)

8. Repeat steps 1. to 7. to create a rule also for `deviantd.exe` (step 4.). When you reach step 7. use a name different from the previous one.
