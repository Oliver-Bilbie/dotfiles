#!/bin/bash

if ! updates_arch="$(checkupdates | wc -l)"; then
    updates_arch=0
fi

if ! updates_aur="$(yay -Qum 2>/dev/null | wc -l)"; then
    updates_aur=0
fi

if ! updates_flatpak="$(flatpak remote-ls --columns=application -a --updates | wc -l)"; then
    updates_flatpak=0
fi

total_updates=$(($updates_arch + $updates_aur + $updates_flatpak))

if [ $total_updates -gt 0 ]; then
    echo $total_updates
fi
