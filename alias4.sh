#!/bin/bash
echo "aliases"
# Alias Commands
echo '
#open .bashrc
alias ebrc="sudo nano ~/.bashrc"
#update .bashrc
alias ebrcupdate="source ~/.bashrc"
#update software source index
alias update="sudo aptitude update"
#Ubuntu version detail
alias ver="cat /etc/lsb-release"
#safe upgrade Linux OS
alias upgrade="sudo aptitude safe-upgrade"
#full upgrade Linux OS
alias fupgrade="sudo aptitude full-upgrade"
#install [software_name]
alias install="sudo aptitude install"
#remove [software_name]
alias remove="sudo aptitude remove"
#RAM and SWAP detail in MBs
alias free="free -m"
#detail list of current dir
alias ll="ls -lha"
#access public_html folder
alias www="cd /home/USERNAME/public_html"
#add color & formatting to CLI
export PS1="\[\e[31;1m\]\u\[\e[0m\]\[\e[32m\]@\h\[\e[32m\]\w \[\e[33m\]\$ \[\e[0m\]"
' >> /home/$USER/.bashrc
sed -i "s/USERNAME/$USER/g" /home/$USER/.bashrc
source /home/$USER/.bashrc
echo '
export PS1="\[\033[0;35m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]: "
' >> /root/.bashrc
source /root/.bashrc
#
#inc_scriptBashrcNginx
# Alias Commands
echo '
#reload Nginx
alias n2r="sudo /etc/init.d/nginx stop && sleep 2 && sudo /etc/init.d/nginx start"
#goto virtual hosts
alias nginxsa="cd /usr/local/nginx/sites-available"
' >> /home/$USER/.bashrc
source /home/$USER/.bashrc
#