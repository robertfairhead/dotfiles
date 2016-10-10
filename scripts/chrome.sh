#!/bin/bash

echo "###############################"
echo "Installing Chrome"
echo "###############################"

if [ $OS == "linux" ]; then

  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt-get update
  sudo apt-get install google-chrome-stable
else

  rm -rf /tmp/Chrome
  mkdir /tmp/Chrome
  cd /tmp/Chrome

  curl -O https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg

  hdiutil attach googlechrome.dmg
  cp -r /Volumes/Google\ Chrome/Google\ Chrome.app /Applications

  cd $HOME
  hdiutil detach /Volumes/Google\ Chrome
  /bin/rm -rf /tmp/Chrome

fi
