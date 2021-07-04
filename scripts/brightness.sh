#!/bin/sh

BDV=$(cat /sys/class/backlight/intel_backlight/brightness)

for i in {1..30}
do
    case $1 in
        up)
            brightnessctl set +1
            ;;
        down)
            brightnessctl set 1-
            if (( "$BDV" < "30" )); then
                echo lessthan3
                brightnessctl set 1
                break
            fi
            ;;
    esac
    sleep 0.005
done



