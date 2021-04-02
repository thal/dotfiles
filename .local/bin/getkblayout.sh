#!/bin/sh
swaymsg -t get_inputs | jq -r "map(select(.type==\"keyboard\"))[0].xkb_active_layout_name"
