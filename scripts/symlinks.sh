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