chown -R mysql:mysql /var/lib/mysql
mysql -e "grant all privileges on *.* to 'root'@'$PUBLIC_IP_OF_EASYENGINE_SERVER' \
  IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' with grant option; flush privileges;"
