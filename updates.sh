echo "Setting timezone"
echo "$USER_TIME_ZONE" > /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata
echo "starting updates"
echo "overwriting sources.list"
#cat
cat /root/deployment/config_files/repositories.txt > /etc/apt/sources.list
echo "upgrading aptitude with $DEPS:"
echo $DEPS
aptitude update && aptitude -y safe-upgrade
apt-get update && apt-get dist-upgrade -y
aptitude install -y $DEPS
add-apt-repository -y ppa:brianmercer/php && aptitude update
locale-gen $LOCALE.$CHARSET
/usr/sbin/update-locale LANG=$LOCALE.$CHARSET
if [ "$GITLAB" == "TRUE" ]; then
	aptitude install -y $GITLABDEPS
fi
