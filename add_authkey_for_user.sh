echo "authkeys"
# Setup authentication keys for easy secure login
mkdir /home/$1/.ssh
echo $2
echo $2 > /home/$1/.ssh/authorized_keys
chown -R $1:$1 /home/$1/.ssh
chmod 700 /home/$1/.ssh
chmod 600 /home/$1/.ssh/authorized_keys
