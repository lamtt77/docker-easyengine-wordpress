#!/bin/bash

echo "Services (Nginx, Php5-fpm, etc) are starting, please wait..."
ee stack start
tail -f /var/log/ee/ee.log
