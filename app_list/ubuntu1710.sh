#!/usr/bin/env bash

set -euo pipefail

# sudo apt update -y && sudo apt upgrade -y

# sudo apt install -y apt-transport-https \
# 		  curl \
#		  git \
#         jq \
#         ubuntu-restricted-extras \
#         shutter

# sudo apt remove

#mkdir /tmp/apps
cd /tmp/apps

#***************
# Chrome
#***************

#wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#curl -sfLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb
#sudo apt install -fy

#***************
# Keybase
#***************

#curl -sfO https://keybase.io/docs/server_security/code_signing_key.asc
#gpg --import code_signing_key.asc 2> /dev/null
#curl -sfO https://prerelease.keybase.io/keybase_amd64.deb.sig
#curl -sfLO https://prerelease.keybase.io/keybase_amd64.deb
#gpg --verify keybase_amd64.deb.sig 2> keybase_verify
#grep "222B 85B0 F90B E2D2 4CFE  B93F 4748 4E50 656D 16C7" keybase_verify
#sudo dpkg -i keybase_amd64.deb
#sudo apt-get install -fy
#run_keybase

#***************
# Dropbox
#***************

#curl -sfLO https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
#sudo dpkg -i dropbox_2015.10.28_amd64.deb
#sudo apt install -fy

#***************
# Docker - Currently broken: https://github.com/docker/for-linux/issues/141
#***************

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"

#sudo apt update -y && sudo apt-get install -y docker-ce


#***************
# VSCode
#***************

#curl -sfL https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb
#sudo dpkg -i vscode.deb
#sudo apt install -fy

#***************
# Exa
#***************

# curl -sfLo exa.zip $(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep linux-x86 | cut -f 4 -d '"')
# curl -sfLO $(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep SHA1SUM | cut -f 4 -d '"')
# unzip exa.zip > /dev/null
# sha1sum --status --ignore-missing -c SHA1SUMS
# sudo mv exa-linux-x86_64 /usr/local/bin/exa

#***************
# RipGrep
#***************

# curl -sfLo rg.tar.gz $(curl -s https://api.github.com/repos/burntsushi/ripgrep/releases/latest | grep browser_download_url | grep x86_64-unknown-linux-musl.tar.gz | cut -f 4 -d '"')
# tar xvzf rg.tar.gz > /dev/null
# cd ripgrep*
# cp complete/rg.bash-completion ~/dotfiles/

# if [[ ! -d /usr/local/share/man/man1 ]]; then
#     sudo mkdir /usr/local/share/man/man1
# fi

# sudo cp rg.1 /usr/local/share/man/man1/
# sudo mandb
# sudo cp rg /usr/local/bin

#***************
# Micro
#***************

# curl -sfLo m.tar.gz $(curl -s https://api.github.com/repos/zyedidia/micro/releases/latest | grep browser_download_url | grep linux64 | cut -f 4 -d '"')
# tar xvzf m.tar.gz > /dev/null
# cd micro*
# sudo cp micro /usr/local/bin

#***************
# Alacritty
#***************

# TODO

#***************
# Gnome Dash to Panel
#***************

# curl -sfLo dash2panel.zip $(curl -s https://api.github.com/repos/jderose9/dash-to-panel/releases/latest | grep zipball_url | cut -f 4 -d '"')
# unzip dash2panel.zip > /dev/null
# cd jderose9*
# make install > /dev/null
# cd ..

#***************
# TopIconsPlus
#***************

# curl -sfLo topicons.zip $(curl -s https://api.github.com/repos/phocean/TopIcons-plus/releases/latest | grep zipball_url | cut -f 4 -d '"')
# unzip topicons.zip > /dev/null
# cd phocean*
# make install > /dev/null
# cd ..

#***************
# ArcMenu
#***************

curl -sfLo arcmenu.zip $(curl -s https://api.github.com/repos/LinxGem33/Arc-Menu/releases/latest | grep zipball_url | cut -f 4 -d '"')
unzip arcmenu.zip > /dev/null
cd LinxGem33*
make install
cd ..

#***************
# Clean up
#***************

# cd $HOME
# rm -rf /tmp/apps
# sudo apt clean && sudo apt autoremove

#***************
# Set basic settings for above
#***************

gsettings set org.gnome.desktop.background picture-uri 'file:///home/bob/Dropbox/config/Wallpapers/jedi_order.jpg'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///home/bob/Dropbox/config/Wallpapers/jedi_order.jpg'
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Darker'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.shell enabled-extensions "['dash-to-panel@jderose9.github.com', 'TopIcons@phocean.net']"

#***************
# Additional settings
#***************

gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.desktop.media-handling autorun-never true