#!/usr/bin/env bash

set -euo pipefail

logout_session() {
    ~/.config/niri/scripts/logout_session.sh
}

poweroff_system() {
    systemctl -i poweroff || loginctl poweroff
}

confirm_action() {
    local action="$1"
    local confirmation

    confirmation="$(
        printf "No\nYes" |
            fuzzel --dmenu -a -l 2 -w 38 -p "$action? "
    )"

    [[ "$confirmation" == "Yes" ]]
}

selection="$(
    printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Log out\n Reboot\n Reboot to UEFI\n󰐥 Shutdown" |
        fuzzel --dmenu -l 6 -w 38
)"

case "$selection" in
    "󰌾 Lock")
        gtklock
        ;;
    "󰤄 Suspend")
        if confirm_action "Suspend"; then
            systemctl suspend
        fi
        ;;
    "󰍃 Log out")
        if confirm_action "Log out"; then
            logout_session
        fi
        ;;
    " Reboot")
        if confirm_action "Reboot"; then
            systemctl reboot
        fi
        ;;
    " Reboot to UEFI")
        if confirm_action "Reboot to UEFI"; then
            systemctl reboot --firmware-setup
        fi
        ;;
    "󰐥 Shutdown")
        if confirm_action "Shutdown"; then
            poweroff_system
        fi
        ;;
esac
