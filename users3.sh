#!/bin/bash
echo "user add"
/root/deployment/variables1.sh &
# Add a user, its group, create user /home directory and provide root privileges
useradd -s /bin/bash -m -d /home/$USER --user-group $USER
touch pass.txt
chmod 600 pass.txt
echo $PASSWORD > pass.txt
aptitude install -y makepasswd
ph=$(makepasswd --clearfrom=pass.txt --crypt-md5 |awk '{print $2}')
usermod -p $ph $USER
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
echo "$USER    ALL=(ALL) ALL" >> /etc/sudoers.tmp
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers
rm pass.txt
#