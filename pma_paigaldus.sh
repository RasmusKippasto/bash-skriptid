#!/bin/bash

PHPMA=$(dpkg-query -W -f='{$Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')

if [ $PHPMA -eq 0 ]; then
	echo "PHPmyadmin paigaldamine koos vajalike lisadega...."
	apt-get install phpmyadmin -y
	echo "PHPmyadmin on paigaltatud"
elif [ $PHPMA -eq 1 ]; then
	echo "PHPmyadmin on juba paigaltatud"
fi
