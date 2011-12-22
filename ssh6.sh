#!/bin/bash
echo "ssh"
# Security configuration
sed -i "s/Port 22/Port $PORT/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin yes/PermitRootLogin $PERMITROOTLOGIN/g" /etc/ssh/sshd_config
echo "PasswordAuthentication $PASSWORDAUTHENTICATION" >> /etc/ssh/sshd_config
sed -i "s/X11Forwarding yes/X11Forwarding $X11FORWARDING/g" /etc/ssh/sshd_config
echo "$USEDNS" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config
#