#!/usr/bin/env bash
str="$*" >> /tmp/str
cd /tmp
for i in `seq 1 ${#str}`;
do
	rand="$(( $(od -vAn -N4 -tu < /dev/urandom) % 2))"
	letter="$(echo $str | cut -c$i)"
	letter="${letter^^}"
	#lastletter="$(echo $str | cut -c$[$i-1])"
	#lastletter="${lastletter^^}"
	#echo $lastletter
	letter="$letter"
	if [ "$letter" == "C" ]
	then
		letter="G"
	elif [ "$letter" == "T" ]
	then
		letter="D"
	elif [ "$letter" == "C" ] && [ "$lastletter" == "I" ]
	then
		letter="IN"
	elif [ "$letter" == "C" ] && [ "$lastletter" == "C" ]
	then
		letter="K"
	elif [ "$letter" == "K" ] && [ "$lastletter" == "C" ]
	then
		letter="G"
	elif [ "$letter" == "P" ]
	then
		letter="B"
	elif [ "$letter" == "K" ]
	then
		letter="G"
	#elif [ "$letter" == '\"' ] || [ "$letter" == "." ] || [ "$letter" == "\"" ] || [ "$letter" == "," ] || [ "$letter" == "\'" ]
	#then
	#	letter=""
	fi
	out="$out$letter"
done
out="$out"" ":D""

for i in `seq 1 ${#str}`;
do
	rand="$(( $(od -vAn -N4 -tu < /dev/urandom) % 5))"
	if [ "$rand" -eq "0" ]
	then
		out="$out"D""
	fi
done
echo $out
echo $out | xclip -sel clip
