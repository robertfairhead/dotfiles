#/bin/bash

mkdir /tmp/fonts
cd /tmp/fonts

curl -sfLO https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
unzip 1.050R-it.zip

if [ $OS == "linux" ]; then
  sudo cp source-code-pro-2.030R-ro-1.050R-it/TTF/*.ttf /usr/share/fonts/truetype
else
  cp source-code-pro-2.030R-ro-1.050R-it/OTF/*.otf $HOME/Library/Fonts
fi

cd $HOME
rm -rf /tmp/fonts
