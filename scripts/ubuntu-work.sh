#!/usr/bin/env bash

set -euo pipefail

mkdir -p /tmp/apps
cd /tmp/apps

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
sudo apt update && sudo apt install peek

#***************
# TODO: Restic for back-ups
#***************

#***************
# TODO: Heroku CLI
#***************

curl -sSf https://cli-assets.heroku.com/install-ubuntu.sh | sudo bash
sudo apt install postgresql-client -y --no-install-recommends

#***************
# TODO: AWS CLI
#***************

sudo apt install awscli -y

#***************
# Clean up
#***************

cd $HOME
sudo rm -rf /tmp/apps
sudo apt clean && sudo apt autoremove


#***************
# Additional settings
#***************

gsettings set org.gnome.shell favorite-apps ['org.gnome.Nautilus.desktop', 'firefox.desktop', 'google-chrome.desktop', 'Alacritty.desktop', 'code.desktop', 'slack_slack.desktop']
