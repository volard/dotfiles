#!/bin/bash

while true; do

  WALLPAPERS_PATH="$HOME/dotfiles/files/wallpapers/"
	PIC=($(find $WALLPAPERS_PATH -type f | shuf -n 2 --random-source=/dev/random))

	swaymsg output * bg "${PIC[0]}" fill >/dev/null

	sleep 10m

done
