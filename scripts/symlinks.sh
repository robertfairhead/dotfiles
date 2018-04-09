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

ln -sf $HOME/dotfiles/tmux.conf .tmux.conf

mkdir -p bin
chmod 700 bin
for program in $HOME/dotfiles/bin/*; do
  ln -sf $program $HOME/bin/$(basename $program)
done

if [[ -f /keybase/private/fairhead/aws-config ]]; then
  mkdir -p $HOME/.aws
  chmod 700 $HOME/.aws
  ln -sf /keybase/private/fairhead/aws-config $HOME/.aws/config
fi

mkdir -p .gnupg
chmod 700 .gnupg
ln -sf $HOME/dotfiles/gpg.conf .gnupg/gpg.conf
ln -sf $HOME/dotfiles/gpg-agent.conf .gnupg/gpg-agent.conf

mkdir -p .config/micro
ln -sf $HOME/dotfiles/micro/settings.json $HOME/.config/micro/settings.json
ln -snf $HOME/dotfiles/micro/colorschemes $HOME/.config/micro/colorschemes

mkdir -p .config/alacritty
ln -sf $HOME/dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# Drop VSCode into $PATH for Mac
if [[ -e ${HOME}/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]]; then
	ln -sf ${HOME}/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $HOME/bin/code
elif [[ -e /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]]; then
	ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $HOME/bin/code
fi

# Mac
if [[ -d ${HOME}/Library/Application\ Support/Code/User ]]; then
    ln -sf $HOME/dotfiles/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
fi

# Windows 10 WSL
if [[ -f /mnt/c/Users/rober/AppData/Roaming/Code/User/settings.json ]]; then
    rm -f /mnt/c/Users/rober/AppData/Roaming/Code/User/settings.json
    cmd.exe /C "mklink C:\Users\rober\AppData\Roaming\Code\User\settings.json C:\Users\rober\dotfiles\settings.json"
fi

# Linux
if [[ -d ${HOME}/.config/Code/User ]]; then
	ln -sf $HOME/dotfiles/settings.json $HOME/.config/Code/User/settings.json
fi
