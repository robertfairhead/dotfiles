# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, only update PATH
case $- in
    *i*) ;;
      *) source $HOME/.path; return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[]*:exit:ls:bg:fg:history:clear"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export LSCOLORS="Gxfxcxdxbxegedabagacad"

source $HOME/.aliases
source $HOME/.path
source $HOME/.prompt

if [[ -f $HOME/dotfiles/git-completion.bash ]]; then
  source $HOME/dotfiles/git-completion.bash
fi

if [[ -f $HOME/dotfiles/go-completion.bash ]]; then
  source $HOME/dotfiles/go-completion.bash
fi
