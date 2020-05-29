#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get install -y apache2
sudo systemctl start apache2.service
sudo systemctl enable apache2.service

sudo a2ensite magento2.conf
sudo a2enmod rewrite

sudo apt-get install -y software-properties-common
yes | sudo add-apt-repository ppa:ondrej/php

sudo apt-get install -y php7.2 libapache2-mod-php7.2 
sudo apt-get install -y php7.2-common
sudo apt-get install -y php7.2-gmp php7.2-curl
sudo apt-get install -y php7.2-soap
sudo apt-get install -y php7.2-bcmath php7.2-intl
sudo apt-get install -y php7.2-mbstring
sudo apt-get install -y php7.2-xmlrpc php7.2-mcrypt
sudo apt-get install -y php7.2-mysql
sudo apt-get install -y php7.2-gd php7.2-xml php7.2-cli
sudo apt-get install -y php7.2-zip

sudo sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php/7.1/apache2/php.ini
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 128M/' /etc/php/7.1/apache2/php.ini
sudo sed -i 's/max_execution_time = 30/max_execution_time = 3600/' /etc/php/7.1/apache2/php.ini

sudo systemctl restart apache2.service

sudo apt-get install -y mariadb-server mariadb-client
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

sudo mysql --user=root <<_EOF_
UPDATE mysql.user SET Password=PASSWORD('${db_root_password}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_

sudo mysql --user=root <<_EOF_
CREATE DATABASE magento;
CREATE USER 'guillermo'@'localhost' IDENTIFIED BY 'Welkom09!';
GRANT ALL ON magento.* TO 'guillermo'@'localhost' IDENTIFIED BY 'Welkom09!' WITH GRANT OPTION;
FLUSH PRIVILEGES;
_EOF_

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

wget https://github.com/magento/magento2/archive/2.3.5-p1.tar.gz
sudo tar -xzvf 2.3.5-p1.tar.gz -C /var/www/html/

sudo chown -R $USER:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/magento2-2.3.5-p1
sudo -u $USER composer install -d /var/www/html/magento2-2.3.5-p1
sudo chown -R www-data:www-data /var/www/html/

sudo systemctl restart apache2.service

