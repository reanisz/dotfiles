#!/bin/sh

init_target atcoder

process_atcoder(){
    directory .config
    symlink atcoder/atcoder-cli-nodejs .config/atcoder-cli-nodejs
}
