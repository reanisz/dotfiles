#!/bin/sh

init_target tmux

process_tmux(){
    symlink tmux/.tmux.conf .tmux.conf
}
