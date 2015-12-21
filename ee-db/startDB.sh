#!/bin/bash

echo "MariaDB is Starting, please wait..."
ee stack start --mysql
chown -R mysql:mysql /var/lib/mysql
tail -f /var/log/ee/ee.log
