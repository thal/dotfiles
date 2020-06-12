source ~/.bashrc
# Only continue if this is an interactive shell
[[ $- != *i* ]] && return
# Automatically start sway when logging in on tty1
if [[ "$(tty)" == "/dev/tty1" ]]; then
    # https://github.com/systemd/systemd/issues/14489
    export XDG_SESSION_TYPE=wayland
    # Redirect stdout to the systemd journal
    exec systemd-cat -t sway sway
fi
