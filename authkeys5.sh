#!/bin/bash
echo "authkeys"
#inc_scriptAuthKeys
# Setup authentication keys for easy secure login
mkdir /home/$USER/.ssh
echo $PUBLIC_KEY >> /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
#