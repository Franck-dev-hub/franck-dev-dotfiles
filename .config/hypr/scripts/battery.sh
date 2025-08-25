#!/bin/bash

THRESHOLD=20

BAT_DIR="/sys/class/power_supply"

TOTAL_NOW=0
TOTAL_FULL=0
DISCHARGING=false

for BAT in "$BAT_DIR"/BAT*; do
    if [[ -f "$BAT/energy_now" && -f "$BAT/energy_full" ]]; then
        NOW=$(cat "$BAT/energy_now")
        FULL=$(cat "$BAT/energy_full")
        STATE=$(cat "$BAT/status")

        TOTAL_NOW=$((TOTAL_NOW + NOW))
        TOTAL_FULL=$((TOTAL_FULL + FULL))

        if [[ "$STATE" == "Discharging" ]]; then
            DISCHARGING=true
        fi
    fi
done

if [[ $TOTAL_FULL -gt 0 ]]; then
    GLOBAL_PERCENT=$((100 * TOTAL_NOW / TOTAL_FULL))
else
    GLOBAL_PERCENT=0
fi

if [[ "$GLOBAL_PERCENT" -le "$THRESHOLD" && "$DISCHARGING" == true ]]; then
    notify-send -u critical "⚡ Batterie faible" "Charge globale : $GLOBAL_PERCENT%"
fi
