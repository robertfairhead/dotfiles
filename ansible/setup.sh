#!/usr/env/bin bash

sudo pip3 install ansible

sudo cp ~/dotfiles/ansible/hosts /etc/ansible/hosts

ln -sf ~/dotfiles/ansible/ansible.cfg ~/.ansible.cfg
