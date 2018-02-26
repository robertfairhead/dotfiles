#!/usr/bin/env bash

set -euo pipefail

GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")

if [[ -d "/usr/local/go" ]]; then
 sudo rm -rf /usr/local/go
fi

curl -sSL "https://storage.googleapis.com/golang/${GO_VERSION}.${OS}-amd64.tar.gz" | sudo tar -xz -C /usr/local