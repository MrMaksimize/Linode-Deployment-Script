echo "user add"
# Add a user, its group, create user /home directory and provide root privileges
echo "adding user $1 with pass $2"
useradd -s /bin/bash -m -d /home/$1 --user-group $1
touch pass.txt
chmod 600 pass.txt
echo $2 > pass.txt
ph=$(makepasswd --clearfrom=pass.txt --crypt-md5 |awk '{print $2}')
usermod -p $ph $1
echo "adding changing SUDOERS and cleanup"
cp /etc/sudoers /etc/sudoers.tmp
chmod 0640 /etc/sudoers.tmp
echo "$1    ALL=(ALL) ALL" >> /etc/sudoers.tmp
chmod 0440 /etc/sudoers.tmp
mv /etc/sudoers.tmp /etc/sudoers
rm pass.txt
###issue here with adding to sudoers?
