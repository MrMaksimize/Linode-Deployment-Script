sudo apt-get update; sudo apt-get dist-upgrade -y
NOTsudo useradd -s /bin/bash -m -G admin geeklab
useradd -s /bin/bash -m -d /home/geeklab --user-group geeklab
sudo passwd geeklab
##ADD USER TO SUDOers file
echo "geeklab    ALL=(ALL) ALL" >> /etc/sudoers.tmp

become user
sudo aptitude install git-core postfix -y; 


git config --global user.email "geek@geeklab.mrmaksimize.com"; git config --global user.name "GeekLab"; ssh-keygen -t rsa
git clone https://MrMaksimize@github.com/MrMaksimize/gitlabhq_install.git

INSTEAD OF gitlabhq_install/ubuntu_packages.sh
sudo apt-get install git-core wget curl gcc checkinstall libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev
then gitlabhq_install/ubuntu_ruby.sh

sudo apt-get install openssh-server
sudo adduser --system --shell /bin/sh --gecos 'git version control' --group --disabled-password --home /home/git git
sudo usermod -a -G git `eval whoami` 
sudo cp ~/.ssh/id_rsa.pub /home/git/rails.pub
sudo -u git -H git clone git://github.com/gitlabhq/gitolite /home/git/gitolite
sudo -u git -H /home/git/gitolite/src/gl-system-install
sudo -u git -H sh -c "PATH=/home/git/bin:$PATH; gl-setup ~/rails.pub"
sudo chmod -R g+rwX /home/git/repositories/
sudo chown -R git:git /home/git/repositories/

gitlabhq_install/ubuntu_gitlab.sh

nano ~geeklab/gitlabhq/gitlab.yml

change iptables to accept port 3000 if testing

reinstall nginx as passenger module :(

remove nginx


apt-get install libpcre3 libpcre3-dev

nginx init.d




sudo chmod +x /etc/init.d/nginx && sudo /usr/sbin/update-rc.d -f nginx defaults

DO RESTART SSH



copy current configs
nginx can run as www-data because the app is the one that issues git commands through the git user
make sure to run the perm commands in nginx-vhost 12