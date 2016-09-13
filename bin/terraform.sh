#!/usr/bin/env bash

VERSION="0.6.16"

if [ $OS == "linux" ]; then
  ARCH="linux"
  SHA="sha256sum"
else
  ARCH="darwin"
  SHA="shasum -a 256"
fi

echo "###############################"
echo "Installing Terraform $VERSION"
echo "###############################"

if [ ! $(which http) ]; then
  echo "HTTPie must be installed first!"
  exit 1
fi

FILE="terraform_${VERSION}_${ARCH}_amd64.zip"

rm -rf /tmp/terraform
mkdir /tmp/terraform
cd /tmp/terraform

http --print b --download https://releases.hashicorp.com/terraform/${VERSION}/${FILE}
http --print b --download https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_SHA256SUMS

grep ${FILE} terraform_${VERSION}_SHA256SUMS > terraform_${VERSION}_SHA256SUM

$SHA -c terraform_${VERSION}_SHA256SUM

sudo unzip -o -d /usr/local/bin ${FILE}

cd $HOME

rm -rf /tmp/terraform

ssh-keygen -t rsa -b 4096 -f ${HOME}/.ssh/terraform_id_rsa

if [[ $OS == 'osx' ]]; then
    SSHADD="ssh-add -K"
else
    SSHADD="ssh-add"
fi

$SSHADD "$HOME/.ssh/terraform_id_rsa"

echo "###############################"
echo "Installing AWS CLI"
echo "###############################"
pip install awscli

echo "###############################"
echo "Installing Ansible"
echo "###############################"

PATH=/usr/bin:/usr/local/bin:$PATH

sudo easy_install pip
pip install ansible boto --user python
pip install --upgrade setuptools --user python


sudo mkdir /etc/ansible/hosts
cd /etc/ansible/hosts
sudo http --print b --download https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
sudo http --print b --download https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
sudo chown $USER ec2*
#Must edit ec2.ini??
#Need ~/.ansisble.cfg
