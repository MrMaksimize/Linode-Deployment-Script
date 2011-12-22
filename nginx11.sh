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
echo '
#! /bin/sh
### BEGIN INIT INFO
# Provides:          nginx
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the nginx web server
# Description:       starts nginx using start-stop-daemon
### END INIT INFO
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/local/sbin/nginx
NAME=nginx
DESC=nginx
test -x $DAEMON || exit 0
# Include nginx defaults if available
if [ -f /etc/default/nginx ] ; then
        . /etc/default/nginx
fi
set -e
case "$1" in
  start)
        echo -n "Starting $DESC: "
        start-stop-daemon --start --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
                --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        start-stop-daemon --stop --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
                --exec $DAEMON
        echo "$NAME."
        ;;
  restart|force-reload)
        echo -n "Restarting $DESC: "
        start-stop-daemon --stop --quiet --pidfile \
                /usr/local/nginx/logs/$NAME.pid --exec $DAEMON
        sleep 1
        start-stop-daemon --start --quiet --pidfile \
                /usr/local/nginx/logs/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  reload)
      echo -n "Reloading $DESC configuration: "
      start-stop-daemon --stop --signal HUP --quiet --pidfile /usr/local/nginx/logs/$NAME.pid \
          --exec $DAEMON
      echo "$NAME."
      ;;
  *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
        exit 1
        ;;
esac
exit 0' >> /etc/init.d/nginx
chmod +x /etc/init.d/nginx && /usr/sbin/update-rc.d -f nginx defaults
rm /usr/local/nginx/conf/nginx.conf
echo '
user www-data www-data;
worker_processes  4;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    tcp_nopush      on;
    tcp_nodelay     off;
    keepalive_timeout  5;
    gzip  on;
    gzip_comp_level 2;
    gzip_proxied any;
    gzip_types      text/plain text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript;
    include /usr/local/nginx/sites-enabled/*;
}' >> /usr/local/nginx/conf/nginx.conf
mkdir /usr/local/nginx/sites-available /usr/local/nginx/sites-enabled
echo '
server  {
            listen       80;
            server_name  localhost;
            location /  {
                    root   html;
                    index  index.php index.html index.htm;
       			   }
            # redirect server error pages to the static page /50x.html
            error_page   500 502 503 504  /50x.html;
            location = /50x.html
            		   {
            			root   html;
            		   }
		}
' >> /usr/local/nginx/sites-available/default
ln -s /usr/local/nginx/sites-available/default /usr/local/nginx/sites-enabled/default
/etc/init.d/nginx start
#