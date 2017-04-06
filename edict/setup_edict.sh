#!/bin/sh

init_target edict

process_edict(){
    directory .local/bin/
    directory .local/dat/
    symlink edict/edict .local/bin/edict
    if [ $command = "setup" ] ; then
        current_dir=$PWD
        exec_cmd mkdir /tmp/edict

        exec_cmd cd /tmp/edict
        exec_cmd wget 'http://www.namazu.org/~tsuchiya/sdic/data/gene95.tar.gz'
        exec_cmd tar -zxvf gene95.tar.gz
        exec_cmd nkf -Sw -Lu -m0 --in-place gene.txt
        exec_cmd mv gene.txt $home_root/.local/dat/gene.txt
        exec_cmd chmod +x $home_root/.local/bin/edict
        exec_cmd rm readme.txt
        exec_cmd rm gene95.tar.gz

        exec_cmd cd $current_dir
        rmdir /tmp/edict
    fi
}
