#!/bin/bash

echo "###############################"
echo "Installing Dropbox"
echo "###############################"

if [ $OS == "linux" ]; then
  sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
  sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"

  sudo apt-get update
  sudo apt-get install python-gpgme dropbox

  echo " # Run Dropbox from Menu"
  echo " # Waiting..."
  read

else
  echo "Nothing yet"
fi
