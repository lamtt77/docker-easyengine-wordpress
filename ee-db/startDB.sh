#!/bin/bash

echo "MariaDB is Starting, please wait..."
ee stack start --mysql
tail -f /var/log/ee/ee.log
