#!/usr/bin/env bash

#https://wikitech.wikimedia.org/wiki/Yubikey-SSH

if [ $OS == "linux" ]; then
    sudo apt-get install yubikey-personalization yubico-piv-tool opensc pcscd
fi

