#!/bin/env sh
while true; do
worksp=$(swaymsg -r -t get_workspaces | jq -r '.[] | select(.focused==true).num')
[ -n "$worksp" ] && worksp=$(printf "%2d" "$worksp")

cap=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
case $status in
Charging) bat="+CH:${cap}%" ;;
Full) bat="100%" ;;
*) bat="${cap}%" ;;
esac

lang=$(swaymsg -t get_inputs | jq -r '.[].xkb_active_layout_name | select(. != null)' | head -1 | cut -c1-2 | sed s/En/EN/ | sed s/Ru/RU/)
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2*100}')

echo "UP:$(~/bin/uptime_wbr)      $worksp                                                          $(date +'%d/%m/%y %H:%M:%S')                                                   $(($(cat /sys/class/thermal/thermal_zone1/temp) / 1000 + 273)) K    $bat    $lang    $vol%"

sleep 0.1
done
