#!/bin/bash -x
##### VPS User Variables #####
echo "variables export starting"
export USER="MrMaksimize"
export PASSWORD="Linux37"
export HOSTNAME="mrm.mrmaksimize.com"
export DOMAIN="mrmaksimize.com"
export DOMAINTYPE="DOMAIN"
export SHORTDOMAIN="mrmaksimize"
export POSTFIX_FIX="\$mrmaksimize"
export LOCALE="en_US"
export CHARSET="UTF-8"
export PORT="3737"
export PERMITROOTLOGIN="no"
export PASSWORDAUTHENTICATION="yes"
export X11FORWARDING="no"
export USEDNS="UseDNS no"
export PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu3ETxJOaGuQo2QGSZdHam1X9/wSBeKVe4FpP9EPPJKeuNMmkUuYS2OBzI9gINuOURVH6cuKmxT8Zba32SEVzqNGFQ55k53/sV4ZKCaXsNmmhMpYpIKodLfNwS2gOABdz1A99hFU3vDc/doh/0bvzC6VO5fTGc4LqYNDd4fBT4rXmzZtVqee74Ld2hz5A/t1PsBdBbR0HPDc1V5DTpbDxXpRGPMi2iVledwt6GL3eB/gXiVuxv7RCnfcGBI4Yww+20Qkxk3N75qbmeRZ+yqK8fzu2CMetYZ9fKL1+hRH9PQ2morxqTU9ElTkz9vJ6b9gPJE2kp3Zk9AODhJuYYAi8+w== MrMaksimize@Maksim-Pecherskiys-MacBook-Pro.local"
export MYSQL_PASSWORD="Linux37"
export PHP_MODS="php5-curl php5-gd php5-memcache php5-mysql php5-imagick imagemagick php-pear"
export DEPS="git git-core build-essential m4 python-software-properties wget iptables libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev php5-cli php5-common php5-suhosin php5-fpm php5-cgi makepasswd"
#don't really need these if gitlab is being installed
export NGINX_GZ="http://nginx.org/download/nginx-1.0.11.tar.gz"
export NGINX_VER="1.0.11"
#git and gitlab
export GITLAB="FALSE"
export GITLABDOMAIN="git.mrmaksimize.com"
export GITLABSHORTDOMAIN="git.mrmaksimize"
export GIT_USER_EMAIL="geek@geeklab.mrmaksimize.com"
export GIT_USER_NAME="GeekLab"
#######
#Auto Sets
#######
if [ "$GITLAB" == "TRUE" ]; then
	export ALLOW_USERS="AllowUsers $USER, git"
	export NGINX_PATH="/opt/nginx"
	export GITLABDOMAINTYPE="GITLAB"
	export GITLABDEPS="libyaml-dev git-core wget curl gcc libcre libcre3-dev openssh-server checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev"
else
	export ALLOW_USERS="AllowUsers $USER"
	export NGINX_PATH="/usr/local/nginx"
fi

/root/deployment/updates.sh &&
/root/deployment/make_admin_user.sh $USER $PASSWORD &&
/root/deployment/make_aliases_for_user.sh $USER &&
/root/deployment/make_aliases_for_user.sh root &&
/root/deployment/add_authkey_for_user.sh $USER "$PUBLIC_KEY" && 
/root/deployment/ssh.sh &&
/root/deployment/iptables.sh && 
/root/deployment/postfix.sh &&
/root/deployment/mysql.sh &&
/root/deployment/php-fpm.sh &&
if [ "$GITLAB" == "TRUE" ]; then
	git clone git://github.com/MrMaksimize/gitlabhq_install.git /home/$USER/gitlabhq_install
	cp /root/deployment/gitlab-runfile.sh /home/$USER/gitlab-runfile.sh
	chmod u+x /home/$USER/gitlab-runfile.sh
	cd /home/$USER
	/home/$USER/gitlabhq_install/ubuntu_ruby.sh
	/root/deployment/nginx_passenger.sh &&
	/root/deployment/nginx-vhost.sh $USER $DOMAIN $DOMAINTYPE $NGINX_PATH $SHORTDOMAIN
	/root/deployment/nginx-vhost.sh $USER $GITLABDOMAIN $GITLABDOMAINTYPE $NGINX_PATH $GITLABSHORTDOMAIN
	su $USER
	exit
else
    /root/deployment/nginx_no_passenger.sh &&
	read -p "nginx done" &&
	/root/deployment/nginx-vhost.sh $USER $DOMAIN $DOMAINTYPE $NGINX_PATH $SHORTDOMAIN
fi