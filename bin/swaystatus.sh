#!/usr/bin/env bash

# From https://github.com/i3/i3status/blob/master/contrib/any_position_wrapper.sh

# This i3status wrapper allows to add custom information in any position of the statusline
# It was developed for i3bar (JSON format)

# The idea is to define "holder" modules in i3status config and then replace them

# In order to make this example work you need to add
# order += "tztime holder__hey_man"
# and
# tztime holder__hey_man {
#        format = "holder__hey_man"
# }
# in i3staus config

# Don't forget that i3status config should contain:
# general {
#   output_format = i3bar
# }
#
# and i3 config should contain:
# bar {
#   status_command exec /path/to/this/script.sh
# }

# Make sure jq is installed
# That's it

# You can easily add multiple custom modules using additional "holders"

function update_holder {

  local instance="$1"
  local replacement="$2"
  echo "$json_array" | jq --argjson arg_j "$replacement" "(.[] | (select(.instance==\"$instance\"))) |= \$arg_j"
}

function remove_holder {

  local instance="$1"
  echo "$json_array" | jq "del(.[] | (select(.instance==\"$instance\")))"
}

function fillholders {
    # Get layout from first input device.
    # This is fine if layout is set for all input devices at once, using "input *" in sway config
    local json="{\"full_text\": $(swaymsg -t get_inputs | jq ".[1].xkb_active_layout_name")}"
    json_array=$(update_holder holder__kb "$json")
}

i3status | ( read line; echo "$line"; read line; echo "$line"; read line ; echo "$line" ; while true
do
  read line
  json_array="$(echo $line | sed -e 's/^,//')"
  fillholders
  echo ",$json_array"
done)
