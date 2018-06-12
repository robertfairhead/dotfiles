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
sudo apt update && sudo apt install peek -y

#***************
# TODO: Restic for back-ups
#***************

#***************
# Heroku CLI
#***************

curl -sSf https://cli-assets.heroku.com/install-ubuntu.sh | sudo bash
sudo apt install postgresql-client -y --no-install-recommends

#***************
# AWS CLI
#***************

sudo snap install aws-cli --classic


#***************
# Terraform
#***************

curl -sfLO $(curl -sSf https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*64" | sort -rV | head -1 | cut -d'"' -f4)
unzip terraform_*_linux_amd64.zip
sudo mv terraform /usr/local/bin

#***************
# Ansible
#***************

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible python-pip -y
pip install boto boto3

#***************
# Yarn
#***************

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn -y

#***************
# Clean up
#***************

cd $HOME
sudo rm -rf /tmp/apps
sudo apt clean && sudo apt autoremove


#***************
# Additional settings
#***************

gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox.desktop', 'google-chrome.desktop', 'alacritty.desktop', 'code.desktop', 'slack_slack.desktop']"
