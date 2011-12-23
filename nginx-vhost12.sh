echo "nginx-vhost"
echo '
server {
            listen   80;
            server_name  www.DOMAIN;
            rewrite ^/(.*) http://DOMAIN/$1 permanent;
       }
server {
            listen   80;
            server_name DOMAIN;
            access_log /home/USER/public_html/DOMAIN/log/access.log;
            error_log /home/USER/public_html/DOMAIN/log/error.log;
            location /  {
                        root   /home/USER/public_html/DOMAIN/public/;
                        index  index.php index.html;
                        }
            # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
            location ~ \.php$
                    {
            fastcgi_pass 127.0.0.1:9000;
            fastcgi_index index.php;
            include /usr/local/nginx/conf/fastcgi_params;
            fastcgi_param SCRIPT_FILENAME /home/USER/public_html/DOMAIN/public/$fastcgi_script_name;
                        }
       }
' > /usr/local/nginx/sites-available/$DOMAIN
sed -i "s/USER/$USER/g" /usr/local/nginx/sites-available/$DOMAIN
sed -i "s/DOMAIN/$DOMAIN/g" /usr/local/nginx/sites-available/$DOMAIN
ln -s /opt/nginx/sites-available/maxipad.mrmaksimize.com /opt/nginx/sites-enabled/maxipad.mrmaksimize.com
#
#inc_scriptWWWDirPerms
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