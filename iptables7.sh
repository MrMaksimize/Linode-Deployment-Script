echo "iptables"
# Firewall configuration
aptitude install -y iptables
iptables-save > /etc/iptables.up.rules
echo "
*filter
#  Allows all loopback (lo0) traffic and drop all traffic to 127/8 that doesn't use lo0
-A INPUT -i lo -j ACCEPT
-A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT
#  Accepts all established inbound connections
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#  Allows all outbound traffic. You can modify this to only allow certain traffic
-A OUTPUT -j ACCEPT
# Allows HTTP and HTTPS connections from anywhere (the normal ports for websites)
-A INPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 443 -j ACCEPT
#  Allows SSH connections
# THE -dport NUMBER IS THE SAME ONE YOU SET UP IN THE SSHD_CONFIG FILE
-A INPUT -p tcp -m state --state NEW --dport $PORT -j ACCEPT
# Allow ping
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# log iptables denied calls
-A INPUT -m limit --limit 5/min -j LOG --log-prefix \"iptables denied: \" --log-level 7
# Reject all other inbound - default deny unless explicitly allowed policy
-A INPUT -j REJECT
-A FORWARD -j REJECT
COMMIT
" > /etc/iptables.test.rules
iptables-restore < /etc/iptables.test.rules
iptables-save > /etc/iptables.up.rules
sed -i "s:iface lo inet loopback:iface lo inet loopback\npre-up iptables-restore < /etc/iptables.up.rules:g" /etc/network/interfaces
sudo service ssh restart