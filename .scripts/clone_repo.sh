# This script is supposed to be downloaded and ran BEFORE the cloning of
# this repository, i.e. run this script to clone
# Example usage: chmod +x ./clone_repo.sh; $SHELL ./clone_repo.sh


# Definitions
gitdir=".cfg/"
gitrepo='git@github.com:hcpsilva/dotfiles.git'
gitalias="git --git-dir=$HOME/$gitdir --work-tree=$HOME"

# Set-up
alias dotgit="'$gitalias'"
echo "alias dotgit='$gitalias'" >> $HOME/.$(basename $SHELL)rc
echo $gitdir >> $HOME/.gitignore

# Cloning
git clone --bare $gitrepo $HOME/.cfg

# Make sure we checkout (if before where any duplicates)
dotgit checkout -f

# Set so that this repo can't see untracked files (otherwise madness)
dotgit config --local status.showUntrackedFiles no

# Load up the alias
source $HOME/.$(basename $SHELL)rc
