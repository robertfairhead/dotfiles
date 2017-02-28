#! /usr/bin/env bash

cd $HOME

ln -sf /mnt/c/Users/Bob/dotfiles dotfiles
ln -sf /mnt/c/Users/Bob/Dropbox Dropbox

if [[ ! -d /mnt/c/Users/Bob/src ]]; then
    mkdir /mnt/c/Users/Bob/src
fi

ln -sf /mnt/c/Users/Bob/src src