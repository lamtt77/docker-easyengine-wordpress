#!/bin/bash

echo "===============================================>"
echo "MariaDB is starting, please wait..."

chown -R mysql:mysql /var/lib/mysql
sed -i "s/MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/" /etc/mysql/conf.d/my.cnf

ee stack start --mysql

mysql -e "grant all privileges on *.* to 'root'@'$PUBLIC_IP_OF_EASYENGINE_SERVER' \
  IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' with grant option; flush privileges;"

mysql -e "grant all privileges on *.* to '$REMOTE_MYSQL_USER'@'$PUBLIC_IP_OF_EASYENGINE_SERVER' \
  IDENTIFIED BY '$REMOTE_MYSQL_PASSWORD' with grant option; flush privileges;"

tail -f /var/log/ee/ee.log
