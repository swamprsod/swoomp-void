#!/bin/env sh
while true; do
worksp=$(swaymsg -r -t get_workspaces 2>/dev/null | jq -r '.[] | select(.focused==true).num' 2>/dev/null)
[ -n "$worksp" ] && worksp=$(printf "%2d" "$worksp") || worksp="  "

if [ -f /sys/class/power_supply/BAT0/capacity ]; then
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 0)
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
case $status in
Charging) bat="+CH:${cap}%" ;;
Full) bat="100%" ;;
*) bat="${cap}%" ;;
esac
else
bat="N/A"
fi

lang=$(swaymsg -t get_inputs 2>/dev/null | jq -r '.[].xkb_active_layout_name | select(. != null)' 2>/dev/null | head -1 | cut -c1-2 | sed 's/En/  /' | sed 's/Ru/RU/')
[ -z "$lang" ] && lang="  "

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{printf "%.0f", $2*100}' || echo 0)

uptime=$(awk '{printf "%6.1f", $1/86400}' /proc/uptime 2>/dev/null || echo "0.0")

temp=$(($(cat /sys/class/thermal/thermal_zone1/temp 2>/dev/null || echo 0) / 1000 + 273))

echo "$uptime |$worksp | $(date +'%Y/%m/%d %H:%M:%S') | $lang | $bat | ${temp} K | ${vol}%"

sleep 0.5
done
