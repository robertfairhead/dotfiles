#!/bin/bash

GITVERSION="2.6.3"

echo "###############################"
echo "Installing Git $GITVERSION"
echo "###############################"

if [ $OS == "linux" ]; then
  sudo apt-get install git
else

  rm -rf /tmp/git
  mkdir /tmp/git
  cd /tmp/git

  http --print b --download http://sourceforge.net/projects/git-osx-installer/files/latest/download

  hdiutil attach *.dmg
  cd /Volumes/Git*
  sudo installer -pkg *.pkg -tgt /

  cd $HOME

  hdiutil detach /Volumes/Git*
  /bin/rm -rf /tmp/git

fi
