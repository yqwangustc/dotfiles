#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export EXTRA_DIR="$DOTFILES_DIR/extra"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/bash/.alias" ~/.bash_alias
ln -sfv "$DOTFILES_DIR/bash/.env" ~/.bash_env
ln -sfv "$DOTFILES_DIR/bash/.functions" ~/.bash_functions
ln -sfv "$DOTFILES_DIR/bash/.inputrc" ~/.bash_inputrc
ln -sfv "$DOTFILES_DIR/bash/.profile" ~/.bash_profile
ln -sfv "$DOTFILES_DIR/bash/.prompt" ~/.bash_prompt
ln -sfv "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc


ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig
ln -sfv "$DOTFILES_DIR/vim/.vimrc" ~/.vimrc
mkdir -p ~/.vim/templates 
ln -sfv "$DOTFILES_DIR/vim/python.py" ~/.vim/templates/python.py
ln -sfv "$DOTFILES_DIR/tmux/.tmux.conf" ~/.tmux.conf

ln -sfv "$DOTFILES_DIR/latexmk/.latexmkrc" ~/.latexmkrc

# Package managers & packages

if [ "$(uname)" == "Darwin" ]; then
  . "$DOTFILES_DIR/install/brew-cask.sh"
  . "$DOTFILES_DIR/install/gem.sh"
  ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
fi

# Install extra stuff (such as pip)
if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
  . $EXTRA_DIR/install.sh
fi

# Install pyclewn for vim
#echo "installing pyclewn"
#vim/installPyclewn.py

# Install machine specific stuff
## git config 
machine=$(hostname -s)
if [ -f "$DOTFILES_DIR/git/${machine}.config" ]; then
  ln -sfv "$DOTFILES_DIR/git/${machine}.config" ~/.gitconfig.machine
fi
