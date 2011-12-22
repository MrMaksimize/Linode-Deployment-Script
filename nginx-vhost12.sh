#!/bin/bash
./home/root/deployment/variables1.sh
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
ln -s /usr/local/nginx/sites-available/$DOMAIN /usr/local/nginx/sites-enabled/$DOMAIN
#
#inc_scriptWWWDirPerms
# Web Directory Structure
mkdir -p /home/$USER/public_html/$DOMAIN/{backup,cgi-bin,log,private,public}
addgroup webmasters
usermod -G webmasters www-data
chown -R $USER:webmasters /home/$USER/public_html && chmod -R g+w /home/$USER/public_html
find /home/$USER/public_html -type d -exec chmod g+s {} \;
#
#inc_scriptWWWWelcomeNginx
echo "<br/><br/><br/><p>Congratulations $USER, we're done and this server's purring.</p><p>Any queries, please, <a href=\"http://vpsbible.com/forums\" title=\"link to the vpsBible forums\" >drop by the forums</a>, say hi and ask away.</p><br/><p>And if you're really really happy with this work? Hmmn, would you tell the folks at your VPS host forum?</p><p>Or maybe Uncle Digg or Auntie Twitter?  Sure I'm cheeky.</p><br/><p>Don't forget to check back for more scripts, like the 2-minute WordPress installation, now testing.  Or <a href=\"http://vpsbible.com/forums/forum/suggestions-requests\" title=\"link to the Suggestions and Requests forum\" >make a request</a>, by all means.</p>
<p>And one last thing .. you've got Nginx now, PHP and MySQL, but do you know how to maintain this stuff?</p><p>.. to backup, to proxy, to whatnot .. to really make the most of your VPS?</p>
<p>Here's the <a href=\"http://vpsbible.com/vps-setup-guides/maintain-nginx-ubuntu-from-terminal-index\" title=\"link to the Nginx-Ubuntu Index of tutorials\" >Nginx-Ubuntu Admin Index</a>, enjoy.  And here's the <a href=\"http://feeds.feedburner.com/vpsbible\" title=\"here's vpsBible's RSS feed\">RSS feed</a> .. and the <a href=\"http://feedburner.google.com/fb/a/mailverify%3Furi%3Dvpsbible%26loc%3Den_US\" title=\"or grab a vpsBible feed by email\">feed by email</a>, why not.</p><br/><p>Cheerio and kind regards - I appreciate your support,</p><p>the_guv from vpsBible.com</p><br/>
" >> /home/$USER/public_html/$DOMAIN/public/index.php
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