#  File : birthday.sh
#  ------------------------------------
#  Create date : 2014-02-23 21:51
#  Modified date : 2014-02-23 21:51
#  Author : Sen1993
#  Email : 1730806439@qq.com
#  ------------------------------------
 
#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "It will calulate how many days to your next birthday !!"

read -p "Input your birthday(example : 19931227) : " data1

[ "$data1" == "" ] && data1="19931227"

data_s1=$(date --date="$data1" +%s)
data_s2=$(date +%Y)$(echo $data1 | sed 's/^[0-9]\{4\}//g')
data_s2=$(date --date="$data_s2" +%s)
data_s3=$(date +%s)
data3=$(($data_s2-$data_s3))
if [ "$data3" -lt 0 ]; then
	data_s2=$(($(date +%Y)+1))
	data_s2=$data_s2$(echo $data1 | sed 's/^[0-9]\{4\}//g')
	data_s2=$(date --date="$data_s2" +%s)
	data3=$(($data_s2-$data_s3))
fi
data3=$(($data3/3600/24))
echo "Just "$data3" days you will grow up one year !!"
