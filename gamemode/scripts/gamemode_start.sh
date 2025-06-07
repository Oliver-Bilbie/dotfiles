#!/bin/bash

notify-send "󰊗 GameMode Enabled" "Rip and tear until it is done." -u low

if pgrep -x "hypridle" > /dev/null; then
    echo "gamemode" > /tmp/gamemode_paused_hypridle
    pkill -USR1 hypridle
fi
