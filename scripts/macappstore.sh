#!/bin/bash

echo "###############################"
echo "Mac Appstore"
echo "###############################"

echo "    OneDrive"
echo "    XCode"
echo "    XCode commandline"

xcode-select --install

echo "    1Password"

#Switch to OPVault Format
defaults write 2BUA8C4S2C.com.agilebits.onepassword-osx-helper useOPVaultFormatByDefault true
