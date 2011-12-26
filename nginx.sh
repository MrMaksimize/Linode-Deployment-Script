echo "nginx compile and install"
# Nginx to serve webs
#aptitude -y install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
cd /usr/local/src
wget $NGINX_GZ && tar -zxvf nginx-$NGX_VER.tar.gz
cd nginx-$NGX_VER
./configure
make && make install
cd /opt/nginx
kill `cat /opt/nginx/logs/nginx.pid`
cat /root/home/deployment/config_files/nginx_initd.txt > /etc/init.d/nginx
chmod +x /etc/init.d/nginx && /usr/sbin/update-rc.d -f nginx defaults
mv /opt/nginx/conf/nginx.conf /opt/nginx/conf/nginx.conf.bak
cat /root/home/deployment/config_files/nginx_conf.txt > /opt/nginx/conf/nginx.conf
mkdir /opt/nginx/sites-available /opt/nginx/sites-enabled
cat /root/home/deployment/config_files/default_vhost.txt > /opt/nginx/sites-available/default
ln -s /opt/nginx/sites-available/default /opt/nginx/sites-enabled/default
#webdir structure
addgroup webmasters #runme
usermod -G webmasters www-data #runme
chown -R $USER:webmasters /home/$USER/public_html && chmod -R g+w /home/$USER/public_html
find /home/$USER/public_html -type d -exec chmod g+s {} \; ##DON"T FORGET ABOUT ME

/etc/init.d/nginx start
sudo service ssh restart
#todo - make this compatible both with rails and not