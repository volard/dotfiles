#!/usr/bin/env bash
killall -q polybar
echo "---" | tee -a /tmp/polybar_example.log
#polybar example >>/tmp/polybar_example.log 2>&1 &
polybar example -c ~/.config/polybar/config -r & >>/tmp/polybar_example.log 2>&1 &
echo "Bars launched..."

