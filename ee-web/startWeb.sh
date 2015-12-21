#!/bin/bash

echo "Services (Nginx, Php5-fpm, etc) are starting, please wait..."
ee stack start
chown -R www-data:www-data /var/www
tail -f /var/log/ee/ee.log
