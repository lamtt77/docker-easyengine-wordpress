FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

## Install mysql-client to connect to remote DB
RUN apt-get update && apt-get install -y mysql-client

COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY ee.conf /etc/ee/ee.conf
COPY startWeb.sh /

## ee stack install for nginx and php5-fpm
RUN ee stack install --nginx
RUN ee stack install --php
RUN ee stack install --postfix
RUN ee stack install --redis

VOLUME ["/var/www"]

ENTRYPOINT /startWeb.sh

EXPOSE 80 443 22222
CMD ["bash"]
