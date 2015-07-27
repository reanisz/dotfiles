#!/bin/sh
mkdir -p ~/my/lib
mkdir ~/my/lib/bin
mkdir ~/my/lib/dat
wget 'http://www.namazu.org/~tsuchiya/sdic/data/gene95.tar.gz'
tar -zxvf gene95.tar.gz
nkf -Sw -Lu -m0 --in-place gene.txt
mv gene.txt ~/my/lib/dat/
cp edict/edict ~/my/lib/bin/
chmod +x ~/my/lib/bin/edict
rm readme.txt
rm gene95.tar.gz
