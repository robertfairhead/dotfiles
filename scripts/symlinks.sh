#!/bin/bash

echo "###############################"
echo "Symlinking dotfiles"
echo "###############################"

cd $HOME

rm -rf .profile .bash_aliases .aws

ln -sf $HOME/dotfiles/bashrc .bashrc
ln -sf $HOME/dotfiles/bash_profile .bash_profile
ln -sf $HOME/dotfiles/path .path
ln -sf $HOME/dotfiles/aliases .aliases
ln -sf $HOME/dotfiles/prompt .prompt

ln -sf $HOME/dotfiles/inputrc .inputrc

ln -sf $HOME/dotfiles/gitconfig .gitconfig
ln -sf $HOME/dotfiles/gitignore_global .gitignore_global

ln -sf $HOME/dotfiles/dir_colors .dir_colors

ln -sf $HOME/dotfiles/hyper.js .hyper.js

if [[ ! -d bin ]]; then
  mkdir bin
  chmod 700 bin
fi

for program in $HOME/dotfiles/bin/*; do
  ln -sf $program $HOME/bin/$(basename $program)
done

if [[ -f $HOME/Dropbox/config/aws-credentials ]]; then
  mkdir $HOME/.aws
  chmod 700 $HOME/.aws
  ln -sf $HOME/Dropbox/config/credentials $HOME/.aws/credentials
fi

if [[ ! -d .gnupg ]]; then
  mkdir .gnupg
fi

chmod 700 .gnupg
ln -sf $HOME/dotfiles/gpg.conf .gnupg/gpg.conf

if [[ ! -d .config ]]; then
  mkdir .config
fi

if [[ ! -d .config/micro ]]; then
  mkdir .config/micro
fi

ln -sf $HOME/dotfiles/micro/settings.json .config/micro/settings.json
ln -sf $HOME/dotfiles/micro/colorschemes .config/micro/colorschemes

if [[ -f ${HOME}/Library/Application\ Support/Code/User/settings.json ]]; then
    ln -sf $HOME/dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
fi

if [[ -f /mnt/c/Users/rober/AppData/Roaming/Code/User/settings.json ]]; then
    rm -f /mnt/c/Users/rober/AppData/Roaming/Code/User/settings.json
    cmd.exe /C "mklink C:\Users\rober\AppData\Roaming\Code\User\settings.json C:\Users\rober\dotfiles\settings.json"
fi
