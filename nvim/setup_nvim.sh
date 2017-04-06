#!/bin/sh

init_target nvim

process_nvim(){
    directory .config
    symlink nvim/nvim .config/nvim
    file .local_settings.nvim
}
