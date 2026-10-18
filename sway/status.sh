#!/bin/env sh

WF=/tmp/swaystatus_ws
LF=/tmp/swaystatus_lang

upd_ws() {
w=$(swaymsg -r -t get_workspaces 2>/dev/null|jq -r '.[] | select(.focused==true).num' 2>/dev/null)
[ -n "$w" ] &&printf "%2d\n" "$w" > "$WF" ||printf "  \n" > "$WF"
}
upd_lang() {
l=$(swaymsg -t get_inputs 2>/dev/null|jq -r '.[].xkb_active_layout_name | select(. != null)' 2>/dev/null|head -1|cut -c1-2|sed 's/En/  /'|sed 's/Ru/RU/')
[ -n "$l" ] &&printf "%s\n" "$l" > "$LF" ||printf "  \n" > "$LF"
}

upd_ws; upd_lang

swaymsg -t subscribe -m '["workspace"]' 2>/dev/null|while read -r _; do upd_ws; done & SW1=$!
swaymsg -t subscribe -m '["input"]' 2>/dev/null|while read -r _; do upd_lang; done & SW2=$!
trap 'kill $SW1 $SW2 2>/dev/null' EXIT

read_cpu() { read -r _ u n s i w q sq st rest < /proc/stat; echo $((u+n+s+i+w+q+sq+st)) $i; }
set -- $(read_cpu); pt=$1; pi=$2

loop=0; topproc="N/A"
while true; do
IFS= read -r worksp < "$WF" 2>/dev/null; [ -z "$worksp" ] &&worksp="  "
IFS= read -r lang < "$LF" 2>/dev/null; [ -z "$lang" ] &&lang="  "

set -- $(read_cpu)
dt=$(($1-pt)); di=$(($2-pi)); pt=$1; pi=$2
[ "$dt" -gt 0 ] &&cpu="$(((dt-di)*100/dt)) %" ||cpu="0 %"

if [ -f /sys/class/power_supply/BAT0/capacity ];then
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null ||echo 0)
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null||echo "???what")
case $status in
Charging) bat="+CH:${cap} %" ;;
Full) bat="100 %" ;;
*) bat="${cap} %" ;;
esac
else
bat="N/A"
fi

ram=$(free -m 2>/dev/null |awk '/^Mem:/{printf "%.1f GiB = %.0f %%", $3/1024, $3/$2*100}')
[ -z "$ram" ]&&ram="N/A"

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null|awk '{printf "%.0f", $2*100}'||echo 0)

[ $((loop%20)) -eq 0 ] && {
topproc=$(ps -eo pcpu,comm --sort=-pcpu 2>/dev/null|awk 'NR==2{printf "%s %.0f %%", $2, $1}')
[ -z "$topproc" ] &&topproc="N/A"
}

uptime=$(awk '{printf " %2.1f", $1/86400}' /proc/uptime 2>/dev/null ||echo "0.0")

temp=$(($(cat /sys/class/thermal/thermal_zone1/temp 2>/dev/null ||echo 0)/1000+273))

echo "$SHELL ╏ $topproc ╏$uptime ╏ $worksp ╏ $(date +'%Y/%m/%d %H:%M:%S') ╏ $lang ╏ $cpu ╏ $ram ╏ $bat ╏ ${temp} K ╏ ${vol} %"

loop=$((loop+1))
sleep 0.1
done
