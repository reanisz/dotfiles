#!/bin/sh

init_target nvim-dein

process_nvim-dein(){
    directory .cache
    if [ $command = "setup" ] ; then
        exec_cmd curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/deininstaller.sh
        exec_cmd sh /tmp/deininstaller.sh $HOME/.cache/dein/
        exec_cmd rm /tmp/deininstaller.sh
    fi
}
