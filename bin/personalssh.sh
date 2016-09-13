#!/bin/bash

############################################################
### Based on    https://stribika.github.io/2015/01/04/secure-secure-shell.html
###             https://wiki.mozilla.org/Security/Guidelines/OpenSSH
###             https://blog.0xbadc0de.be/archives/300
############################################################

############################################################
### SET SSH USER CONFIG
############################################################

echo "Creating ~/.ssh/config"
if [[ ! -d "$HOME/.ssh" ]]; then
    mkdir "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
elif [[ -e "$HOME/.ssh/config" ]]; then
    mv "${HOME}/.ssh/config" "${HOME}/.ssh/config.bak"
fi

cat <<EOF > "$HOME/.ssh/config"

Host github.com
    User git
    IdentityFile ~/.ssh/github_id_ed25519
    IdentityFile ~/.ssh/github_id_rsa

Host gitlab.com
    User git
    IdentityFile ~/.ssh/gitlab_id_ed25519
    IdentityFile ~/.ssh/gitlab_id_rsa

EOF

echo "Setting Known Hosts to shared Dropbox file"
ln -sf $HOME/Dropbox/config/known_hosts $HOME/.ssh/known_hosts

############################################################
### GENERATE KEYS
############################################################

# Will need to enter a keypass phrase

echo "Creating Git SSH keys"

GIT_EMAIL=$( git config --get user.email )

for SERVICE in {"github","gitlab"}; do
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ${HOME}/.ssh/${SERVICE}_id_ed25519
    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f ${HOME}/.ssh/${SERVICE}_id_rsa

    if [[ $OS == 'osx' ]]; then
        SSHADD="ssh-add -K"
    else
        SSHADD="ssh-add"
    fi

    for KEY in {"rsa","ed25519"}; do
        $SSHADD "$HOME/.ssh/${SERVICE}_id_$KEY"

        $HOME/bin/add_git_ssh_key $SERVICE $KEY

        ssh -T ${SERVICE}.com -i $HOME/.ssh/${SERVICE}_id_$KEY
    done
done
