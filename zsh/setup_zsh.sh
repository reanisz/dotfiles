#!/bin/bash

init_target zsh

process_zsh(){
    symlink zsh/.zshrc .zshrc
    file .zshrc.local
}
