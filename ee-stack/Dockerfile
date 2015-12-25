##FROM lamtrantuan/easyengine-base-ubuntu:14.04
FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

## ee stack install
RUN ee stack install --web
RUN ee stack install --admin
RUN ee stack install --wpcli
RUN ee stack install --utils

VOLUME ["/var/lib/mysql", "/var/www"]

COPY startStack.sh /

ENTRYPOINT /startStack.sh

EXPOSE 80 443 22222
CMD ["bash"]
