window=$(xdotool selectwindow)

#echo $(cowsay $1)
echo $window
while true
do
	#xdotool type --window $window '```';
	xdotool type --window $window "$1";
	#xdotool type --window $window '```';
	xdotool key --window $window Enter;
	sleep 1;
done
