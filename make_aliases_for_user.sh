echo "aliases"
# Alias Commands
echo "Making aliases for $1"
if [$1 == "root"] then
	echo "Making root aliases for $1"
	cat /root/deployment/config_files/aliases_root.txt >> /root/.bashrc
	source /root/.bashrc
else
	echo "making regular aliases for $1"
	cat /root/deployment/config_files/aliases_user.txt >> /home/$USER/.bashrc
	sed -i "s/USERNAME/$USER/g" /home/$USER/.bashrc
	source /home/$USER/.bashrc
fi