#  File : cmd.sh
#  ------------------------------------
#  Create date : 2014-01-17 17:03
#  Modified date: 2014-02-07 15:19
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear

if [ "$#" -eq 1 ]; then
	if [ -f "./bash/$1.txt" ]; then
		filename=$1
	else
		echo "Not exist this file !!" && exit 1
	fi
else
	echo "need a filename like : alias" && exit 1
fi

param=$(cat -n ./bash/"$filename".txt |\
	egrep -i "^\s+[0-9]+\s\b\w+\b:?$" | sed 's/://g')
param2=$(echo "$param" | awk -F ' ' '{print $2}')
declare -Ai data
declare -i sum

echo -e 'These KEYWORD can see :\n'
for key in $param2; do
	sum=$(echo "$param" | egrep -i "$key" | awk -F ' ' '{print $1}')
	[ "$sum" -gt 0 ] && data[$key]=$(($sum)) && echo "$key "
done
echo

declare -Ai nextarr
declare -i j
declare -i i=0
tmp=$(echo ${data[@]} | sed 's/ /\n/g' | sort -n)
for j in $tmp; do
	nextarr[$i]=$j
	i=$i+1
done

declare -i flag
while [ 1 ]; do
	keyword=""
	flag=0
	
	read -p "Input which keyword (default filename && q to exit) : " keyword
	echo "$keyword" | grep -i "q" > /dev/null && exit 0
	for key in ${!data[@]}; do
		if echo "$keyword" | grep -i "$key" > /dev/null; then 
			flag=1
			break
		fi
	done
	if [ "$flag" -eq 0 ] && [ -z "$keyword" ]; then
		keyword=$filename
		flag=1
	fi
	[ "$flag" -eq 0 ] && echo "not find this keyword !!" && continue 1

	flag=2
	declare -i k
	for key in ${!data[@]};  do
		if echo "$key" | grep -i "$keyword" > /dev/null; then
			i=${data[$key]}
			for j in ${nextarr[@]}; do
				if [ "$flag" -eq 0 ]; then
					flag=1
					break
				fi
				[ "$j" -eq "$i" ] && flag=0
			done
			break
		fi
	done
	if [ "$flag" -eq 1 ]; then
		j=$j-1
		sed -n $i','$j'p' ./bash/"$filename".txt | grep ".*" --color
	else
		sed -n $i',$p' ./bash/"$filename".txt | grep ".*" --color
	fi
done
