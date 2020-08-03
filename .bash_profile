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
    # Use pipewire instead of pulse (not working yet)
#    export LD_LIBRARY_PATH="/usr/lib/pipewire-0.3/pulse:$LD_LIBRARY_PATH"
    # Redirect stdout to the systemd journal
    exec systemd-cat -t sway sway
fi
