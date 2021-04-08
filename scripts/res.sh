#!/bin/bash
res=$(xdpyinfo | grep dimensions)
res=${res:14:7}
dpi1080p=110
dpi4k=220
if [ $res -eq 3840 ] || [ $1 -eq 1080 ]; then
	xrandr --output eDP-1-1 --mode 1920x1080 --dpi $dpi1080p
	sed -i 's#Xft.dpi:.*#Xft.dpi: 110#' ~/.Xresources
	xrdb -merge ~/.Xresources
	xrandr --dpi $dpi1080p
	nitrogen --set-zoom-fill ~/.config/wall.png &
elif [ $res -eq 1920 ] || [ $1 -eq 3840 ]; then
	xrandr --output eDP-1-1 --mode 3840x2160 --dpi 220
	sed -i 's#Xft.dpi:.*#Xft.dpi: 220#' ~/.Xresources
	xrdb -merge ~/.Xresources
	xrandr --dpi 220
	nitrogen --set-zoom-fill ~/.config/wall.png &

fi
