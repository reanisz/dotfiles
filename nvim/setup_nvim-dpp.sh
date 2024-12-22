#!/bin/sh

init_target nvim-dein

process_nvim-dein(){
    directory .cache
    if [ $command = "setup" ] ; then
        exec_cmd curl -fsSL https://deno.land/install.sh | sh
    fi
}
