FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

## ee stack install for mysql
RUN ee stack install --mysql

VOLUME ["/var/lib/mysql"]

COPY startDB.sh /

ENTRYPOINT /startDB.sh

EXPOSE 3306
CMD ["bash"]
