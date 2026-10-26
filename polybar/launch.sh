#!/usr/bin/env bash

killall -q polybar
pkill -f fullscreen-watch.sh
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

polybar top 2>&1 | tee -a /tmp/polybar.log & disown
sleep 1
~/.config/polybar/scripts/fullscreen-watch.sh >/dev/null 2>&1 & disown
