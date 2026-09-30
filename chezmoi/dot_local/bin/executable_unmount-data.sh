#!/usr/bin/env bash
set -euo pipefail

mountpoint=/mnt/data
wait_seconds=10

if [[ $EUID -ne 0 ]]; then
  exec sudo -- "$0" "$@"
fi

cd /

if ! mountpoint -q "$mountpoint"; then
  echo "$mountpoint is not mounted."
  exit 0
fi

mapfile -t pids < <(fuser -m "$mountpoint" 2>/dev/null | tr ' ' '\n' | awk '/^[0-9]+$/ && !seen[$0]++')

if ((${#pids[@]} == 0)); then
  echo "No processes are using $mountpoint."
else
  echo "Processes using $mountpoint:"
  ps -o pid,user,comm,args -p "$(IFS=,; echo "${pids[*]}")"
  echo
  read -r -p "Send these processes SIGTERM, wait up to ${wait_seconds}s, then unmount? [y/N] " answer
  case "$answer" in
    y|Y|yes|YES) ;;
    *) echo "Cancelled; no processes were stopped."; exit 1 ;;
  esac

  kill -TERM "${pids[@]}" 2>/dev/null || true

  for ((i = 0; i < wait_seconds; i++)); do
    sleep 1
    mapfile -t pids < <(fuser -m "$mountpoint" 2>/dev/null | tr ' ' '\n' | awk '/^[0-9]+$/ && !seen[$0]++')
    ((${#pids[@]} == 0)) && break
  done

  if ((${#pids[@]} > 0)); then
    echo "Still in use; refusing to force-stop these processes:"
    ps -o pid,user,comm,args -p "$(IFS=,; echo "${pids[*]}")"
    echo "Close them manually, then run: sudo umount $mountpoint"
    exit 1
  fi
fi

umount "$mountpoint"
echo "Unmounted $mountpoint."
