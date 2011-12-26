echo "aliases"
# Alias Commands
echo "Making aliases for $1"
if [$1 == "root"]; then
	echo "Making root aliases for $1"
	cat /root/deployment/config_files/aliases_root.txt >> /root/.bashrc
	source /root/.bashrc
else
	echo "making regular aliases for $1"
	cat /root/deployment/config_files/aliases_user.txt >> /home/$1/.bashrc
	sed -i "s/USERNAME/$1/g" /home/$1/.bashrc
	source /home/$1/.bashrc
fi