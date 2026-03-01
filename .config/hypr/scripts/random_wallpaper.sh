#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# check if swww is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Fetch monitor list
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

for MONITOR in $MONITORS; do
    # Choose random wallpaper
    IMAGE=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

    if [ -n "$IMAGE" ]; then
        # Apply wallpaper with a transition
        swww img "$IMAGE" \
            --outputs "$MONITOR" \
            --transition-type wipe \
            --transition-angle 30 \
            --transition-duration 2 \
            --transition-fps 120
    fi
done
