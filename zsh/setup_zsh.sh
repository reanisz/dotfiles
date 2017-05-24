#!/bin/bash

init_target zsh

process_zsh(){
    directory .local/bin/
    symlink zsh/.zshrc .zshrc
    directory .zsh
    symlink zsh/zsh_settings .zsh/zsh_settings
    file .zshrc.local
}
