#!/bin/sh
./clean.sh
ln -s $PWD/vim/.vimrc $HOME/.vimrc
ln -s $PWD/vim/.vimrc.plugin $HOME/.vimrc.plugin
ln -s $PWD/vim/.vim $HOME/.vim
touch $HOME/.vimrc.local
mkdir $HOME/.config
ln -s $PWD/nvim/nvim $HOME/.config/nvim
ln -s $PWD/zsh/.zshrc $HOME/.zshrc
touch $HOME/.zshrc.local
ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf 
