#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\033[34m\][\[\033[0m\]\[\033[32m\]\u@\h \[\033[34m\]\w\]]\033[0m\]\$ '
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PATH=$PATH:$HOME/bin:$HOME/.local/bin


# Manual kitty shell integration: use no-title because we set the title ourselves
# PROMPT_COMMAND is an array of commands that run before running the typed command
# [0] is set by /etc/bash.bashrc, and sets the window title to user@host:pwd
# Sourcing kitty shell integration will append another function
# Wrap existing PROMPT_COMMAND in a unset/set of SETTITLE, which is checked in the debug trap (see below)
PROMPT_COMMAND=([0]="builtin unset SETTITLE" [1]=${PROMPT_COMMAND[0]})
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-title"
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
PROMPT_COMMAND+=("SETTITLE=1")

# Set window title to current command
# DEBUG signal is sent before every command is executed
# \033]0;%s\007 escape sequence sets the window title to printf arg in %s
# BASH_COMMAND is set to the currently executing command, after parameter expansion, before command starts
# ${BASH_COMMAND//[^[:print:]]} removes all non-printable characters
# This is also triggered for the entries in PROMPT_COMMAND. Check SETTITLE (see above) to know PROMPT_COMMAND has finished
trap '[[ -z $SETTITLE  ]] || printf "\033]0;%s\007" "${BASH_COMMAND//[^[:print:]]/}"' DEBUG
