echo "mysql"
# MySQL
aptitude install -y debconf-utils
echo mysql-server mysql-server/root_password password $MYSQL_PASSWORD | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD | debconf-set-selections
aptitude -y install mysql-server && mysql_secure_installation