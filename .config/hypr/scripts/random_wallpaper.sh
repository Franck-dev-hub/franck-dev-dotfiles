#!/bin/bash

# Wallpaper folder
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Temp hyprpaper file
CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# If folder doesn't exist, create it
mkdir -p "$(dirname "$CONFIG")"

# Fetch monitor list
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

# Empty config file
> "$CONFIG"

# For each monitor, get a random image then write config file
for MONITOR in $MONITORS; do
    IMAGE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    echo "preload = $IMAGE" >> "$CONFIG"
    echo "wallpaper = $MONITOR,$IMAGE" >> "$CONFIG"
    echo "position = $MONITOR,fit" >> "$CONFIG"
done

# Reload hyprpaper
pkill hyprpaper
hyprpaper &
