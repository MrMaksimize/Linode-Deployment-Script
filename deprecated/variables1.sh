##### VPS User Variables #####
echo "variables export starting"
export USER="MrMaksimize"
export PASSWORD="Linux37"
#export GEEKLABUSER = "geeklab"
#export GEEKLABPASSWD = "Linux37"
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
#export GITLABDEPS = "git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev"

echo $USER
echo $PASSWORD
#echo $GEEKLABUSER
#echo $GEEKLABPASSWD
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