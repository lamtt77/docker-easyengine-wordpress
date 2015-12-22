#!/bin/bash

echo "MariaDB is Starting, please wait..."
ee stack start --mysql

sed -i "s/MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/" grantRemoteAccess.sh
grantRemoteAccess.sh

tail -f /var/log/ee/ee.log
