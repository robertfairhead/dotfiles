#!/bin/bash

echo "###############################"
echo "Atom"
echo "###############################"

if [ ! $(which http) ]; then
  echo "HTTPie must be installed first!"
  exit 1
fi

rm -rf /tmp/Atom
mkdir /tmp/Atom
cd /tmp/Atom

if [[ $OS == "linux" ]]; then
  http --print b --download https://atom.io/download/deb
  sudo dpkg -i atom-amd64.deb
else
  http  --print b --download https://atom.io/download/dmg
  unzip atom-mac.zip
  mv Atom.app /Applications

  echo "Install command line tools from menu"
fi

cd $HOME
rm -rf /tmp/Atom

ln -sf $HOME/Dropbox/config/atom/config.cson $HOME/.atom/config.cson
ln -sf $HOME/Dropbox/config/atom/init.coffee $HOME/.atom/init.coffee
ln -sf $HOME/Dropbox/config/atom/keymap.cson $HOME/.atom/keymap.cson
ln -sf $HOME/Dropbox/config/atom/snippets.cson $HOME/.atom/snippets.cson
ln -sf $HOME/Dropbox/config/atom/styles.less $HOME/.atom/styles.less
/bin/rm -rf $HOME/.atom/packages
ln -sf $HOME/Dropbox/config/atom/packages $HOME/.atom/

# Making sure prereqs for linter are installed
# Python
conda install flake8
pip install flake8-docstrings
