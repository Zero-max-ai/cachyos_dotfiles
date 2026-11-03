#!/usr/bin/env bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
  artist=$(playerctl metadata artist 2>/dev/null)
  title=$(playerctl metadata title 2>/dev/null)

  if [ -n "$artist" ]; then
    text="$artist - $title"
  else
    text="$title"
  fi

  icon="󰎆"
  [ "$status" = "Paused" ] && icon="󰏤"

  echo "$icon ${text:0:40}"
else
  echo ""
fi
