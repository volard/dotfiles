#!/bin/bash

if [ "$(playerctl status)" = "Connection to player failed: No players found" ]; then
    echo " "
elif [ "$(playerctl --player=playerctld  status)" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$(playerctl --player=playerctld  status)" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar example")" hook spotify-play-pause 1 >/dev/null
    IFS=$'\n'
    metadata=($(playerctl metadata artist))
    metadata1=($(playerctl metadata title))
    echo "${metadata[0]} - ${metadata1[0]}"
elif [ "$(playerctl --player=playerctld  status)" = "Playing"  ]; then
    polybar-msg -p "$(pgrep -f "polybar example")" hook spotify-play-pause 0 >/dev/null
    IFS=$'\n'
    metadata=($(playerctl metadata artist))
    metadata1=($(playerctl metadata title))
    echo "${metadata[0]} - ${metadata1[0]}"
else 
    echo " "
fi
