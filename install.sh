#!/bin/bash

current_dir=$(dirname "$(readlink -f "$0")")

rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.vimrc

ln -s "$current_dir/.zshrc" ~/.zshrc
ln -s "$current_dir/.zshenv" ~/.zshenv
ln -s "$current_dir/.tmux.conf" ~/.tmux.conf
ln -s "$current_dir/.vimrc" ~/.vimrc

find . -type f -iname '.*' -exec chmod 600 {} \;
