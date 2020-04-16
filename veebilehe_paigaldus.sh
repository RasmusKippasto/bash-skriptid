#!/bin/bash
apt update
apt upgrade
sh apache-paigaldus.sh
sh php_paigaldus.sh
sh mysql-paigaldus.sh
sh pma_paigaldus.sh
sh wordpress_paigaldus.sh
