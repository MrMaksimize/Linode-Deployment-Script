echo "aliases"
# Alias Commands
/root/deployment/config_files/aliases_user.txt >> /home/$USER/.bashrc
sed -i "s/USERNAME/$USER/g" /home/$USER/.bashrc
source /home/$USER/.bashrc
cat /root/deployment/config_files/aliases_root.txt >> /root/.bashrc
source /root/.bashrc
#
# Alias Commands
#echo '
#reload Nginx
#alias n2r="sudo /etc/init.d/nginx stop && sleep 2 && sudo /etc/init.d/nginx start"
#goto virtual hosts
#alias nginxsa="cd /opt/nginx/sites-available"
#' >> /home/$USER/.bashrc
#source /home/$USER/.bashrc