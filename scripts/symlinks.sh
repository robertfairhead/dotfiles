#!/bin/bash

echo "###############################"
echo "Symlinking dotfiles"
echo "###############################"

cd $HOME

rm -rf .profile .bash_aliases

## Bash and command line setup
ln -sf $HOME/dotfiles/bash/bash_profile .bash_profile
ln -sf $HOME/dotfiles/bash/bashrc .bashrc
ln -sf $HOME/dotfiles/bash/inputrc .inputrc

ln -sf $HOME/dotfiles/tmux.conf .tmux.conf

ln -sf $HOME/dotfiles/git/gitconfig .gitconfig
ln -sf $HOME/dotfiles/git/gitignore_global .gitignore_global

## Setup local bin
mkdir -p bin
chmod 700 bin
for program in $HOME/dotfiles/bin/*; do
  ln -sf $program $HOME/bin/$(basename $program)
done

if [[ -f /keybase/private/fairhead/aws-config ]]; then
  mkdir -p $HOME/.aws
  chmod 700 $HOME/.aws
  ln -sf /keybase/private/fairhead/aws-config $HOME/.aws/config
  head -n 3 $HOME/.aws/config | tee $HOME/.aws/credentials &>/dev/null
  chmod 700 $HOME/.aws/credentials
fi

mkdir -p .gnupg
chmod 700 .gnupg
ln -sf $HOME/dotfiles/gpg/gpg.conf .gnupg/gpg.conf
ln -sf $HOME/dotfiles/gpg/gpg-agent.conf .gnupg/gpg-agent.conf

mkdir -p .config/micro
ln -sf $HOME/dotfiles/micro/settings.json $HOME/.config/micro/settings.json
ln -snf $HOME/dotfiles/micro/colorschemes $HOME/.config/micro/colorschemes

mkdir -p .config/alacritty
ln -sf $HOME/dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml

if [[ -d ${HOME}/.config/Code/User ]]; then
	ln -sf $HOME/dotfiles/settings.json $HOME/.config/Code/User/settings.json
fi
