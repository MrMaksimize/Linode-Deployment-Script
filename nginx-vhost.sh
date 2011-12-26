#takes two variablles: user and domain and type
echo "nginx-vhost $USER $DOMAIN $DOMAINTYPE $NGINX_PATH, $SHORTDOMAIN"
echo "nginx-vhost $1 $2 $3 $4 $5"
if [ $DOMAINTYPE == "DOMAIN" ]; then
	echo "creating domain"
	cat /root/deployment/config_files/php_domain_vhost.txt > $4/sites-available/$2
else
	echo "creating subdomain"
	cat /root/deployment/config_files/php_subdomain_vhost.txt > $4/sites-available/$2

sed -i "s/USER/$1/g" $4/sites-available/$2
sed -i "s/DOMAIN/$2/g" $4/sites-available/$2
ln -s $4/sites-available/$2 $4/sites-enabled/$2
#
# Web Directory Structure
mkdir -p /home/$1/public_html/$2/{backup,cgi-bin,log,private,public} #runme
#
echo "all done" >> /home/$1/public_html/$2/public/index.php
#
# Rotate Domain Log Files
sudo echo "
/home/$1/public_html/$2/log/*log
{
        rotate $LOG_ROTATE
        $LOG_FREQUENCY
        compress
        delaycompress
        sharedscripts
        postrotate
                /etc/init.d/nginx restart
        endscript
}
" >> /etc/logrotate.d/$5
/etc/init.d/nginx stop
/etc/init.d/nginx start
/etc/init.d/php5-fpm stop
/etc/init.d/php5-fpm start

sudo service ssh restart