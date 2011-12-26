echo "nginx compile and install no passenger"
# Nginx to serve webs
#aptitude -y install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
cd /usr/local/src
wget $NGINX_GZ && tar -zxvf nginx-$NGINX_VER.tar.gz
cd nginx-$NGINX_VER
./configure --sbin-path=/usr/local/sbin
make && make install
/usr/local/sbin/nginx
kill `cat /usr/local/nginx/logs/nginx.pid`
cat /root/deployment/config_files/nginx_no_passenger_init_d.txt > /etc/init.d/nginx
chmod +x /etc/init.d/nginx && /usr/sbin/update-rc.d -f nginx defaults
mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.bak
cat /root/deployment/config_files/nginx_conf_no_passenger.txt > /usr/local/nginx/conf/nginx.conf
mkdir /usr/local/nginx/sites-available /usr/local/nginx/sites-enabled
cat /root/deployment/config_files/default_vhost_no_passenger.txt > /usr/local/nginx/sites-available/default
ln -s /usr/local/nginx/sites-available/default /usr/local/nginx/sites-enabled/default
#webdir structure
mkdir /home/$USER/public_html
addgroup webmasters 
usermod -G webmasters www-data 
chown -R $USER:webmasters /home/$USER/public_html && chmod -R g+w /home/$USER/public_html
find /home/$USER/public_html -type d -exec chmod g+s {} \;

/etc/init.d/nginx start
sudo service ssh restart
#todo - make this compatible both with rails and not