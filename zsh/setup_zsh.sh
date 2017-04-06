#!/bin/bash

init_target zsh

process_zsh(){
    directory .local/bin/
    symlink zsh/.zshrc .zshrc
    file .zshrc.local
}
