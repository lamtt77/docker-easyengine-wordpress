#!/bin/bash

echo "MariaDB is Starting, please wait..."
ee stack start --mysql

grantRemoteAccess.sh

tail -f /var/log/ee/ee.log
