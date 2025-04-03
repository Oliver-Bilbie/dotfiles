#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    if ~/.config/waybar/scripts/check_nighttime.sh; then
        touch /tmp/hyprsunset_override
    else
        rm /tmp/hyprsunset_override
    fi

    notify-send "󰹏 HyprSunset Disabled" "Night light was manually turned off." -u low
    killall -q hyprsunset

else
    if ! ~/.config/waybar/scripts/check_nighttime.sh; then
        touch /tmp/hyprsunset_override
    else
        rm /tmp/hyprsunset_override
    fi

    notify-send "󱩌 HyprSunset Enabled" "Night light was manually turned on." -u low
    hyprsunset -t 3000
fi
