#!/usr/bin/env sh

if command -v swaymsg >/dev/null 2>&1; then
    exec swaymsg exit
fi

if [ -n "${XDG_SESSION_ID:-}" ]; then
    exec loginctl terminate-session "${XDG_SESSION_ID}"
fi

exit 1
