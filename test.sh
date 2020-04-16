#!/bin/bash

#APACHE2 PAIGALDUS
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

#PHP PAIGALDUS
PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
if [ $PHP -eq 0 ]; then
	echo "PHP versioon 7.0 paigaldamine..."
	apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql -qq > /dev/null
	echo "PHP 7.0 instaleeritud"
elif [ $PHP -eq 1 ]; then
	echo "PHP on juba instaleeritud"
	which php
fi

#MYSQL SERVERI PAIGALDUS
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')
if [ $MYSQL -eq 0 ]; then
	echo "MYSQL serveri paigaldus koos vajalike lisadega....."
	apt-get install mysql-server -qq > /dev/null
	echo "MYSQL server on paigaltatud"
	touch $HOME/.my.cnf
	echo "[client]" >> $HOME/.my.cnf
	echo "host = localhost" >> $HOME/.my.cnf
	echo "user = root" >> $HOME/.my.cnf
	echo "password = qwerty" >> $HOME/.my.cnf
	echo "Konfiguratsiooni fail asub kaustas $HOME/.my.cnf"
elif [ $MYSQL -eq 1 ]; then
	echo "MYSQL server on juba paigaltatud"
	mysql
fi

#PHPMYADMIN PAIGALDUS
PHPMA=$(dpkg-query -W -f='{$Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
if [ $PHPMA -eq 0 ]; then
	echo "PHPmyadmin paigaldamine koos vajalike lisadega...."
	apt-get install phpmyadmin -q
	echo "PHPmyadmin on paigaltatud"
elif [ $PHPMA -eq 1 ]; then
	echo "PHPmyadmin on juba paigaltatud"
fi

#WORDPRESSI PAIGALDUS
echo "Wordpressi paketi allalaadmine..."
wget https://wordpress.org/latest.tar.gz -P /var/www/html/
tar xzf /var/www/html/latest.tar.gz  -C /var/www/html/
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
rm -r /var/www/html/latest.tar.gz
perl -pi -e "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
perl -pi -e "s/username_here/wordpressuser/g" /var/www/html/wordpress/wp-config.php
perl -pi -e "s/password_here/qwerty/g" /var/www/html/wordpress/wp-config.php
echo "Wordpress on instaleeritud kasuta /var/www/html/wordpress"
