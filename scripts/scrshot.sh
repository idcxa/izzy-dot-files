#!/bin/bash
case $1 in
	reg)
		maim -u --format=png /dev/stdout | tee ~/Pictures/Screenshots/screenshot_$(date '+%Y-%m-%d-%H-%M-%S').png | xclip -selection clipboard -t image/png -i

	;;

	alt)
		maim -s -u --format=png /dev/stdout | tee ~/Pictures/Screenshots/screenshot_$(date '+%Y-%m-%d-%H-%M-%S').png | xclip -selection clipboard -t image/png -i

	;;

esac
