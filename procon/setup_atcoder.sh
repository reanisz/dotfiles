#!/bin/sh

init_target atcoder

process_atcoder(){
    directory .local/bin/
    symlink procon/atcoder .local/bin/atcoder
}
