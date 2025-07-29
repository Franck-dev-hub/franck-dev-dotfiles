#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/themes"
theme='powermenu'

# Options
shutdown='  Shutdown'
reboot='  Reboot'
lock='  Lock'
suspend=' Suspend'
hibernate=' Hibernate'
logout='  Logout'
yes=''
no='✘'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
    -p "󰮯 Choose your destiny ${USER}" \
    -mesg "⚡ Pick your power move ✨" \
    -theme "${dir}/${theme}.rasi"
}

# Confirmation CMD
confirm_cmd() {
    rofi -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme ${dir}/confirm.rasi
    }

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
            systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
            systemctl suspend
        elif [[ $1 == '--hibernate' ]]; then
            systemctl hibernate
        elif [[ $1 == '--lock' ]]; then
            /usr/bin/hyprlock
        elif [[ $1 == '--logout' ]]; then
            hyprctl dispatch exit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        run_cmd --lock
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $hibernate)
        run_cmd --hibernate
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
