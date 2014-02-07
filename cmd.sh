#  File : cmd.sh
#  ------------------------------------
#  Create date : 2014-01-17 17:03
#  Modified date: 2014-02-07 16:57
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear

if [ "$#" -eq 1 ]; then
	[ -f "./bash/$1.txt" ] && filename=$1 || echo "Not exist this file !!" || exit 1
else
	[ "$#" -gt 1 ] && echo "just one param" || echo "need a filename like alias"
	exit 0
fi

param=$(cat -n ./bash/"$filename".txt |\
	egrep -i "^\s+[0-9]+\s\b\w+\b:?$" | sed 's/://g')
param2=$(echo "$param" | awk -F ' ' '{print $2}')

echo -e 'These KEYWORD can see :\n'
echo -e "$param2\n"

declare -i flag
declare -i i
declare -i j
declare -i k
while [ 1 ]; do
	keyword=""
	flag=0
	k=0

	read -p "Input which keyword (default filename && q to exit) : " keyword
	echo "$keyword" | grep -i "q" > /dev/null && exit 0
	[ -z "$keyword" ] && keyword=$filename
	for key in $param2; do
		k=$k+1
		if echo "$keyword" | grep -i "$key" > /dev/null; then
			flag=1 
			break
		fi
	done
	[ "$flag" -eq 0 ] && echo "not find this keyword !!" && continue 1

	i=$(echo "$param" | sed -n "$k"'p' | awk -F ' ' '{print $1}')
	j=$(echo "$param" | sed -n "$(($k+1))p" | awk -F ' ' '{print $1}')

	if [ "$j" -gt 0 ]; then
		j=$j-1
		sed -n $i','$j'p' ./bash/"$filename".txt | grep ".*" --color
	else
		sed -n $i',$p' ./bash/"$filename".txt |grep ".*" --color
	fi
done
