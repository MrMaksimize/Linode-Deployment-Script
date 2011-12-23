echo "nginx-vhost"
cat /root/home/deployment/config_files/php_subdomain_vhost.txt > /opt/nginx/sites-available/$DOMAIN
sed -i "s/USER/$USER/g" /opt/nginx/sites-available/$DOMAIN
sed -i "s/DOMAIN/$DOMAIN/g" /opt/nginx/sites-available/$DOMAIN
ln -s /opt/nginx/sites-available/$DOMAIN /opt/nginx/sites-enabled/$DOMAIN
#
# Web Directory Structure
mkdir -p /home/$USER/public_html/$DOMAIN/{backup,cgi-bin,log,private,public} #runme
addgroup webmasters #runme
usermod -G webmasters www-data #runme
chown -R MrMaksimize:webmasters /home/MrMaksimize/public_html && chmod -R g+w /home/MrMaksimize/public_html
find /home/$USER/public_html -type d -exec chmod g+s {} \; ##DON"T FORGET ABOUT ME
#
#inc_scriptWWWWelcomeNginx
echo "all done" >> /home/$USER/public_html/$DOMAIN/public/index.php
#
#inc_scriptLogrotateNginx
# Rotate Domain Log Files
sudo echo "
/home/$USER/public_html/$DOMAIN/log/*log
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