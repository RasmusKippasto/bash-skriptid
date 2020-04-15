#!/bin/bash

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
