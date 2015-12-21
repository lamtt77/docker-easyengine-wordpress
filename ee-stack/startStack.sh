#!/bin/bash

echo "Services (MariaDB, Nginx, PHP, etc) are starting, please wait..."
ee stack start
chown -R mysql:mysql /var/lib/mysql && chown -R www-data:www-data /var/www
tail -f /var/log/ee/ee.log
