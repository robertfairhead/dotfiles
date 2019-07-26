#!/usr/bin/env bash

set -euo pipefail

cleanup () {
  cd $HOME
  sudo rm -rf /tmp/apps
  sudo apt clean && sudo apt autoremove -y
}

trap cleanup EXIT

sudo add-apt-repository ppa:papirus/papirus -y
sudo add-apt-repository ppa:jonathonf/vim -y

sudo apt update -y && sudo apt upgrade -y

sudo apt remove -y --no-install-recommends ubuntu-web-launchers thunderbird \
                telnet ufw avahi* popularity-contest \
                aisleriot transmission-common transmission-gtk remmina remmina-common vino \
                deja-dup gnome-user-share gedit gedit-common ubuntu-software gnome-software update-manager \
                libreoffice-core libreoffice-common cheese rhythmbox rhythmbox-data shotwell shotwell-common \
                gnome-calendar gnome-mahjongg gnome-mines gnome-online-accounts gnome-orca gnome-sudoku

sudo apt install -y apt-transport-https ubuntu-restricted-extras ca-certificates \
		curl git jq tmux xclip make htop vim vim-gnome \
        flameshot \
        gnome-tweak-tool dconf-editor \
        gnome-shell-extensions arc-theme papirus-icon-theme

mkdir -p /tmp/apps
cd /tmp/apps

#***************
# Epson scanner software
#***************

# curl -sfLO https://download2.ebz.epson.net/imagescanv3/ubuntu/latest1/deb/x64/imagescan-bundle-ubuntu-17.10-1.3.23.x64.deb.tar.gz
# tar xvzf imagescan-bundle-ubuntu-17.10-1.3.23.x64.deb.tar.gz
# cd imagescan-bundle-ubuntu-17.10-1.3.23.x64.deb
# ./install.sh
# cd ..

#***************
# Chrome
#***************

curl https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
curl -sfLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || true
sudo apt install -fy

#***************
# Keybase
#***************

curl -sfO https://keybase.io/docs/server_security/code_signing_key.asc
gpg --import code_signing_key.asc 2> /dev/null
curl -sfO https://prerelease.keybase.io/keybase_amd64.deb.sig
curl -sfLO https://prerelease.keybase.io/keybase_amd64.deb
gpg --verify keybase_amd64.deb.sig 2> keybase_verify
grep -q "222B 85B0 F90B E2D2 4CFE  B93F 4748 4E50 656D 16C7" keybase_verify
sudo dpkg -i keybase_amd64.deb || true
sudo apt-get install -fy
run_keybase

#***************
# Dropbox
#***************

# curl -sfLO https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
# sudo dpkg -i dropbox_2015.10.28_amd64.deb || true
# sudo apt install -fy

#***************
# Simplenote
#***************

curl -sfLo simplenote.deb $(curl -s https://api.github.com/repos/Automattic/simplenote-electron/releases/latest | grep browser_download_url | grep amd64\.deb | cut -f 4 -d '"')
sudo dpkg -i simplenote.deb || true
sudo apt install -fy

#***************kj
# Docker
#***************

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

sudo apt update -qq && sudo apt-get install -y docker-ce

sudo usermod -aG docker $(whoami)

#***************
# Docker Compose
#***************

curl -sfLO $( curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep "$(uname -s)-$(uname -m)" | head -n 1 | cut -f 4 -d '"')
curl -sfLo docker-compose.sha256 $(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep "$(uname -s)-$(uname -m)" | tail -n 1 | cut -f 4 -d '"')
sha256sum --status --ignore-missing -c docker-compose.sha256
mv "docker-compose-$(uname -s)-$(uname -m)" docker-compose
chmod +x docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose


#***************
# VSCode
#***************

curl -sfL https://go.microsoft.com/fwlink/?LinkID=760868 -o vscode.deb
sudo dpkg -i vscode.deb || true
sudo apt install -fy


#***************
# Etcher
#***************

echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt update -qq && sudo apt install -y balena-etcher-electron

#***************
# Exa
#***************

curl -sfLo exa.zip $(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep linux-x86 | cut -f 4 -d '"')
curl -sfLO $(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep browser_download_url | grep SHA1SUM | cut -f 4 -d '"')
unzip exa.zip > /dev/null
sha1sum --status --ignore-missing -c SHA1SUMS
sudo mv exa-linux-x86_64 /usr/local/bin/exa

#***************
# RipGrep
#***************

curl -sfLo rg.tar.gz $(curl -s https://api.github.com/repos/burntsushi/ripgrep/releases/latest | grep browser_download_url | grep x86_64-unknown-linux-musl.tar.gz | cut -f 4 -d '"')
tar xvzf rg.tar.gz > /dev/null
cd ripgrep*

sudo mkdir -p /usr/local/share/man/man1

sudo cp doc/rg.1 /usr/local/share/man/man1/
sudo mandb
sudo cp rg /usr/local/bin

#***************
# Bat
#***************

curl -sfLo bat.deb $(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep browser_download_url | grep bat_.*amd64\.deb | cut -f 4 -d '"')
sudo dpkg -i bat.deb || true
sudo apt install -fy

#***************
# Dive
#***************
# All releases are pre-release so this doesn't work yet
# curl -sfLo bat.deb $(curl -s https://api.github.com/repos/wagoodman/dive/releases/latest | grep browser_download_url | grep dive.*amd64\.deb | cut -f 4 -d '"')
# sudo apt install -fy
# sudo cp dive /usr/local/bin

#***************
# Micro
#***************

curl -sfLo m.tar.gz $(curl -s https://api.github.com/repos/zyedidia/micro/releases/latest | grep browser_download_url | grep linux64 | cut -f 4 -d '"')
tar xvzf m.tar.gz > /dev/null
cd micro*
sudo cp micro /usr/local/bin

#***************
# USQL universal sql client
#***************

curl -sfLo usql.tar.bz2 $(curl -s https://api.github.com/repos/xo/usql/releases/latest | grep browser_download_url | grep linux | cut -f 4 -d '"')
tar -vxjf usql.tar.bz2 > /dev/null
sudo mv usql /usr/local/bin/

#***************
# psql
#***************

sudo apt install postgresql-client -y --no-install-recommends

#***************
# Alacritty
#***************

sudo add-apt-repository -y ppa:system76/pop
sudo apt-get update -y
sudo apt install -y --no-install-recommends alacritty

#***************
# Gnome Dash to Panel
#***************

curl -sfLo dash2panel.zip $(curl -s https://api.github.com/repos/home-sweet-gnome/dash-to-panel/releases/latest | grep zipball_url | cut -f 4 -d '"')
unzip dash2panel.zip > /dev/null
cd home-sweet-gnome*
make install > /dev/null
cd ..

#***************
# Slack
#***************

sudo snap install slack --classic

#***************
# Zoom
#***************

curl -sfLO https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb || true
sudo apt install -fy

#***************
# Peek - GIF Recorder
#***************

sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt update && sudo apt install peek -y

#***************
# TODO: Restic for back-ups
#***************

#***************
# AWS CLI
#***************

sudo snap install aws-cli --classic

#***************
# Hashicorp utilities
#***************

hashicorp terraform
hashicorp packer

#***************
# Ansible
#***************

# sudo apt-add-repository ppa:ansible/ansible -y
# sudo apt update
# sudo apt install ansible python-pip -y
# pip install boto boto3

#***************
# Yarn
#***************

# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt-get update && sudo apt-get install yarn -y

#***************
# Randomize MAC addresses
#***************

curl -sfLO https://gist.githubusercontent.com/robertfairhead/9df546e252750a496787ef3d90f7b6c6/raw/71cfb42d0ff16edb1fe6789d20f0c21b2fe2a694/30-randomize-mac-address.conf
sudo mv 30-randomize-mac-address.conf /etc/NetworkManager/conf.d/
sudo sed -i 's/wifi.scan-rand-mac-address=no/wifi.scan-rand-mac-address=yes/' /etc/NetworkManager/NetworkManager.conf

#***************
# Set basic settings for above
#***************

gsettings set org.gnome.desktop.background picture-uri 'file:///home/bob/dotfiles/wallpaper/empire.jpg'
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///home/bob/dotfiles/wallpaper/empire.jpg'
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Darker'
gsettings set org.gnome.shell.extensions.user-theme name "Arc-Dark"
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.shell enabled-extensions "['dash-to-panel@jderose9.github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']"

# Set login screen background to black
sudo sed -i 's/background: #2c001e/background: #000000/' /usr/share/gnome-shell/theme/gdm3.css
sudo sed -i 's/background: #2c001e/background: #000000/' /usr/share/gnome-shell/theme/ubuntu.css

#***************
# Additional settings
#***************

gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop', 'google-chrome.desktop', 'com.alacritty.Alacritty.desktop', 'slack_slack.desktop']"

gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'Settings' ,'System', 'Multimedia']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ categories "['X-GNOME-Utilities', 'Utility']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Settings/ categories "['Settings', 'DesktopSettings', 'X-GNOME-Settings-Panel']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ categories "['System', 'Core']"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimedia/ categories "['AudioVideo', 'Audio', 'Video', 'Scanning', 'Graphics']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name "Utilities"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Settings/ name "Settings"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/System/ name "System"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimedia/ name "Multimedia"

sudo sed -i 's/Categories=Utility;/Categories=/' /usr/share/applications/code.desktop
sudo sed -i 's/Categories=GTK;GNOME;Utility;X-GNOME-Utilities;/Categories=GTK;GNOME;Graphics;/' /usr/share/applications/org.gnome.Screenshot.desktop

gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.shell enable-hot-corners false
gsettings set org.gnome.desktop.interface clock-format 12h
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.mutter auto-maximize false

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Page_Up', '<Control><Alt>Up', '<Control><Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Page_Down', '<Control><Alt>Down', '<Control><Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

dconf write /org/gnome/shell/extensions/dash-to-panel/panel-size 48
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-margin 2

#***************
# Set touchpad middle click to emulate left click instead
#***************
echo 'Section "InputClass"
    Identifier  "SynPS/2 Synaptics TouchPad"
    Option  "ButtonMapping" "1 1 3 4 5 6 7"
EndSection' | sudo tee /usr/share/X11/xorg.conf.d/99-no-middle-button-touchpad.conf
