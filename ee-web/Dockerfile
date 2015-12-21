FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

## ee stack install for nginx and php5-fpm
RUN ee stack install --nginx
RUN ee stack install --php
RUN ee stack install --postfix

VOLUME ["/var/www"]

COPY startWeb.sh /

ENTRYPOINT /startWeb.sh

EXPOSE 80 443 22222
CMD ["bash"]
