#  File : cmd.sh
#  ------------------------------------
#  Create date : 2014-01-17 17:03
#  Modified date: 2014-01-18 21:44
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

param="syntax options service filenames notes security output related key examples\
	descripton configuration files caveats values details"
declare -Ai data
declare -i min=99999
declare -i sum

echo 'These KEYWORD can see :'
for key in $param; do
	sum=$(cat -n ./bash/"$filename".txt | egrep -i "^\s*[0-9]+\s*$key[:]?$"\
		| xargs | awk -F " " '{print $1}')
	if [ "$sum" -gt 0 ]; then
		data[$key]=$(($sum))
		echo "$key "
		if [ ${data[$key]} -lt $min ]; then
			min=${data[$key]}
			minkey=$key
		fi
	fi
done
min=$min-1

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
	keyword="";
	flag=0
	until [ -n "$keyword" ]; do
		read -p "Input which keyword you want to see(q to exit) : " keyword
		echo "$keyword" | grep -i "q" > /dev/null && exit 0
		if [ -z "$keyword" ]; then
			echo " wrong data ,retry !!"
		else
			for key in ${!data[@]}; do
				if [ "$keyword" = "$key" ]; then 
					flag=1
					break
				fi
			done
			if [ "$flag" == 0 ]; then
				if echo "$keyword" | grep -i "description" > /dev/null; then
					sed -n '1,'$min'p' ./bash/"$filename".txt | grep ".*" --color
					continue 2
				fi
			fi
			if [ "$flag" != 1 ]; then
				echo "not find this keyword !!"
				exit 1
			fi
		fi
	done

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
				[ "$j" -eq $i ] && flag=0
			done
			break
		fi
	done
	if [ "$flag" == 1 ]; then
		j=$j-1
		sed -n $i','$j'p' ./bash/"$filename".txt | grep ".*" --color
	else
		sed -n $i',$p' ./bash/"$filename".txt | grep ".*" --color
	fi
	echo
done
