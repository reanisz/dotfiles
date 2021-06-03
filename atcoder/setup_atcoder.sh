#!/bin/sh

init_target vim

process_vim(){
    directory .config
    symlink atcoder-cli-nodejs/ .config/atcoder-cli-nodejs
}
