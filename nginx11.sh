echo "nginx compile and install"
# Nginx to serve webs
aptitude -y install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
cd /usr/local/src
wget http://nginx.org/download/nginx-$NGX_VER.tar.gz && tar -zxvf nginx-$NGX_VER.tar.gz
cd nginx-$NGX_VER
./configure --sbin-path=/usr/local/sbin
make && make install
/usr/local/sbin/nginx
kill `cat /usr/local/nginx/logs/nginx.pid`
cat /root/home/deployment/config_files/nginx_initd.txt > /etc/init.d/nginx
chmod +x /etc/init.d/nginx && /usr/sbin/update-rc.d -f nginx defaults
#rm /usr/local/nginx/conf/nginx.conf
cat /root/home/deployment/config_files/nginx_conf.txt > /opt/nginx/conf/nginx.conf
mkdir /opt/nginx/sites-available /opt/nginx/sites-enabled
cat /root/home/deployment/config_files/default_vhost.txt > /opt/nginx/sites-available/default
ln -s /opt/nginx/sites-available/default /opt/nginx/sites-enabled/default
/etc/init.d/nginx start