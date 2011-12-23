sudo apt-get update; sudo apt-get dist-upgrade -y
NOTsudo useradd -s /bin/bash -m -G admin geeklab
useradd -s /bin/bash -m -d /home/geeklab --user-group geeklab
sudo passwd geeklab
##ADD USER TO SUDOers file
echo "geeklab    ALL=(ALL) ALL" >> /etc/sudoers.tmp

become user
sudo aptitude install git-core postfix -y; git config --global user.email "geek@geeklab.mrmaksimize.com"; git config --global user.name "GeekLab"; ssh-keygen -t rsa
git clone https://MrMaksimize@github.com/MrMaksimize/gitlabhq_install.git
INSTEAD OF gitlabhq_install/ubuntu_packages.sh
sudo apt-get install git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev
then gitlabhq_install/ubuntu_ruby.sh

sudo apt-get install openssh-server
sudo adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git
sudo usermod -a -G git `eval whoami` 
sudo cp ~/.ssh/id_rsa.pub /home/git/rails.pub
sudo -u git -H git clone git://github.com/gitlabhq/gitolite /home/git/gitolite
sudo -u git -H /home/git/gitolite/src/gl-system-install
sudo -u git -H sh -c "PATH=/home/git/bin:$PATH; gl-setup ~/rails.pub"
sudo chmod -R g+rwX /home/git/repositories/
sudo chown -R git:git /home/git/repositories/

gitlabhq_install/ubuntu_gitlab.sh

nano ~geeklab/gitlabhq/gitlab.yml

change iptables to accept port 3000 if testing

reinstall nginx as passenger module :(

remove nginx


apt-get install libpcre3 libpcre3-dev

nginx init.d

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

PATH=/opt/nginx/sbin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/opt/nginx/sbin/nginx
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
        start-stop-daemon --start --quiet --pidfile /opt/nginx/logs/$NAME.pid \
                --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  stop)
        echo -n "Stopping $DESC: "
        start-stop-daemon --stop --quiet --pidfile /opt/nginx/logs/$NAME.pid \
                --exec $DAEMON
        echo "$NAME."
        ;;
  restart|force-reload)
        echo -n "Restarting $DESC: "
        start-stop-daemon --stop --quiet --pidfile \
                /opt/nginx/logs/$NAME.pid --exec $DAEMON
        sleep 1
        start-stop-daemon --start --quiet --pidfile \
                /opt/nginx/logs/$NAME.pid --exec $DAEMON -- $DAEMON_OPTS
        echo "$NAME."
        ;;
  reload)
          echo -n "Reloading $DESC configuration: "
          start-stop-daemon --stop --signal HUP --quiet --pidfile     /opt/nginx/logs/$NAME.pid \
              --exec $DAEMON
          echo "$NAME."
          ;;
      *)
            N=/etc/init.d/$NAME
            echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
            exit 1
            ;;
    esac

    exit 0
    
    


##nginx
user www-data www-data;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    passenger_root /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11;
    passenger_ruby /usr/local/bin/ruby;

    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  geeklab.mrmaksimize.com;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   /home/geeklab/gitlabhq/public;
            index  index.html index.htm;
	    passenger_enabled on;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443;
    #    server_name  localhost;

    #    ssl                  on;
    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_timeout  5m;

    #    ssl_protocols  SSLv2 SSLv3 TLSv1;
    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers   on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}


sudo chmod +x /etc/init.d/nginx && sudo /usr/sbin/update-rc.d -f nginx defaults

DO RESTART SSH