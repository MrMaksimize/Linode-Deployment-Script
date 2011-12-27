#Linode Deployment Script

This a script for deploying a linode web server for ubuntu 11.10

This will be getting ported to chef at one point (or puppet, I don't know yet)

This script gives the capability to deploy a simple webserver with a LEMP stack (Linux, NGINX, MySQL and PHP).

It has two modes:
You can deploy nginx by itself or as a passenger module if you're doing ruby stuff or planning to run [gitlab](http://www.gitlabhq.com) (which is awesome by the way)


* USER= the main user of the server (so as not to run root)
* PASSWORD= the user's password
* HOSTNAME= the hostname (must be linked to ip)
* DOMAIN=the domain you plan to set the server up with
* DOMAINTYPE= either DOMAIN or SUBDOMAIN
* SHORTDOMAIN=your domain without the .com
* POSTFIX_FIX= \$domain
* LOCALE= the language you speak
* CHARSET= the charset of that language
* PORT= for secure ssh, we're going to close down port 22 so pick an alternate port
* PERMITROOTLOGIN=do you want to permit the root to login directly?
* PASSWORDAUTHENTICATION=can the user authentica with password if the ssh keys don't match?
* X11FORWARDING=forward x11
* USEDNS=
* PUBLIC_KEY= you local machines' public key
* MYSQL_PASSWORD=password for mysql
* PHP_MODS=any additional mods to compile with php
* DEPS= dependencies
######don't really need these if gitlab is being installed
* NGINX_GZ=path to nginx download
* NGINX_VER=version of nginx
######git and gitlab
* GITLAB= TRUE or FALSE - will you be installing gitlab (which needs passenger nginx or just regs)
* GITLABDOMAIN=domain of gitlab
* GITLABSHORTDOMAIN=same thing, no dotcom
* GIT_USER_EMAIL=your user git email
* GIT_USER_NAME=you user git name

When first run, ssh into your server as root, then run `sudo aptitude install git git-core`  

cd into your home dir `cd /root`  

followed by `git clone git://github.com/MrMaksimize/Linode-Deployment-Script.git deployment`  


and then of course `./root-runfile.sh`

and you're off!

If you're doing gitlab, make sure you hit 1 when it asks you if you want it to download and compile nginx for you.

Also, make sure to change repo_umask to 0007 from 0077 in the configuration for gitolite