#!/usr/bin/env bash

### Initial setup script for Debian based hosts
### GitHub: @netzverweigerer

set -e

# Additional packages to be installed
packages=(screen lynx curl wget rsync tmux irssi vim-nox htop irssi git nano-)

basedir="$(dirname "$0")"

# Helper functions
info () {
  echo
  echo -e "$(tput setaf 4)[$(tput setaf 11)setup$(tput setaf 4)]$(tput setaf 6) $@ $(tput sgr0)"
}

fin () {
  echo -e "$(tput setaf 4)[$(tput setaf 11)setup$(tput setaf 4)]$(tput setaf 6) done.$(tput sgr0)"
}

# Install packages
info "Installing packages..."
  apt update
  apt install "${packages[@]}"
fin

# VIM stuff
info "VIM configuration ..."
if [[ -x ~/.vimrc ]]; then
  echo "~/.vimrc found, not performing any changes to it."
else
  git clone https://github.com/netzverweigerer/config-vim.git /root/.vim && \
    mkdir -p /root/.vim/swap && \
    mkdir -p /root/.vim/backup
fi 
if [[ -x ~/.vim ]]; then
  echo "~/.vim found, not performing any changes to it."
else
  git clone https://github.com/netzverweigerer/config-vim.git /root/.vim && mkdir -p /root/.vim/swap && mkdir -p /root/.vim/backup
fi 
fin

echo

# Dotfiles stuff
for i in "$basedir"/dots/*; do
  info "[dotfiles] Copying: $i"
  cp -R -v "$i" "$HOME/.${i##*/}"
done



