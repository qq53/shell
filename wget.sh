#  File : wget.sh
#  ------------------------------------
#  Create date : 2014-03-11 19:50
#  Modified date: 2014-03-11 21:41
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

base="http://round2.sinaapp.com/"
aa=""
declare -i i=1

while true; do
	aa=$(curl $base$aa | egrep -o "\w+.htm")
	aa=$(echo $aa | awk -F ' ' '{print $2}')
	echo $aa
	i+=1
	[ $i -ge 998 ] && break 1
done
