#!/usr/bin/env bash

if pgrep -x "swaylock" > /dev/null
then
    exit 0
else
    brightnessctl -s
    brightnessctl set 0%
    swaylock && brightnessctl -r
fi
