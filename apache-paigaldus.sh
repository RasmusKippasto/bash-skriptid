#!/bin/bash

check=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
if [ $check -eq 1 ]; then
	echo "Apache2 on juba instaleeritud"
	service apache2 start
	service apache2 status
elif [ $check -eq 0 ]; then
	echo "Apache2 instaleerimine..."
	apt-get install apache2 -qq > /dev/null
	echo "Apache2 instaleeritud"
fi
