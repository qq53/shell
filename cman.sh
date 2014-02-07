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
	man $1 > /dev/null && filename=$1 || echo "Wrong command !!" || exit 1
else
	[ "$#" -gt 1 ] && echo "just one param !!" || echo "need a param !!"
	exit 0
fi

param=$(man $filename | cat -n |\
	egrep "^\s+[0-9]+\s([A-Z]+\s?)+:?$" | sed 's/://g')
param2=$(echo "$param" | sed 's/^\s+[0-9]+\s//g' -r )
showmsg=$(echo "$param2" | tr [A-Z] [a-z] | sed 's/^[a-z]/\u&/g')

declare -i flag
declare -i i
declare -i j
declare -i k
while [ 1 ]; do
	echo -e 'These KEYWORD can see : \n'
	echo "$showmsg" | egrep -n "^\w" --color
	echo

	keyword=""
	until [ -n "$keyword" ]; do
		read -p "enter a number(q to exit): " choose
		[ "$choose" == "q" ] && exit 0
		[ "$choose" == "0" ] && echo "too small !!" && continue 1
		i=$(($choose))
		[ "$i" -eq 0 ] && echo "input number !!" && continue 1
		[ "$i" -lt 0 ] && echo "too small !!" && continue 1 ||\
			keyword=$(echo "$param2" | sed -n "${i}p")
		[ -z "$keyword" ] && echo "too big !!" 
	done
	
	clear
	
	k=$(echo "$param" | cat -n | egrep "$keyword" | awk -F ' ' '{print $1}')	
	i=$(echo "$param" | sed -n "$k"'p' | awk -F ' ' '{print $1}')
	j=$(echo "$param2" | wc -l)
	k=$k+1
	
	if [ "$k" -le "$j" ]; then
		j=$(echo "$param" | sed -n "${k}p" | awk -F ' ' '{print $1}')
		j=$j-1
		man "$filename" | sed -n $i','$j'p' | less | grep ".*" --color
	else
		man "$filename" | sed -n $i',$p' | less | grep ".*" --color
	fi
done
