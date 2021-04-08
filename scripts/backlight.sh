#!/bin/bash

bd=/sys/class/backlight/intel_backlight/brightness

bdv=$(cat $bd)

case $1 in
	up)
		if [ $bdv -gt 802 ]
		then
			echo $(( 852 )) > $bd
		else
                        for i in {1..25}
                        do
                            echo $(( bdv + 1 )) > $bd
                        done
		fi
		cat $bd
	;;
	down)
		if [ $bdv -lt 101 ]
		then
			echo $(( 1 )) > $bd
		else
			echo $(( bdv - 25 )) > $bd
		fi
		cat $bd
	;;
	max)
		echo $(( 852 )) > $bd
		cat $bd
	;;
	min)
		echo $(( 1 )) > $bd
		cat $bd
	;;
	*)
	echo "$bdv"
esac
