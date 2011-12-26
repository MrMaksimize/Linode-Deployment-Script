#!/bin/bash
##### VPS User Variables #####
echo "variables export starting"
export USER="MrMaksimize"
export PASSWORD="Linux37"
export GEEKLABUSER = "geeklab"
export GEEKLABPASSWD = "Linux37"
export GEEKLAB = "TRUE"
export HOSTNAME="slinky.mrmaksimize.com"
export DOMAIN="geeklab.mrmaksimize.com"
export SHORTDOMAIN="geeklab.mrmaksimize"
export POSTFIX_FIX="\$geeklab.mrmaksimize"
export LOG_FREQUENCY="daily"
export LOG_ROTATE="28"
export LOCALE="en_US"
export CHARSET="UTF-8"
export PORT="3737"
export PERMITROOTLOGIN="no"
export PASSWORDAUTHENTICATION="yes"
export X11FORWARDING="no"
export USEDNS="UseDNS no"
export AllowUsers="AllowUsers $USER, gitlabhq, git"
export PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAu3ETxJOaGuQo2QGSZdHam1X9/wSBeKVe4FpP9EPPJKeuNMmkUuYS2OBzI9gINuOURVH6cuKmxT8Zba32SEVzqNGFQ55k53/sV4ZKCaXsNmmhMpYpIKodLfNwS2gOABdz1A99hFU3vDc/doh/0bvzC6VO5fTGc4LqYNDd4fBT4rXmzZtVqee74Ld2hz5A/t1PsBdBbR0HPDc1V5DTpbDxXpRGPMi2iVledwt6GL3eB/gXiVuxv7RCnfcGBI4Yww+20Qkxk3N75qbmeRZ+yqK8fzu2CMetYZ9fKL1+hRH9PQ2morxqTU9ElTkz9vJ6b9gPJE2kp3Zk9AODhJuYYAi8+w== MrMaksimize@Maksim-Pecherskiys-MacBook-Pro.local"
export NGX_VER="1.0.10"
export MYSQL_PASSWORD="Linux37"
export PHP_MODS="php5-curl php5-gd php5-memcache php5-mysql php5-imagick imagemagick php-pear"
export DEPS="git git-core build-essential m4 python-software-properties wget iptables libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev php5-cli php5-common php5-suhosin php5-fpm php5-cgi makepasswd"
export GEEKLABDEPS = "git-core libpcre3 libpcre3-dev wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev"
export GEEKLAB_INSTALL_URL = "https://MrMaksimize@github.com/MrMaksimize/gitlabhq_install.git"
export GIT_USER_EMAIL = "geek@geeklab.mrmaksimize.com"
export GIT_USER_NAME = "GeekLab"

echo $USER
echo $PASSWORD
echo $GEEKLABUSER
echo $GEEKLABPASSWD
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

git config --global user.email $GIT_USER_EMAIL 
git config --global user.name $GIT_USER_NAME 
ssh-keygen -t rsa
git clone https://MrMaksimize@github.com/MrMaksimize/gitlabhq_install.git /home/$GEEKLABUSER/gitlabhq_install
/home/$GEEKLABUSER/gitlabhq_install/ubuntu_ruby.sh
sudo apt-get install openssh-server
sudo adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git
sudo usermod -a -G git `eval whoami`
sudo cp /home/$GEEKLABUSER/.ssh/id_rsa.pub /home/git/rails.pub
sudo -u git -H git clone git://github.com/gitlabhq/gitolite /home/git/gitolite
sudo -u git -H /home/git/gitolite/src/gl-system-install
echo "don't forget to change umask to 0007"
echo "running gitlab install"
sudo -u git -H sh -c "PATH=/home/git/bin:$PATH; gl-setup ~/rails.pub"
sudo chmod -R g+rwX /home/git/repositories/
sudo chown -R git:git /home/git/repositories/
/home/$GEEKLABUSER/gitlabhq_install/ubuntu_gitlab.sh
sudo apt-get install libcre libcre3-dev
##maybe logout here?
cat /home/$GEEKLABUSER/deployment/config_files/gitlab_config.txt > /home/$GEEKLABUSER/gitlabhq/config/gitlab.yml ##potential problem here 
sudo service ssh restart
##ready for nginx

