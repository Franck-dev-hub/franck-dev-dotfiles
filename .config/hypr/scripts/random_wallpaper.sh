#!/bin/bash

# Wallapaper folder
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Random image
IMAGE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Screen name
MONITOR="DP-1"

# Temp file for Hyprpaper
CONFIG="$HOME/.config/hypr/hyprpaper.conf"

# Write the new config
cat <<EOF > "$CONFIG"
preload = $IMAGE
wallpaper = $MONITOR,$IMAGE
position = $MONITOR,fit
EOF

# Reload Hyprpaper
pkill hyprpaper
hyprpaper &
