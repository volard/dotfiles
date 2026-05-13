#!/usr/bin/env sh

if [ -n "${NIRI_SOCKET:-}" ]; then
    exec niri msg action quit
fi

if [ -n "${SWAYSOCK:-}" ]; then
    exec swaymsg exit
fi

if [ -n "${XDG_SESSION_ID:-}" ]; then
    exec loginctl terminate-session "${XDG_SESSION_ID}"
fi

exit 1
