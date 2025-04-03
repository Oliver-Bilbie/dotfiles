#!/bin/bash

hour=$(date +%H)

# Returns success between 8pm and 6am
if [[ $hour -ge 20 || $hour -lt 6 ]]; then
    exit 0
else
    exit 1
fi
