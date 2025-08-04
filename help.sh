#!/bin/bash

# Colors
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[37m"
RESET="\e[0m"

echo -e "${BLUE}=== Vim ===${RESET}"
cat <<EOF
n, v, vi, vim -> nvim
EOF

echo -e "${BLUE}=== Terminal ===${RESET}"
cat <<EOF
ll	-> la -Alh
ls	-> lsd --group-dirs first
fibo	-> ${HOME}/.config/waybar/scripts/fibo.sh
EOF

echo -e "${BLUE}=== Git/Github ===${RESET}"
cat <<EOF
gs	-> clear && git status
ga	-> git add
gc	-> git commit
gac	-> git add . && git commit
gca	-> git commit --amend
gcan	-> git commit --amend --no-edit
gp	-> git push
gpf	-> git push -f
gcanf	-> git commit --amend --no-edit && git push -f
gd	-> git diff
gds	-> git diff --stat
EOF

echo -e "${BLUE}=== Holberton (C/Valgrind) ===${RESET}"
cat <<EOF
gcch	-> gcc -Wall -pedantic -Werror -Wextra -std=gnu89
val	-> clear && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all ./a.out
EOF

echo -e "${BLUE}=== Love2D ===${RESET}"
cat <<EOF
lov	-> love ./
EOF

echo -e "${BLUE}=== Fastfetch ===${RESET}"
cat <<EOF
ff	-> fastfetch
ffm	-> fastfetch --config ${HOME}/.config/fastfetch/start.jsonc
EOF

echo -e "${BLUE}=== Configs ===${RESET}"
cat <<EOF
zshrc	-> n ${HOME}/.zshrc
cursor	-> find /usr/share/icons ${HOME}/.local/share/icons ${HOME}/.icons -type d -name "cursors"
hypr	-> n ${HOME}/.config/hypr/hyprland.conf
lock	-> n ${HOME}/.config/hypr/hyprlock.conf
idle	-> n ${HOME}/.config/hypr/hypridle.conf
bar	-> n ${HOME}/.config/waybar/config.jsonc
notif	-> n ${HOME}/.config/mako/config
custom-launcher -> n ${HOME}/.config/hypr/scripts/rofi-file-manager.sh
display	-> nwg-look
wall	-> ${HOME}/.config/hypr/scripts/random_wallpaper.sh
help	-> ${HOME}/help.sh
webcam	-> gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg,width=1280,height=720 ! jpegdec ! videoconvert ! autovideosink
qr	-> zbarcam
EOF
