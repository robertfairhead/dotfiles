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
# TODO: Restic for back-ups
#***************



#***************
# Clean up
#***************

cd $HOME
sudo rm -rf /tmp/apps
sudo apt clean && sudo apt autoremove