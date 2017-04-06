#!/bin/sh

init_target vim

process_vim(){
    directory .config
    symlink nvim/nvim/init.vim .vimrc
    symlink nvim/nvim/ .config/.vim
    file .vimrc.local
}
