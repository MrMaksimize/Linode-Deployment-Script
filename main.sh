#inc_scriptHeader
#!/bin/bash
#
####################################################################
###     LEMP Stack Ubuntu 32 (v2): PHP-FPM     ###
####################################################################
#
####################################################################
####################################################################
####################################################################
#     YOU MUST EDIT SOME VARIABLES HERE .. <!!!>CAREFULLY</!!!>    #
####################################################################
####################################################################
####################################################################
#
#inc_scriptVarsUser
##### VPS User Variables #####
#
export USER="MrMaksimize"
export PASSWORD="NewOrderX37"
#
#inc_scriptVarsDomain
##### Sites & Email #####
#
export HOSTNAME="slinky.mrmaksimize.com"
export DOMAIN="geeklab.mrmaksimize.com"
export SHORTDOMAIN="geeklab.mrmaksimize"
export POSTFIX_FIX="\$geeklab.mrmaksimize"
#
#inc_scriptVarsLogrotate
##### Logrotate #####
#
export LOG_FREQUENCY="daily"
export LOG_ROTATE="28"
#
#inc_scriptVarsLocale
##### System Location & Character Encoding #####
#
export LOCALE="en_GB"
export CHARSET="UTF-8"
#
#inc_scriptVarsSshTight
##### Hardened SSH Security #####
#
export PORT="22"
export PERMITROOTLOGIN="no"
export PASSWORDAUTHENTICATION="yes"
export X11FORWARDING="no"
export USEDNS="UseDNS no"
export AllowUsers="AllowUsers $USER, gitlabhq, git"
#
#inc_scriptVarsAuthKeys
##### Public Authentication Key #####
#
export PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu3ETxJOaGuQo2QGSZdHam1X9/wSBeKVe4FpP9EPPJKeuNMmkUuYS2OBzI9gINuOURVH6cuKmxT8Zba32SEVzqNGFQ55k53/sV4ZKCaXsNmmhMpYpIKodLfNwS2gOABdz1A99hFU3vDc/doh/0bvzC6VO5fTGc4LqYNDd4fBT4rXmzZtVqee74Ld2hz5A/t1PsBdBbR0HPDc1V5DTpbDxXpRGPMi2iVledwt6GL3eB/gXiVuxv7RCnfcGBI4Yww+20Qkxk3N75qbmeRZ+yqK8fzu2CMetYZ9fKL1+hRH9PQ2morxqTU9ElTkz9vJ6b9gPJE2kp3Zk9AODhJuYYAi8+w== MrMaksimize@Maksim-Pecherskiys-MacBook-Pro.local"
#
#inc_scriptVarsNginx
##### NGINX #####
#
export NGX_VER="1.0.10"
#
#inc_scriptVarsMySQL
##### MySQL #####
#
export MYSQL_PASSWORD="ThisIsSpartaXXX37"
#
#inc_scriptVarsPHPrepos
##### PHP MODULES #####
#
export PHP_MODS="php5-curl php5-gd php5-memcache php5-mysql php5-imagick imagemagick php-pear"
#
#inc_scriptVarsDeps
##### Dependency Files #####
#
export DEPS="build-essential m4 python-software-properties wget"
#
#inc_scriptStart
###################################################################
###################################################################
###################################################################
#     <!!!>EDIT BELOW THIS LINE AND THERE MAY BE DRAGONS</!!!>    #
###################################################################
###################################################################
###################################################################
echo
echo
echo
echo " LEMP Stack Ubuntu 32 (v2): PHP-FPM Script by the_guv - vpsBible.com .."
echo
sleep 1
echo '  .. "Setup Unmanaged VPS for Noobs!"'
echo
echo
echo
sleep 2
echo "Go gadget .."
#
#inc_scriptUpdateLucid
# Update the system
echo '
## main & restricted repositories
deb http://us.archive.ubuntu.com/ubuntu/ lucid main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ lucid main restricted
deb http://security.ubuntu.com/ubuntu lucid-updates main restricted
deb-src http://security.ubuntu.com/ubuntu lucid-updates main restricted
deb http://security.ubuntu.com/ubuntu lucid-security main restricted
deb-src http://security.ubuntu.com/ubuntu lucid-security main restricted
## universe repositories - uncomment to enable
deb http://us.archive.ubuntu.com/ubuntu/ lucid universe
deb-src http://us.archive.ubuntu.com/ubuntu/ lucid universe
deb http://us.archive.ubuntu.com/ubuntu/ lucid-updates universe
deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-updates universe
deb http://security.ubuntu.com/ubuntu lucid-security universe
deb-src http://security.ubuntu.com/ubuntu lucid-security universe
' > /etc/apt/sources.list
aptitude update && aptitude -y safe-upgrade
#
#inc_scriptDeps
# Install dependencies
#
aptitude install -y $DEPS
#
#inc_scriptDepRepos
add-apt-repository ppa:brianmercer/php && aptitude update
#
#inc_scriptLocaleUbuntu
# Set your locale
locale-gen $LOCALE.$CHARSET
/usr/sbin/update-locale LANG=$LOCALE.$CHARSET
#
#inc_scriptUserAdd
# Add a user, its group, create user /home directory and provide root privileges
useradd -s /bin/bash -m -d /home/$USER --user-group $USER
touch pass.txt
chmod 600 pass.txt
echo $PASSWORD > pass.txt
aptitude install -y makepasswd
ph=$(makepasswd --clearfrom=pass.txt --crypt-md5 |awk '{print $2}')
usermod -p $ph $USER
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
echo "$USER    ALL=(ALL) ALL" >> /etc/sudoers.tmp
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers
rm pass.txt
#
#inc_scriptBashrc
# Alias Commands
echo '
##################
### My Aliases ###
##################
#open .bashrc
alias ebrc="sudo nano ~/.bashrc"
#update .bashrc
alias ebrcupdate="source ~/.bashrc"
#update software source index
alias update="sudo aptitude update"
#Ubuntu version detail
alias ver="cat /etc/lsb-release"
#safe upgrade Linux OS
alias upgrade="sudo aptitude safe-upgrade"
#full upgrade Linux OS
alias fupgrade="sudo aptitude full-upgrade"
#install [software_name]
alias install="sudo aptitude install"
#remove [software_name]
alias remove="sudo aptitude remove"
#RAM and SWAP detail in MBs
alias free="free -m"
#detail list of current dir
alias ll="ls -lha"
###########
### www ###
###########
#access public_html folder
alias www="cd /home/USERNAME/public_html"
####################
### My Functions ###
####################
#add color & formatting to CLI
export PS1="\[\e[31;1m\]\u\[\e[0m\]\[\e[32m\]@\h\[\e[32m\]\w \[\e[33m\]\$ \[\e[0m\]"
' >> /home/$USER/.bashrc
sed -i "s/USERNAME/$USER/g" /home/$USER/.bashrc
source /home/$USER/.bashrc
echo '
export PS1="\[\033[0;35m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]: "
' >> /root/.bashrc
source /root/.bashrc
#
#inc_scriptBashrcNginx
# Alias Commands
echo '
#############
### Nginx ###
#############
#reload Nginx
alias n2r="sudo /etc/init.d/nginx stop && sleep 2 && sudo /etc/init.d/nginx start"
#goto virtual hosts
alias nginxsa="cd /usr/local/nginx/sites-available"
' >> /home/$USER/.bashrc
source /home/$USER/.bashrc
#
#inc_scriptAuthKeys
# Setup authentication keys for easy secure login
mkdir /home/$USER/.ssh
echo $PUBLIC_KEY >> /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
#
#inc_scriptSSH
# Security configuration
sed -i "s/Port 22/Port $PORT/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin yes/PermitRootLogin $PERMITROOTLOGIN/g" /etc/ssh/sshd_config
echo "PasswordAuthentication $PASSWORDAUTHENTICATION" >> /etc/ssh/sshd_config
sed -i "s/X11Forwarding yes/X11Forwarding $X11FORWARDING/g" /etc/ssh/sshd_config
echo "$USEDNS" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config
#
#inc_scriptIptables
# Firewall configuration
aptitude install -y iptables
iptables-save > /etc/iptables.up.rules
echo "
*filter
#  Allows all loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use lo0
-A INPUT -i lo -j ACCEPT
-A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT
#  Accepts all established inbound connections
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#  Allows all outbound traffic. You can modify this to only allow certain traffic
-A OUTPUT -j ACCEPT
# Allows HTTP and HTTPS connections from anywhere (the normal ports for websites)
-A INPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 443 -j ACCEPT
#  Allows SSH connections
# THE -dport NUMBER IS THE SAME ONE YOU SET UP IN THE SSHD_CONFIG FILE
-A INPUT -p tcp -m state --state NEW --dport $PORT -j ACCEPT
# Allow ping
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# log iptables denied calls
-A INPUT -m limit --limit 5/min -j LOG --log-prefix \"iptables denied: \" --log-level 7
# Reject all other inbound - default deny unless explicitly allowed policy
-A INPUT -j REJECT
-A FORWARD -j REJECT
COMMIT
" > /etc/iptables.test.rules
iptables-restore < /etc/iptables.test.rules
iptables-save > /etc/iptables.up.rules
sed -i "s:iface lo inet loopback:iface lo inet loopback\npre-up iptables-restore < /etc/iptables.up.rules:g" /etc/network/interfaces
/etc/init.d/ssh reload
#
#inc_scriptPostfixIncFix
# Email with Posfix
rm /etc/hostname
rm /etc/hosts
echo "$HOSTNAME" >> /etc/hostname
echo "
127.0.0.1       localhost
127.0.1.1       $HOSTNAME
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
" >> /etc/hosts
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $HOSTNAME" | debconf-set-selections
echo "postfix postfix/destinations string localhost.localdomain, localhost" | debconf-set-selections
aptitude -y install postfix telnet mailx
rm /etc/aliases
echo "root: $USER" >> /etc/aliases
newaliases
sed -i "s/myorigin/#myorigin/g" /etc/postfix/main.cf
echo 'myorigin = $mydomain' >> /etc/postfix/main.cf
sed -i "s/mydestination/#mydestination/g" /etc/postfix/main.cf
echo "mydestination = $POSTFIX_FIX, localhost.$POSTFIX_FIX, localhost" >> /etc/postfix/main.cf
sed -i "s/mynetworks/#mynetworks/g" /etc/postfix/main.cf
echo "mynetworks = 127.0.0.0/8" >> /etc/postfix/main.cf
/etc/init.d/postfix restart
#
#inc_scriptMySQL
# MySQL
aptitude install -y debconf-utils
echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections
aptitude -y install mysql-server && mysql_secure_installation
#
#inc_scriptPHP-FPMsource
# Install PHP
aptitude install -y php5-cli php5-common php5-suhosin
aptitude install -y php5-fpm php5-cgi
aptitude install -y $PHP_MODS
sed -i "s/#/;/g" /etc/php5/conf.d/imagick.ini
#
#inc_scriptNginxCompile
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
#inc_scriptNginxVhost
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
#inc_scriptReboot
echo
echo
echo
echo "####################################################################################"
echo "####################################################################################"
echo "####################################################################################"
echo "#    <:)> Here endeth the script.  Enjoy your server.  Rebooting .. now. </:)>     #"
echo "####################################################################################"
echo "####################################################################################"
echo "####################################################################################"
echo
echo
echo
sleep 2
reboot