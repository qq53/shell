#  File : cmd.sh
#  ------------------------------------
#  Create date : 2014-01-17 17:03
#  Modified date: 2014-01-18 00:41
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
		echo "Not exist this file !!"
		exit 1
	fi
else
	echo "need a filename like : alias"
	exit 1
fi

param="syntax options service filenames notes security output related key examples\
	descripton configuration files caveats values"
declare -A data

min=99999
for key in $param
do
	sum=$(cat -n ./bash/"$filename".txt | grep -i "^\s*[0-9]*\s*$key[:]*$"\
		| xargs | awk -F " " '{print $1}')
	if [ "$(($sum))" -gt 0 ]; then
		data[$key]=$(($sum))
		if [ ${data[$key]} -lt $min ]; then
			min=${data[$key]}
			minkey=$key
		fi
	fi
done

for key in ${!data[@]}
do
	echo $key ${data[$key]}
done

until [ "$keyword" != "" ]
do
	read -p "Input which keyword you want to see : " keyword
	if [ "$keyword" == "" ]; then
		echo " wrong data ,retry !!"
	else
		for key in ${!data[@]}
		do
			if [ "$keyword" == $key ]; then 
				flag=1
				break;
			fi
		done
		if [ "$(($flag))" -ne 1 ]; then
			echo "not find this keyword !!"
			exit 1
		fi
	fi
done

if echo $keyword | grep -i "descripton"; then
	flag=0
	for key in ${!data[@]}
	do
		if echo $key | grep -i "descripton"; then
			flag=1
			break;
		fi
	done
	if [ $(($flag)) -eq 0 ]; then
		cat ./bash/"$filename".txt | sed -n "1,"$(($min-1))"p"
	fi
fi

exit 0
