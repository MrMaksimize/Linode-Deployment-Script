#takes two variablles: user and domain
echo "nginx-vhost"
cat /root/home/deployment/config_files/php_subdomain_vhost.txt > /opt/nginx/sites-available/$2
sed -i "s/USER/$1/g" /opt/nginx/sites-available/$2
sed -i "s/DOMAIN/$2/g" /opt/nginx/sites-available/$2
ln -s /opt/nginx/sites-available/$2 /opt/nginx/sites-enabled/$2
#
# Web Directory Structure
mkdir -p /home/$1/public_html/$2/{backup,cgi-bin,log,private,public} #runme
#
#inc_scriptWWWWelcomeNginx
echo "all done" >> /home/$1/public_html/$2/public/index.php
#
#inc_scriptLogrotateNginx
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
" >> /etc/logrotate.d/$SHORTDOMAIN
#
#inc_scriptNginxReload
/etc/init.d/nginx stop
/etc/init.d/nginx start
#
#inc_scriptPHP-FPMreload
/etc/init.d/php5-fpm stop
/etc/init.d/php5-fpm start
#