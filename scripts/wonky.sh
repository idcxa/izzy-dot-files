#!/usr/bin/bash
str="$*"
for i in `seq 1 ${#str}`;
do
	rand="$(( $(od -vAn -N4 -tu < /dev/urandom) % 2))"
	letter="$(echo $str | cut -c$i)"
	if [ "$rand" -eq "0" ] 
	then
		letter="${letter^^}"
	else 
		letter="${letter,,}"
	fi
	out="$out$letter"
done 
echo $out
echo $out | xclip -sel clip
