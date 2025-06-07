#!/bin/bash

if pgrep -x "hypridle" > /dev/null; then
    notify-send " Caffeine Enabled" "The machine will stay awake." -u low
    killall -q hypridle

else
    notify-send "󰒲 Caffeine Disabled" "The machine will sleep when inactive." -u low
    hypridle
fi
