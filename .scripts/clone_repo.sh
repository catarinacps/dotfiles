#!/bin/bash

# This script is supposed to be downloaded and ran BEFORE the cloning of
# this repository, i.e. run this script to clone

alias dotgit='/usr/bin/git --git-dir=$HOME/.cfg. --work-tree=$HOME'
echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.cfg. --work-tree=$HOME'" >> $HOME/.bashrc
echo ".cfg" >> $HOME/.gitignore

git clone --bare https://github.com/hcpsilva/dotfiles.git $HOME/.cfg

mkdir -p .config-backup && dotgit checkout 2>&1 | \
    egrep "\s+"\. | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}

dotgit checkout

dotgit config --local status.showUntrackedFiles no
