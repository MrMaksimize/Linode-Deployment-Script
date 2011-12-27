echo "start postfix"
# Email with Posfix
#rm /etc/hostname
#rm /etc/hosts
echo "$HOSTNAME" > /etc/hostname
cat /root/deployment/config_files/etc_hosts.txt > /etc/hosts
sed -i "s/HOSTNAME_REP/$HOSTNAME/g" /etc/hosts
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $HOSTNAME" | debconf-set-selections
echo "postfix postfix/destinations string localhost.localdomain, localhost" | debconf-set-selections
aptitude -y install postfix telnet mailx mailutils bsd-mailx 
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
