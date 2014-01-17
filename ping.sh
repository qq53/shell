#!/bin/bash
PATH=/bin:/sbin:/usr/bin/:/usr/local/bin/:/usr/local/sbin/:~/bin
export PATH

network="192.168.99"
for sitenu in $(seq 1 255)
do
	ping -c 1 -w 1 $network.$sitenu &> /dev/null && result=0 || result=1
	if [ $result == 0 ]; then
		echo "Server $network.$sitenu is UP."
	else
		echo "Server $network.$sitenu is DOWN."
	fi
done
