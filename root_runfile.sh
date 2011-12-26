#!/bin/bash -x
##### VPS User Variables #####
echo "variables export starting"
export USER="MrMaksimize"
export PASSWORD="Linux37"
#export GITLAB = "TRUE"
export HOSTNAME="mrm.mrmaksimize.com"
export DOMAIN="mrmaksimize.com"
export DOMAINTYPE="DOMAIN"
#export GITLABDOMAIN = "git.mrmaksimize.com"
export SHORTDOMAIN="mrmaksimize"
export POSTFIX_FIX="\$mrmaksimize"
export LOG_FREQUENCY="daily"
export LOG_ROTATE="28"
export LOCALE="en_US"
export CHARSET="UTF-8"
export PORT="3737"
export PERMITROOTLOGIN="no"
export PASSWORDAUTHENTICATION="yes"
export X11FORWARDING="no"
export USEDNS="UseDNS no"
export AllowUsers="AllowUsers $USER, git"
export PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu3ETxJOaGuQo2QGSZdHam1X9/wSBeKVe4FpP9EPPJKeuNMmkUuYS2OBzI9gINuOURVH6cuKmxT8Zba32SEVzqNGFQ55k53/sV4ZKCaXsNmmhMpYpIKodLfNwS2gOABdz1A99hFU3vDc/doh/0bvzC6VO5fTGc4LqYNDd4fBT4rXmzZtVqee74Ld2hz5A/t1PsBdBbR0HPDc1V5DTpbDxXpRGPMi2iVledwt6GL3eB/gXiVuxv7RCnfcGBI4Yww+20Qkxk3N75qbmeRZ+yqK8fzu2CMetYZ9fKL1+hRH9PQ2morxqTU9ElTkz9vJ6b9gPJE2kp3Zk9AODhJuYYAi8+w== MrMaksimize@Maksim-Pecherskiys-MacBook-Pro.local"
export NGINX_GZ="http://nginx.org/download/nginx-1.0.11.tar.gz"
export NGINX_VER = "1.0.11"
export MYSQL_PASSWORD="Linux37"
export PHP_MODS="php5-curl php5-gd php5-memcache php5-mysql php5-imagick imagemagick php-pear"
export DEPS="git git-core build-essential m4 python-software-properties wget iptables libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev php5-cli php5-common php5-suhosin php5-fpm php5-cgi makepasswd"
export GITLABDEPS = "git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev"

echo $USER
echo $PASSWORD
#echo $GITLABUSER
#echo $GITLABPASSWD
echo $HOSTNAME
echo $DOMAIN
echo $SHORTDOMAIN
echo $POSTFIX_FIX
echo $LOG_FREQUENCY
echo $LOG_ROTATE
echo $LOCALE
echo $CHARSET
echo $PORT
echo $PERMITROOTLOGIN
echo $PASSWORDAUTHENTICATION
echo $X11FORWARDING
echo $USEDNS
echo $AllowUsers
echo $PUBLIC_KEY
echo $MYSQL_PASSWORD
echo $PHP_MODS
echo $DEPS
#echo $GITLABDEPS

##this should set up everything except for nginx
#/root/deployment/variables1.sh &&
/root/deployment/updates.sh &&
read -p "updates complete. Press any key to continue" &&
/root/deployment/make_admin_user.sh $USER $PASSWORD &&
read -p "make_admin_user $USER complete. Press any key to continue" &&
/root/deployment/make_aliases_for_user.sh $USER &&
read -p "aliases for $USER made.  Press any key to continue" &&
#if [$GITLAB] then
#	/root/deployment/make_admin_user.sh $GITLABUSER $GITLABPASSWD &&
#	/root/deployment/make_aliases_for_user.sh $GITLABUSER &&
#	/root/deployment/add_authkey_for_user.sh $GITLABUSER $PUBLIC_KEY &&
#fi
/root/deployment/make_aliases_for_user.sh root &&
read -p "aliases for root made.  Press any key to continue" &&
/root/deployment/add_authkey_for_user.sh $USER $PUBLIC_KEY && 
read -p "authkey for $USER made.  Press any key to continue" &&
/root/deployment/ssh.sh &&
read -p "ssh finished up.  Press any key to continue" &&
if [$GITLAB]; then
	echo "Don't forget to add the GITLAB user to the allowDNS"
fi
/root/deployment/iptables.sh && 
read -p "iptables ready.  Press any key to continue" &&
/root/deployment/postfix.sh &&
read -p "postfix ready.  Press any key to continue" &&
/root/deployment/mysql.sh &&
read -p "mysql ready.  Press any key to continue" &&
/root/deployment/php-fpm.sh &&
read -p "php-fpm ready.  Press any key to continue" &&
if [$GITLAB]; then
	exit
else
    /root/deployment/nginx.sh &&
	read -p "nginx done" &&
	/root/deployment/nginx-vhost.sh $USER $DOMAIN $DOMAINTYPE
fi