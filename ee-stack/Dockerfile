FROM lamtrantuan/docker-easyengine-wordpress:phusion-baseimage
MAINTAINER Lam Tran <lamtt77@gmail.com>

## ee stack install for mysql and web
RUN ee stack install --web

COPY startStack.sh /

ENTRYPOINT /startStack.sh

EXPOSE 80 443 22222
CMD ["bash"]
