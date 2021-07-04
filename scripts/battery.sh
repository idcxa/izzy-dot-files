#!/bin/sh
B1=$(cat /sys/class/power_supply/BAT0/capacity)
B2=$(cat /sys/class/power_supply/BAT1/capacity)

icon () {
    if (( "$1" < "13"))
    then
        echo -ne $1% 
    elif (( "$1" < "38"))
    then
        echo -ne $1% 
    elif (( "$1" < "63"))
    then
        echo -ne $1% 
    elif (( "$1" < "83"))
    then
        echo -ne $1% 
    else
        echo -ne "$1%  "
    fi
}
icon $1
