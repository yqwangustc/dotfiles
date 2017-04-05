#if not running interactively, don't do anything

[ -z "$PS1" ] && return

# OS

if [ "$(uname -s)" = "Darwin" ]; then
  OS="MacOS"
else
  OS=$(uname -s)
fi

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$(which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  export DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  export DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return # `exit 1` would quit the shell itself
fi

# Finally we can source the dotfiles (order matters)
for DOTFILE in  ~/.bash_alias \
                ~/.bash_env   \
                ~/.bash_functions \
                ~/.bash_inputrc   \
                ~/.bash_prompt; do 
  [ -f "$DOTFILE" ] && . "$DOTFILE" 
done

if [ "$OS" = "MacOS" ]; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi

# Set LSCOLORS
if [[ -e "$DOTFILES_DIR"/system/.dir_colors ]]; then 
  eval "$(dircolors "$DOTFILES_DIR"/system/.dir_colors)"
fi
# Hook for extra/custom stuff

EXTRA_DIR="$HOME/.extra"

if [ -d "$EXTRA_DIR" ]; then
  for EXTRAFILE in "$EXTRA_DIR"/runcom/*.sh; do
    [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
  done
fi

# Clean up

unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE

# Export
export OS DOTFILES_DIR EXTRA_DIR
# BEGIN: Block added by chef, to set environment strings
# Please see https://fburl.com/AndroidProvisioning if you do not use bash
# or if you would rather this bit of code 'live' somewhere else
if [ -e "~/.fbchef/environment" ]; then 
  . ~/.fbchef/environment
fi
# END: Block added by chef

# sourcing machine-specific settings 
if [ -e "$DOTFILES_DIR/bash/.machine" ]; then
  . "$DOTFILES_DIR/bash/.machine"
fi


export PATH=/usr/local/mpi/bin:$PATH:~/local/rtags-install/bin
export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/mpi/lib:/usr/local/cudnn-5.1/cuda/lib64:$LD_LIBRARY_PATH

