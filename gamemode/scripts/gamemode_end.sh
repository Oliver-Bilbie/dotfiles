#!/bin/bash

notify-send "󰊗 GameMode Disabled" -u low

if [[ -f /tmp/gamemode_paused_hypridle ]]; then
    pkill -USR2 hypridle
    rm -f /tmp/gamemode_paused_hypridle
fi
