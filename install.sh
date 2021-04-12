#!/bin/bash

current_dir=$(dirname "$(readlink -f "$0")")

ln -s "$current_dir/.zshrc" ~/.zshrc
ln -s "$current_dir/.tmux.conf" ~/.tmux.conf
ln -s "$current_dir/.vimrc" ~/.vimrc
