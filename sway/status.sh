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

lang=$(swaymsg -t get_inputs | jq -r '.[].xkb_active_layout_name | select(. != null)' | head -1 | cut -c1-2 | sed s/En/'  '/ | sed s/Ru/RU/)
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2*100}')

caps=$(cat /sys/class/leds/input18::capslock/brightness | sed s/0/'        '/ | sed s/1/'CAPSLOCK'/)

uptime=$(awk '{printf "%6.1f", $1/86400}' /proc/uptime)

echo "$uptime     $worksp                                                              $(date +'%Y/%m/%d %H:%M:%S')                                       $caps    $lang     $bat    $(($(cat /sys/class/thermal/thermal_zone1/temp) / 1000 + 273)) K    $vol%"

sleep 0.01
done
