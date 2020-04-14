#!/bin/bash

PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')

if [ $PHP -eq 0 ]; then
	echo "PHP versioon 7.0 paigaldamine..."
	apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql -qq > /dev/null
	echo "PHP 7.0 instaleeritud"
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba instaleeritud"
	which php
fi
