#!/bin/bash

# List of options
options="Shutdown\nReboot\nLogout\nLock"

# Display options in dmenu with DejaVu Nerd Font and at the bottom
selected=$(echo -e "$options" | dmenu -i -p "Select action:" -fn "DejaVuSansM Nerd Font-15" -b)

# Perform the selected action
case "$selected" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        i3-msg exit
        ;;
    Lock)
        i3lock
        ;;
    *)
        ;;
esac

