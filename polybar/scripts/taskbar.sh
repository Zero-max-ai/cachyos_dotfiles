#!/usr/bin/env bash

icon() {
  case "${1,,}" in
    *firefox*)                                echo "󰈹" ;;
    *chrom*|*brave*|*vivaldi*)                echo "󰊯" ;;
    *alacritty*|*kitty*|*xterm*|*terminal*)   echo "󰆍" ;;
    *code*|*codium*)                          echo "󰨞" ;;
    *thunar*|*nautilus*|*pcmanfm*)            echo "󰉋" ;;
    *discord*)                                echo "󰙯" ;;
    *telegram*)                               echo "󰔁" ;;
    *spotify*)                                echo "󰓇" ;;
    *obsidian*)                               echo "󰠮" ;;
    *vlc*|*mpv*)                              echo "󰕼" ;;
    *)                                        echo "󰖲" ;;
  esac
}

while true; do
  cur=$(xprop -root _NET_CURRENT_DESKTOP 2>/dev/null | awk '{print $3}')
  act=$(xdotool getactivewindow 2>/dev/null)
  act_hex=$(printf '0x%08x' "${act:-0}")
  out=""

  while read -r id desk cls rest; do
    if [ "$desk" != "$cur" ] && [ "$desk" != "-1" ]; then continue; fi
    case "${cls,,}" in
      *polybar*|*xfdesktop*|*xfce4-panel*) continue ;;
    esac
    ic=$(icon "$cls")
    if [ "$id" = "$act_hex" ]; then
      out+="%{A1:wmctrl -ia $id:}%{u#ffffff}%{+u} $ic %{-u}%{A}"
    else
      out+="%{A1:wmctrl -ia $id:}%{F#6c7086} $ic %{F-}%{A}"
    fi
  done < <(wmctrl -lx)

  printf '%s\n' "${out:- }"
  sleep 1
done
