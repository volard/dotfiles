#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/dotfiles/files/wallpapers"
LOCKFILE="/tmp/wallpaper_changer.lock"

killall swaybg

set_random_wallpaper() {

	wallpaper=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

	swaybg -i "$wallpaper" -m fill &

	PID=$(pidof swaybg)
  sleep 600

  kill $PID
}

# # Check if another instance is running
# if [ -e "$LOCKFILE" ]; then
# 	echo "Another instance is already running."
# 	exit 1
# fi
#
# # Create a lock file
# touch "$LOCKFILE"
#
# # Cleanup lock file on exit
# trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT

while true; do
	set_random_wallpaper
done
