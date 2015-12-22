#!/bin/bash

echo "MariaDB is Starting, please wait..."
ee stack start --mysql
chown -R mysql:mysql /var/lib/mysql
mysql -u root -p 'OACPbwFy' < grantRemoteAccess.sql
tail -f /var/log/ee/ee.log
