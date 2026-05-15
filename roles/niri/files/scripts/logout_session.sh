#!/usr/bin/env sh

if command -v niri >/dev/null 2>&1; then
    exec niri msg action quit
fi

if [ -n "${XDG_SESSION_ID:-}" ]; then
    exec loginctl terminate-session "${XDG_SESSION_ID}"
fi

exit 1
