#!/bin/sh
ln -s $PWD/vim/.vimrc $HOME/.vimrc
ln -s $PWD/vim/.vimrc.plugin $HOME/.vimrc.plugin
ln -s $PWD/vim/.vim $HOME/.vim
touch $HOME/.vimrc.local
ln -s $PWD/zsh/.zsrhc $HOME/.zshrc
touch $HOME/.zshrc.local