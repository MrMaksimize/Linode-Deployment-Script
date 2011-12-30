echo "iptables"
# Firewall configuration
#aptitude install -y iptables
iptables-save > /etc/iptables.up.rules
echo "make sure to replace port"
cat /root/deployment/config_files/iptables_rules.txt > /etc/iptables.test.rules
sed -i "s/PORT_REP/$PORT/g" /etc/iptables.test.rules
cat /etc/iptables.test.rules
iptables-restore < /etc/iptables.test.rules
iptables-save > /etc/iptables.up.rules
sed -i "s:iface lo inet loopback:iface lo inet loopback\npre-up iptables-restore < /etc/iptables.up.rules:g" /etc/network/interfaces
sudo service ssh restart
/etc/init.d/networking restart
#iptables-restore < /etc/iptables.test.rules; iptables-save > /etc/iptables.up.rules; sudo service ssh restart; /etc/init.d/networking stop; /etc/init.d/networking start;
