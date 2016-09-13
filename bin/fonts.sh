#/bin/bash

mkdir /tmp/fonts
cd /tmp/fonts

http --print b --download https://github.com/adobe-fonts/source-code-pro/archive/release.zip
unzip source-code-pro-release.zip

if [ $OS == "linux" ]; then
  sudo cp source-code-pro-release/TTF/*.ttf /usr/share/fonts/truetype
else
  cp source-code-pro-release/OTF/*.otf $HOME/Library/Fonts
fi

cd $HOME
rm -rf /tmp/fonts
