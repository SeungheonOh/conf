#!/usr/bin/env bash

while true; do
    battery=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)
    time=$(date +'%Y-%m-%d %X')
    vol=$(pamixer --get-volume)
    echo "$time | $vol | $battery% $status"
    sleep 10
done
