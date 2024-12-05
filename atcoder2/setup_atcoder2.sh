#!/bin/sh

init_target atcoder2

process_atcoder2(){
    symlink atcoder2/.atcoder .atcoder
    symlink atcoder2/.atcodertools.toml .atcodertools.toml
}
