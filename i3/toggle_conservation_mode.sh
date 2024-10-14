#!/usr/bin/env bash

# File path for conservation mode
CONSERVATION_MODE_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

# Get current state
current_mode=$(cat $CONSERVATION_MODE_PATH)

# Dmenu prompt with options
choice=$(echo -e "1\n0" | dmenu -p "Conservation Mode (1 for On, 0 for Off):" -fn "DejaVuSansM Nerd Font-15" -b)

# Check if user made a selection
if [[ -n "$choice" ]]; then
    # Check if the choice is valid (either 1 or 0)
    if [[ "$choice" == "1" || "$choice" == "0" ]]; then
        # Set conservation mode
        echo $choice | pkexec tee $CONSERVATION_MODE_PATH > /dev/null

        # Notify the user
        if [[ "$choice" == "1" ]]; then
            notify-send "Conservation Mode" "ON" -i info
        else
            notify-send "Conservation Mode" "OFF" -i info
        fi
    else
        notify-send "Invalid Selection" "Please choose 1 (On) or 0 (Off)." -i error
    fi
else
    notify-send "No Selection" "No mode selected." -i error
fi

