# rsha-skriptid
## Eesmärk
Skriptide eesmärk on Apache2 veebiserveri instaleerimine Wordpressiga
#### git
##### Paigaldamine
```
apt install git -y
```
##### Seadistamine
```
git config --global user.name "Eesnimi Perenimi"
git config --global user.email email@domeen.com
git config --global core.editor nano
```

#### Skriptid
##### apache-paigaldus.sh
* *Skript paigaldab Apache2 pageti
###### Manuaalne instaleerimine
```
apt install apache2 -y
```

##### php_paigaldus.sh
* *Skript paigaldab php7.0, apchge php7.0 mooduli ja php7.0 mysql mooduli paketid
###### Manuaalne instaleerimine
```
apt install php7.0 libapache2-mod-php7.0 php7.0-mysql -y
```

##### mysql-paigaldus.sh
* *Skript paigaldab mysql serveri ja loob kodukausta .my.cnf faili, mis võimaldab käivitada mysql käsku ilma sisse logimiseta
###### Manuaalne instaleerimine
```
apt install mysql-server -y
```
**Kui apt käsuga ei saa kõige uuemat mysql-serverit, siis tuleb uuendada apt  repositooriumi**
```
wget https://dev.mysql.com/get/mysql-apt-config_0.8.15-1_all.deb
dpkg -i mysql-apt-config*
apt update
```

##### andmebaasid.sh
* *Skript loob mysql andmebaasi, kasutaja ja annab kasutajale kõik õigused loodud andmebaasile
- Andmebaas: Wordpress
- Kasutaja: Wordpressuser
- Kasutaja parool: qwerty
###### Manuaalne andmebaasi loomine
```
CREATE DATABASE wordpress;                                          #Loob andmebaasi wordpress
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'qwerty';     #Loob kasutaja wordpressuser parooliga qwerty
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost'; #Annab kasutajale wordpressuser kõik õigused andmebaasis wordpress
FLUSH PRIVILEGES;                                                   #laadib toetustabeleid uuesti
```

##### pma_paigaldus.sh
* *Skript instaleerib phpmyadmin paketi* *
- Skripti käivitades tuleb valida Apache2 veebileht
- Skript küsib kas soovite automaatselt luua mysql andmebaasi, kui ei ole teist soovi siis valige 'JAH'
###### Manuaalne instaleerimine
```
apt install phpmyadmin -y
```

##### wordpress_paigaldus.sh
* *Skript tõmbab uusima wordpressi versiooni, pakib selle lahti ja muudab wp-config-sample.php faili
###### wp-config-sample.php
fail asub /var/www/html/wordpress kaustas
faili nimi muudetakse wp-config.php
faili sisus asendatakse:
- "database_name_here" loodud andmebaasiga "wordpress"
- "username_here" loodud kasutajanimega "wordpressuser"
- "password_here" loodud kasutaja parooliga "qwerty"
###### Manuaalne instaleerimine
```
wget https://wordpress.org/latest.tar.gz -P /var/www/html/
tar xzf /var/www/html/latest.tar.gz  -C /var/www/html/
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
rm -r /var/www/html/latest.tar.gz
nano /var/www/html/wordpress/wp-config.php     #kuhu panete andmebaasi nime, kasutaja nime ja parooli
```
## Kasutamine
### Automaatne
On võimalik käivitada ainult üks skript mis teeb kogu töö ära "veebiserveri_instaleerimine.sh", kui võib juhtuda, et on vaja igat ettappi käivitada eralid.
### Skriptide käivitamise järiekord
1. apache-paigaldus.sh
2. php_paigaldus.sh
3. mysql-paigaldus.sh
4. andmebaasid.sh
5. pma_paigaldus.sh
6. wordpress_paigaldus.sh
