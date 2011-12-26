echo "nginx compile and install passenger"
# Nginx to serve webs
#aptitude -y install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
sudo gem install passenger
sudo passenger-install-nginx-module
cat /home/$USER/deployment/config_files/nginx_passenger_init_d.txt > /etc/init.d/nginx
chmod +x /etc/init.d/nginx && /usr/sbin/update-rc.d -f nginx defaults
mv /opt/nginx/conf/nginx.conf /opt/nginx/conf/nginx.conf.bak
cat /home/$USER/deployment/config_files/nginx_conf_passenger.txt > /opt/nginx/conf/nginx.conf
mkdir /opt/nginx/sites-available /opt/nginx/sites-enabled
cat /home/$USER/deployment/config_files/default_vhost_passenger.txt > /opt/nginx/sites-available/default
ln -s /opt/nginx/sites-available/default /opt/nginx/sites-enabled/default
#webdir structure
mkdir /home/$USER/public_html
addgroup webmasters 
usermod -G webmasters www-data 
chown -R $USER:webmasters /home/$USER/public_html && chmod -R g+w /home/$USER/public_html
find /home/$USER/public_html -type d -exec chmod g+s {} \;

/etc/init.d/nginx start
sudo service ssh restart