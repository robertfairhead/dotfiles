#!/usr/bin/env bash

set -euo pipefail

# sudo apt update -y && sudo apt upgrade -y

#sudo apt install apt-transport-https \
# 		  curl \
#		  git


mkdir /tmp/apps
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

#***************
# RipGrep
#***************

#***************
# Micro
#***************

#***************
# Alacritty
#***************

rm -rf /tmp/apps
