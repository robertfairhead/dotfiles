#!/bin/bash

echo "###############################"
echo "Updating /etc/hosts file"
echo "###############################"

cd $HOME/Dropbox/config

http --print b --download http://someonewhocares.org/hosts/zero/hosts

mv hosts.txt hosts

ln -sf $HOME/Dropbox/config/hosts /etc/hosts 
