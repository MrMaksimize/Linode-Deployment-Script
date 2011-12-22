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