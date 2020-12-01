#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PATH=$PATH:$HOME/bin:$HOME/.local/bin
# Use gnome-keyring-daemon for ssh keys
eval $(/usr/bin/gnome-keyring-daemon --start --components=ssh)
export SSH_AUTH_SOCK
