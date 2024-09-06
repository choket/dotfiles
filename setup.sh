#!/bin/bash

apt -y install tmux zsh
chsh -s /bin/zsh

current_dir=$(dirname "$(readlink -f "$0")")

rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.vimrc

ln -fs "$current_dir/.zshrc" ~/.zshrc
ln -fs "$current_dir/.zshenv" ~/.zshenv
ln -fs "$current_dir/.tmux.conf" ~/.tmux.conf
ln -fs "$current_dir/.vimrc" ~/.vimrc

find . -type f -iname '.*' -exec chmod 600 {} \;

git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/zsh-syntax-highlighting
