#!/bin/sh
encdings="gbk utf-8 ascii big5 gb18030"
while true
do
	read str
	for encod in ${encdings}
	do
		convered=`echo ${str} | iconv -t ${encod} | xxd`
		echo "in ${encod},the encdod is: $convered"
	done
done
		
