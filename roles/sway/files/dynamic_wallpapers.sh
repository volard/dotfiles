#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/dotfiles/files/wallpapers"  # Change this to your wallpaper directory
LOCKFILE="/tmp/wallpaper_changer.lock"


# Function to set a random wallpaper
set_random_wallpaper() {
    # Kill any existing swaybg process
    pkill swaybg

    # Get a random wallpaper from the specified directory
    wallpaper=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    
    # Set the wallpaper using `sway` or `wlroot` (adjust according to your compositor)
    # swaymsg output '*' bg "$wallpaper" fill
    swaybg -i "$wallpaper" -m fill &
}

# Check if another instance is running
if [ -e "$LOCKFILE" ]; then
    echo "Another instance is already running."
    exit 1
fi

# Create a lock file
touch "$LOCKFILE"

# Cleanup lock file on exit
trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT

# Main loop to change wallpaper every 10 seconds
while true; do
    set_random_wallpaper
    sleep 600
done

