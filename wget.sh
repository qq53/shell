#  File : 1.sh
#  ------------------------------------
#  Create date : 2014-03-11 19:50
#  Modified date: 2014-03-11 21:01
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

base="http://round2.sinaapp.com/"
aa=$base
declare -i i=1

while true; do
	aa=$(wget -q $aa && cat *.htm* | egrep -o "\w+.htm")
	aa=$(echo $aa | awk -F ' ' '{print $2}')
	echo $aa
	aa=$base$aa
	i+=1
	[ $i -ge 998 ] && break 1
	break 1
	rm *.htm*
done
