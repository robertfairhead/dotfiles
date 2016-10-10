#/bin/bash

### From source:

# sudo apt-get install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config
# sudo apt-get install clang-3.6
# sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
# sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100
#
#
#
# if [[ -e $HOME/swift ]]; then
#   cd $HOME/swift
#   ./utils/update-checkout
# else
#   cd $HOME
#   git clone https://github.com/apple/swift.git
#   cd swift
#   ./utils/update-checkout --clone
# fi

### Precompiled swift binaries

VERSION=DEVELOPMENT-SNAPSHOT-2016-03-24-a

if [ $OS == "linux" ]; then



  #Install main swift
  wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
  sudo apt-get install clang libicu-dev

  gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

  rm -rf /tmp/swift
  mkdir /tmp/swift
  cd /tmp/swift

  http --print b --download https://swift.org/builds/development/ubuntu1404/swift-${VERSION}/swift-${VERSION}-ubuntu14.04.tar.gz
  http --print b --download https://swift.org/builds/development/ubuntu1404/swift-${VERSION}/swift-${VERSION}-ubuntu14.04.tar.gz.sig

  gpg --verify swift-${VERSION}-ubuntu14.04.tar.gz.sig

  sudo rm -rf /usr/local/swift
  sudo mkdir /usr/local/swift

  tar xzf swift-${VERSION}-ubuntu14.04.tar.gz

  sudo cp -r swift-${VERSION}-ubuntu14.04/usr/* /usr/local/swift

  cd $HOME
  rm -rf /tmp/swift

fi
