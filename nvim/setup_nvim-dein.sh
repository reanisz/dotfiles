#!/bin/sh

init_target nvim-dein

process_nvim-dein(){
    directory .cache
    if [ $command = "setup" ] ; then
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/deininstaller.sh
        sh /tmp/deininstaller.sh $HOME/.cache/dein/
        rm /tmp/deininstaller.sh
    fi
}
