#!/bin/bash
PATH=/bin:/sbin:/usr/bin/:/usr/local/bin/:/usr/local/sbin/:~/bin
export PATH

echo "It will calulate how many days to your next birthday !!"
echo "Author : Sen1993 [note:it is my first shell script !!]"

read -p "Input your birthday(example : 19931227) : " data1

if [ "$data1" == "" ]; then
	data1="19931227"
fi

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
