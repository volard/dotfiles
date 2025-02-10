#!/bin/sh

# Kill any existing instances of this script to avoid multiple wallpaper processes.
# This uses pgrep to find processes with the same name as this script 
# (excluding the current process) and kills them.
pkill -f "$(basename "$0")"

# Check if swaybg is already running.
# The 'grep -m 1' limits to the first match for efficiency.
isServerExist=$(ps -ef | grep -m 1 swaybg | grep -v "grep" | wc -l)

# If swaybg is not running, start it with a random wallpaper.
if [ "$isServerExist" = "0" ]; then
  echo "swaybg not found, starting it..."
fi

# Start the first wallpaper. 
# - The '&' puts it in the background so the loop can continue.
swaybg -i $(find ~/dotfiles/files/wallpapers/ -name "*.png" | shuf -n1) -m fill &
OLD_PID=$! # Store the process ID (PID) of the background process.

# Loop to change the wallpaper every 120 seconds (2 minutes).
while true; do
    sleep 120 
    
    # Start a new swaybg process with a new random wallpaper in the background.
    swaybg -i $(find ~/dotfiles/files/wallpapers/ -name "*.png" | shuf -n1) -m fill &
    NEXT_PID=$!

    # Give swaybg a moment to start.
    sleep 5 

    # Kill the old swaybg process gracefully.
    kill $OLD_PID
    
    # Update the OLD_PID for the next iteration of the loop.
    OLD_PID=$NEXT_PID
done
