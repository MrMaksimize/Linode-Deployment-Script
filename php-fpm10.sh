#!/bin/bash
echo "php-fpm"
/root/deployment/variables1.sh &
# Install PHP
aptitude install -y php5-cli php5-common php5-suhosin
aptitude install -y php5-fpm php5-cgi
aptitude install -y $PHP_MODS
sed -i "s/#/;/g" /etc/php5/conf.d/imagick.ini