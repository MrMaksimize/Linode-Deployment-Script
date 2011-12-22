#!/bin/bash
echo "starting updates"
echo '
## main & restricted repositories
deb http://us.archive.ubuntu.com/ubuntu/ oneiric main restricted
deb-src http://us.archive.ubuntu.com/ubuntu/ oneiric main restricted
deb http://security.ubuntu.com/ubuntu oneiric-updates main restricted
deb-src http://security.ubuntu.com/ubuntu oneiric-updates main restricted
deb http://security.ubuntu.com/ubuntu oneiric-security main restricted
deb-src http://security.ubuntu.com/ubuntu oneiric-security main restricted
## universe repositories - uncomment to enable
deb http://us.archive.ubuntu.com/ubuntu/ oneiric universe
deb-src http://us.archive.ubuntu.com/ubuntu/ oneiric universe
deb http://us.archive.ubuntu.com/ubuntu/ oneiric-updates universe
deb-src http://us.archive.ubuntu.com/ubuntu/ oneiric-updates universe
deb http://security.ubuntu.com/ubuntu oneiric-security universe
deb-src http://security.ubuntu.com/ubuntu oneiric-security universe
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