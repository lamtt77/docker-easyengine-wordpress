#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo systemctl enable $DIR/services/wp-ee-stack.service
sudo systemctl start wp-ee-stack

systemctl status wp-ee-stack
