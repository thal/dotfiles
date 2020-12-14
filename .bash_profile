source ~/.bashrc
# Only continue if this is an interactive shell
[[ $- != *i* ]] && return
# Automatically start sway when logging in on tty1
if [[ "$(tty)" == "/dev/tty1" ]]; then
    # Set graphical-relevant envrionment variables here
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1
    export GTK_OVERLAY_SCROLLING=0
    export QT_QPA_PLATFORMTHEME=qt5ct
    # Start gkd for ssh and export SSH_AUTH_SOCK
    export $(gnome-keyring-daemon --start --components=ssh)
    # Redirect stdout to the systemd journal
    exec systemd-cat -t sway $HOME/sway/build/sway/sway
fi
