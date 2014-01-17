#  File : user.sh
#  ------------------------------------
#  Create date : 2014-01-17 16:04
#  Modified date: 2014-01-17 16:07
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


alluser=$(cat /etc/passwd | awk -F ":" '{print $1}' | sort -f)
count=0
for user in $alluser
do
	count=$(($count+1))
	echo $count : $user
done

echo
echo Total $count users... 
