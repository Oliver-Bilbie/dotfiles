#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os


def run_menu():
    keys = (
        "   Lock",
        "   Suspend",
        "⏻   Shutdown",
        "   Reboot",
        "   UEFI Firmware",
    )

    actions = (
        "hyprctl dispatch exec hyprlock",
        "systemctl suspend",
        "systemctl poweroff",
        "systemctl reboot",
        "systemctl reboot --firmware-setup",
    )

    options = "\n".join(keys)
    choice = (
        os.popen(
            "echo -e '"
            + options
            + "' | wofi -d -i -p 'Power Menu' -W 600 -H 300 -k /dev/null"
        )
        .readline()
        .strip()
    )
    if choice in keys:
        os.popen(actions[keys.index(choice)])


run_menu()
