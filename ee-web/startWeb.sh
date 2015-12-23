#!/bin/bash

echo "Services (Nginx, Php5-fpm, etc) are starting, please wait..."

# A bit hacky to enable dynamic env variables as Docker yet to support -- just to hide psw in the auto build
sed -i "s/REMOTE_MYSQL_HOST/$REMOTE_MYSQL_HOST/" /etc/mysql/conf.d/my.cnf
sed -i "s/REMOTE_MYSQL_USER/$REMOTE_MYSQL_USER/" /etc/mysql/conf.d/my.cnf
sed -i "s/REMOTE_MYSQL_PASSWORD/$REMOTE_MYSQL_PASSWORD/" /etc/mysql/conf.d/my.cnf
sed -i "s/PUBLIC_IP_OF_EASYENGINE_SERVER/$PUBLIC_IP_OF_EASYENGINE_SERVER/" /etc/ee/ee.conf

ee stack start

echo 'Configuration finished! Now reporting latest status of all services...'
ee info

tail -f /var/log/ee/ee.log
