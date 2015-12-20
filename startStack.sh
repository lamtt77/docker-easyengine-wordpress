#!/bin/bash

echo "Services (MariaDB, Nginx, PHP, etc) are starting, please wait..."
ee stack start
tail -f /var/log/ee/ee.log
