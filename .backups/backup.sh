#!/bin/bash

#  Date format
YEAR=$(date '+%Y')
MONTH=$(date '+%m')
DAY=$(date '+%d')
TIME=$(date '+%H:%M:%S')

#  Destination path
DEST="$HOME/.backups/packages/$YEAR/$MONTH/$DAY"
mkdir -p "$DEST"

#  Output files
PACMAN_FILE="$DEST/pacman.txt"
AUR_FILE="$DEST/aur.txt"
PAMAC_FILE="$DEST/pamac.txt"
ALL_SORTED_FILE="$DEST/all_packages_sorted.txt"

#  Pacman - Official repo packages
echo "󰮯  Packages installed from official repos (pacman -Qn)" > "$PACMAN_FILE"
pacman -Qn | sort >> "$PACMAN_FILE"

#  AUR packages (yay, paru, etc.)
echo "󱄅  AUR packages installed (pacman -Qm)" > "$AUR_FILE"
pacman -Qm | sort >> "$AUR_FILE"

# 󰏖 Pamac packages
if command -v pamac &> /dev/null; then
    echo "󰏖  All packages listed by pamac" > "$PAMAC_FILE"
    pamac list --installed | sort >> "$PAMAC_FILE"
else
    echo "  Pamac is not installed" > "$PAMAC_FILE"
fi

# 󰣇 All packages sorted alphabetically (no duplicates)
{
    pacman -Qn
    pacman -Qm
} | cut -d' ' -f1 | sort -u > "$ALL_SORTED_FILE"

#  Summary output
echo -e "\n  Backup completed at $TIME"
echo "  Files saved in: $DEST"
ls -1 "$DEST" | sed 's/^/    /'
