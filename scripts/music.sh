#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    # metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
    metadata="$(playerctl metadata title 2> /dev/null | head -c 15)"
fi

if [[ $player_status = "Playing" ]]; then
    echo "%{F#FFFFFF}  $metadata...%{F-}" 
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#999}  $metadata...%{F-}" 
else
    echo "No Media"
fi
