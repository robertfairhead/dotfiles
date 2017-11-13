#!/bin/bash

############################################################
### Based on    https://stribika.github.io/2015/01/04/secure-secure-shell.html
###             https://wiki.mozilla.org/Security/Guidelines/OpenSSH
###             https://blog.0xbadc0de.be/archives/300
###             https://blog.g3rt.nl/upgrade-your-ssh-keys.html
############################################################

############################################################
### SET SSH USER CONFIG
############################################################

echo "Creating ~/.ssh/config"
if [[ ! -d "$HOME/.ssh" ]]; then
    mkdir "$HOME/.ssh"
elif [[ -e "$HOME/.ssh/config" ]]; then
    mv "${HOME}/.ssh/config" "${HOME}/.ssh/config.bak"
fi

chmod 700 $HOME/.ssh

cp $HOME/dotfiles/config $HOME/.ssh/config

chmod 600 $HOME/.ssh/config*


############################################################
### GENERATE KEYS
############################################################

# Will need to enter a keypass phrase

echo "Creating Git SSH keys"

GIT_EMAIL=$( git config --get user.email )

for SERVICE in {"github","gitlab"}; do
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ${HOME}/.ssh/${SERVICE}_id_ed25519 -o -a 64
#    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f ${HOME}/.ssh/${SERVICE}_id_rsa -o -a 64

    if [[ $OS == 'osx' ]]; then
        SSHADD="ssh-add -K"
    else
        SSHADD="ssh-add"
    fi

    $SSHADD "$HOME/.ssh/${SERVICE}_id_ed25519"

done
