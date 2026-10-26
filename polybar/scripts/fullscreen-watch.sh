#!/usr/bin/env bash

hidden=0
last_pid=""

while true; do
  pid=$(pgrep -x polybar | head -n1)

  # polybar restarted or isn't running: reset state
  if [ "$pid" != "$last_pid" ]; then
    hidden=0
    last_pid="$pid"
  fi

  if [ -z "$pid" ]; then
    sleep 2
    continue
  fi

  fs=0
  win=$(xdotool getactivewindow 2>/dev/null)

  if [ -n "$win" ]; then
    if xprop -id "$win" _NET_WM_STATE 2>/dev/null | grep -q FULLSCREEN; then
      fs=1
    else
      read -r sw sh < <(xdotool getdisplaygeometry)
      eval "$(xdotool getwindowgeometry --shell "$win" 2>/dev/null)"
      if [ "${WIDTH:-0}" -ge "$sw" ] && [ "${HEIGHT:-0}" -ge "$sh" ]; then
        fs=1
      fi
    fi
  fi

  if [ "$fs" = 1 ] && [ "$hidden" = 0 ]; then
    polybar-msg -p "$pid" cmd hide >/dev/null 2>&1
    hidden=1
  elif [ "$fs" = 0 ] && [ "$hidden" = 1 ]; then
    polybar-msg -p "$pid" cmd show >/dev/null 2>&1
    hidden=0
  fi

  sleep 1
done
