#!/usr/bin/env bash

if pgrep -x rofi >/dev/null; then
  pkill -x rofi
  exit 0
fi

sleep_opt="󰒲  Sleep"
shut_opt="󰐥  Shutdown"
reboot_opt="󰜉  Reboot"

choice=$(printf '%s\n%s\n' "$sleep_opt" "$shut_opt" "$reboot_opt" | rofi -dmenu -i \
  -no-custom \
  -theme-str 'window {location: northeast; anchor: northeast; x-offset: -8px; y-offset: 32px; width: 180px; }' \
  -theme-str 'mainbox {children: [listview];}' \
  -theme-str 'listview {lines: 3; fixed-height: false;}')

case "$choice" in
  "$sleep_opt")   systemctl suspend ;;
  "$shut_opt")    systemctl poweroff ;;
  "$reboot_opt")  systemctl reboot ;;
esac
