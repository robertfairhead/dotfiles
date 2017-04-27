#!/bin/bash

GOVERSION="1.8.1"

if [ $OS == "linux" ]; then
  GOOS="linux"
  GOSHA="a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994"
  SHA="sha256sum"
else
  GOOS="darwin"
  GOSHA="8b686ace24c0166738fd9f6003503f9d55ce03b7f24c963b043ba7bb56f43000"
  SHA="shasum -a 256"
fi

echo "###############################"
echo "Installing Go $GOVERSION"
echo "###############################"

sudo rm -rf /usr/local/go

rm -rf /tmp/golang
mkdir /tmp/golang
cd /tmp/golang

curl -O https://storage.googleapis.com/golang/go$GOVERSION.$GOOS-amd64.tar.gz

echo "$GOSHA go$GOVERSION.$GOOS-amd64.tar.gz" > go$GOVERSION.$GOOS-amd64.sha
$SHA --check go$GOVERSION.$GOOS-amd64.sha

sudo tar -C /usr/local -xzf go$GOVERSION.$GOOS-amd64.tar.gz

cd $HOME

rm -rf /tmp/golang

#Make the directory for my go code
if [ ! -e $HOME/go/src/github.com/robertfairhead ]; then
  mkdir -p $HOME/go/src/github.com/robertfairhead
fi

ln -s $HOME/go/src/github.com/robertfairhead/ $HOME/gosrc

# Golang
#go get -u golang.org/x/tools/cmd/...
#go get -u github.com/golang/lint/golint
#go get -u github.com/nsf/gocode
#go get -u github.com/rogpeppe/godef
#go get -u github.com/kisielk/errcheck
