#!/bin/sh

# robust script, stops in case of failure
set -euf

# this script is supposed to be downloaded and ran before the cloning of
# this repository, i.e. run this script to clone
# example usage: chmod +x ./clone_repo.sh; ./clone_repo.sh

# definitions
GIT_DIR="$HOME/.cfg/"
GIT_REPO="git@github.com:hcpsilva/dotfiles.git"
GIT_ALIAS="GIT_DIR=$GIT_DIR GIT_WORK_TREE=$HOME git"

# cloning
git clone --bare $GIT_REPO $GIT_DIR

# set our home work tree for the next commands
export GIT_DIR=$GIT_DIR
export GIT_WORK_TREE=$HOME

# make sure we checkout (if before where any duplicates)
git checkout -f

# set so that this repo can't see untracked files (otherwise madness)
git config --local status.showUntrackedFiles no
