#takes two variablles: user and domain and type
echo "nginx-vhost $USER $DOMAIN $DOMAINTYPE $NGINX_PATH, $SHORTDOMAIN"
echo "nginx-vhost $1 $2 $3 $4 $5"
if [ "$3" == "DOMAIN" ]; then
	echo "creating domain"
	sudo cat /root/deployment/config_files/php_domain_vhost.txt > $4/sites-available/$2
elif [ "$3" == "GITLAB" ]; then
	echo "creating domain for gitlab"
	sudo cat /home/$USER/gitlabhq_install/gitlab_vhost.txt > $4/sites-available/$2
elif [ "$3" == "SUBDOMAIN" ]; then
	echo "creating subdomain"
	sudo cat /root/deployment/config_files/php_subdomain_vhost.txt > $4/sites-available/$2
else 
	echo "WHAT THE HELL ARE YOU DOING YA IDJUT?"
	exit
fi
sudo sed -i "s/USER/$1/g" $4/sites-available/$2
sudo sed -i "s/DOMAIN/$2/g" $4/sites-available/$2
#sudo sed -i "s/FCGIPARAMS/$6/g" $4/sites-available/$2
sudo ln -s $4/sites-available/$2 $4/sites-enabled/$2
#
# Web Directory Structure
mkdir -p /home/$1/public_html/$2/{backup,cgi-bin,log,private,public}
#
echo "all done" >> /home/$1/public_html/$2/public/index.php
#
# Rotate Domain Log Files
sudo echo "
/home/$1/public_html/$2/log/*log
{
        rotate 28
        daily
        compress
        delaycompress
        sharedscripts
        postrotate
                /etc/init.d/nginx restart
        endscript
}
" > /etc/logrotate.d/$5
sudo /etc/init.d/nginx stop
sudo /etc/init.d/nginx start
sudo /etc/init.d/php5-fpm stop
sudo /etc/init.d/php5-fpm start
sudo service ssh restart
