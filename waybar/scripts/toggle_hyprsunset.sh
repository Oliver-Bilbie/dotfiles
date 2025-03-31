#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
    notify-send "󰹏 HyprSunset Disabled" "Night light is now off" -u low
    killall -q hyprsunset
else
    notify-send "󱩌 HyprSunset Enabled" "Night light is now on" -u low
    hyprsunset -t 4000
fi
