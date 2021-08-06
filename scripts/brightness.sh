#!/bin/sh

BDV=$(cat /sys/class/backlight/intel_backlight/brightness)

expr $BDV * 0.8
echo $F
for i in {1..$F}
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



