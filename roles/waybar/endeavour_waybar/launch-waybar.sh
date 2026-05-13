#!/usr/bin/env sh

set -eu

config_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

case "${NIRI_SOCKET:+niri}${SWAYSOCK:+sway}" in
  niri*)
    config_file="$config_dir/config-niri.jsonc"
    ;;
  *sway)
    config_file="$config_dir/config-sway.jsonc"
    ;;
  *)
    config_file="$config_dir/config-niri.jsonc"
    ;;
esac

exec waybar -c "$config_file" -s "$config_dir/style.css"
