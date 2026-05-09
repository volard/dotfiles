#!/bin/bash

host="127.0.0.1"
port="6600"
title_max_len=28

trim_title() {
    local title="$1"
    local max_len="$2"

    if ((${#title} <= max_len)); then
        printf '%s' "$title"
    else
        printf '%s…' "${title:0:max_len-1}"
    fi
}

current="$(timeout 2 mpc -h "$host" -p "$port" --format '%artist%\t%album%\t%title%' current 2>/dev/null)" || {
    printf 'Disconnected \n'
    exit 0
}

status="$(timeout 2 mpc -h "$host" -p "$port" status 2>/dev/null)" || {
    printf 'Disconnected \n'
    exit 0
}

IFS=$'\t' read -r artist album title <<<"$current"
mapfile -t status_lines <<<"$status"

if ((${#status_lines[@]} < 2)); then
    printf 'Stopped \n'
    exit 0
fi

state_line="${status_lines[1]}"
options_line="${status_lines[2]:-}"

case "$state_line" in
    *"[playing]"*) state_icon="" ;;
    *"[paused]"*) state_icon="" ;;
    *) state_icon="" ;;
esac

consume_icon=""
random_icon=""
repeat_icon=""
single_icon=""

[[ "$options_line" == *"consume: on"* ]] && consume_icon=" "
[[ "$options_line" == *"random: on"* ]] && random_icon=" "
[[ "$options_line" == *"random: off"* ]] && random_icon=" "
[[ "$options_line" == *"repeat: on"* ]] && repeat_icon=" "
[[ "$options_line" == *"single: on"* ]] && single_icon="1 "

queue_pos="$(printf '%s\n' "$state_line" | sed -n 's/.*#\([0-9]\+\)\/\([0-9]\+\).*/\1|\2/p')"
time_info="$(printf '%s\n' "$state_line" | sed -n 's/.* \([0-9]\+:[0-9]\+\/[0-9]\+:[0-9]\+\) .*/\1/p')"
volume="$(printf '%s\n' "$options_line" | sed -n 's/.*volume:\([0-9]\+\)%.*/\1/p')"

artist="${artist:-N/A}"
album="${album:-N/A}"
title="${title:-N/A}"
title="$(trim_title "$title" "$title_max_len")"

printf '%s %s%s%s%s%s - %s - %s' \
    "$state_icon" \
    "$consume_icon" \
    "$random_icon" \
    "$repeat_icon" \
    "$single_icon" \
    "$artist" \
    "$album" \
    "$title"

if [[ -n "$time_info" ]]; then
    printf ' (%s)' "$time_info"
fi

if [[ -n "$queue_pos" ]]; then
    printf ' ⸨%s⸩' "$queue_pos"
fi

if [[ -n "$volume" ]]; then
    printf ' %s%% ' "$volume"
else
    printf ' '
fi

printf '\n'
