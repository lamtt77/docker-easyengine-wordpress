chown -R mysql:mysql /var/lib/mysql
mysql -e "grant all privileges on *.* to 'root'@'%' with grant option; flush privileges;"
