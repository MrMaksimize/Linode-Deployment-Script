echo "start postfix"
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