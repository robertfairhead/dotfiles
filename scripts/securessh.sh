#!/bin/bash

############################################################
### Based on    https://stribika.github.io/2015/01/04/secure-secure-shell.html
###             https://wiki.mozilla.org/Security/Guidelines/OpenSSH
###             https://blog.0xbadc0de.be/archives/300
############################################################

if [[ `whoami` != root ]]; then
echo "This script must be run using: sudo $0"
exit
fi


############################################################
### SET SSH GLOBAL CONFIG
############################################################

if [[ -e /etc/ssh/ssh_config ]]; then
mv /etc/ssh/ssh_config /etc/ssh/ssh_config.bak
fi

cat <<EOF > /etc/ssh/ssh_config
# This is the ssh client system-wide configuration file.  See
# ssh_config(5) for more information.  This file provides defaults for
# users, and the values can be changed in per-user configuration files
# or on the command line.

# Configuration data is parsed as follows:
#  1. command line options
#  2. user-specific file
#  3. system-wide file
# Any configuration value is only changed the first time it is set.
# Thus, host-specific definitions should be at the beginning of the
# configuration file, and defaults at the end.

Host *
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    PubkeyAuthentication yes
    UseRoaming No
    ForwardAgent No
    ForwardX11 No

    # Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.
    HashKnownHosts yes

    HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa

    # Github needs diffie-hellman-group-exchange-sha1 some of the time but not always.
    KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256

    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com

EOF


############################################################
### Set Moduli to be strong
############################################################

if [[ -e /etc/ssh/moduli ]]; then
  echo "Remove weak Moduli"

  awk '$5 > 2000' /etc/ssh/moduli > "${HOME}/moduli"
  wc -l "${HOME}/moduli" # make sure there is something left
  mv /etc/ssh/moduli /etc/ssh/moduli.bak
  mv "${HOME}/moduli" /etc/ssh/moduli

else

  echo "Create strong Moduli"

  ssh-keygen -G "${HOME}/q" -b 4096
  ssh-keygen -T /etc/ssh/moduli -f "${HOME}/moduli"
  rm "${HOME}/moduli"
fi
