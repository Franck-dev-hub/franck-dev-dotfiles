#!/bin/bash

choice=$(echo -e " Lock\n⏻ Poweroff\n Reboot\n Logout" | wofi --dmenu --width 200 --height 200 --prompt "Power")

case "$choice" in
  " Lock")     loginctl lock-session ;;
  "⏻ Poweroff") systemctl poweroff ;;
  " Reboot")   systemctl reboot ;;
  " Logout")   hyprctl dispatch exit ;;
esac
