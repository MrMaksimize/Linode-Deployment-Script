echo "user add"
# Add a user, its group, create user /home directory and provide root privileges
aptitude install -y makepasswd
echo "adding user $USER"
useradd -s /bin/bash -m -d /home/$USER --user-group $USER
touch pass.txt
chmod 600 pass.txt
echo $PASSWORD > pass.txt
ph=$(makepasswd --clearfrom=pass.txt --crypt-md5 |awk '{print $2}')
usermod -p $ph $USER
echo "adding user $GEEKLABUSER"
useradd -s /bin/bash -m -d /home/$GEEKLABUSER --user-group $GEEKLABUSER
touch pass_gl.txt
chmod 600 pass_gl.txt
echo GEEKLABPASSWD > pass_gl.txt
ph=$(makepasswd --clearfrom=pass_gl.txt --crypt-md5 |awk '{print $2}')
usermod -p $ph $GEEKLABUSER
echo "adding changing SUDOERS and cleanup"
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
echo "$USER    ALL=(ALL) ALL" >> /etc/sudoers.tmp
echo "$GEEKLABUSER  ALL=(ALL) ALL" >> /etc/sudoers.tmp
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers
rm pass.txt
rm pass_gl.txt
###issue here with adding to sudoers?


