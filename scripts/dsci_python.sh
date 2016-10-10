#!/bin/bash
CONDAVERSION="4.0.0"

if [ $OS == "linux" ]; then
  CONDAOS="Linux"
  CONDAMD5="31ed3ef07435d7068e1e03be49381b13"
else
  CONDAOS="MacOSX"
  CONDAMD5="a3443b46f99bc6680c77c688af1b1f5a"
fi

echo "###############################"
echo "Installing Anaconda $CONDAVERSION"
echo "###############################"

rm -rf /tmp/conda
mkdir /tmp/conda
cd /tmp/conda

curl -O https://repo.continuum.io/archive/Anaconda3-$CONDAVERSION-$CONDAOS-x86_64.sh
echo "$CONDAMD5 Anaconda3-$CONDAVERSION-$CONDAOS-x86_64.sh" > conda.md5
md5sum --check conda.md5

# Stop them from jacking with my dotfiles!

rm -f .bashrc
touch .bashrc

bash Anaconda3-$CONDAVERSION-$CONDAOS-x86_64.sh -b

ln -sf $HOME/Dropbox/config/bashrc .bashrc

echo "###############################"
echo "XGBoost"
echo "###############################"

if [ $OS == "linux" ]; then
  sudo apt-get install g++
fi

mkdir /tmp/xgboost
cd /tmp/xgboost
git clone --recursive https://github.com/dmlc/xgboost.git
cd xgboost
bash build.sh
cd python-package
python setup.py install

cd $HOME
rm -rf /tmp/xgboost

pip install httpie
conda install pymc
pip install git+https://github.com/pymc-devs/pymc3