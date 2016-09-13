#!/bin/bash

echo "###############################"
echo "Installing Firefox"
echo "###############################"

if [ $OS == "linux" ]; then
  sudo apt-get install firefox

else
  rm -rf /tmp/Firefox
  mkdir /tmp/Firefox
  cd /tmp/Firefox

  http --print b --download "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"

  hdiutil attach *.dmg

  cp -r /Volumes/Firefox/Firefox.app /Applications

  cd $HOME

  hdiutil detach /Volumes/Firefox
  /bin/rm -rf /tmp/Firefox
fi
