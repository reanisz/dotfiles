#!/bin/sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/deininstaller.sh
mkdir $HOME/.cache
sh /tmp/deininstaller.sh $HOME/.cache/dein/
