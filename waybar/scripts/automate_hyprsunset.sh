#!/bin/bash

# Icon to display
echo ""

# Exit if manual override exists
if [ -f /tmp/hyprsunset_override ]; then
    exit 0
fi

if ~/.config/waybar/scripts/check_nighttime.sh; then
    if ! pgrep -x "hyprsunset" > /dev/null; then
        notify-send "󱩌 HyprSunset Enabled" "Good evening! Night light is now on." -u low
        hyprsunset -t 3000 > /dev/null
    fi
else
    if pgrep -x "hyprsunset" > /dev/null; then
        notify-send "󰹏 HyprSunset Disabled" "Good morning! Night light is now off." -u low
        killall -q hyprsunset
    fi
fi
