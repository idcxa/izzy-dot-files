window=$(xdotool selectwindow)
while true
do
xdotool key --window $window --delay 90 Up \
				key --window $window --delay 90 ctrl+a \
				key --window $window --delay 90 BackSpace \
				key --window $window --delay 100 Enter \
				key --window $window --delay 100 Enter \
				key --window $window --delay 5 a \
				key --window $window --delay 5 BackSpace
done
