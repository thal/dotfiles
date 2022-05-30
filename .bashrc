#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
PATH=$PATH:$HOME/bin:$HOME/.local/bin

# This works, but it relies on behavior of kitty shell integration, and will suppress legitimate commands that contain "_ksi_prompt_command" for whatever reason
# trap 'BASH_COMMAND_SAVED="${BASH_COMMAND//[^[:print:]]/}"; [[ "${BASH_COMMAND_SAVED}" =~ "_ksi_prompt_command" ]] || printf "\033]0;%s\007" "$BASH_COMMAND_SAVED"' DEBUG

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-title"
    source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
# SETTITLE is unset before kitty's PROMPT_COMMANDs run, 1 after
# bashrc is normally sourced before kitty's shell integration script
# So have to do "manual shell integration" and modify PROMPT_COMMAND thereafter
PROMPT_COMMAND="builtin unset SETTITLE; ${PROMPT_COMMAND}; SETTITLE=1"

# Set window title to current command
# DEBUG signal is sent before every command is executed
# \033]0;%s\007 escape sequence sets the window title to printf arg in %s
# BASH_COMMAND is set to the currently executing command, after parameter expansion, before command starts
# ${BASH_COMMAND//[^[:print:]]} removes all non-printable characters
# Check SETTITLE to only set title after kitty's PROMPT_COMMANDs run, see above
trap '[[ -z $SETTITLE  ]] || printf "\033]0;%s\007" "${BASH_COMMAND//[^[:print:]]/}"' DEBUG
