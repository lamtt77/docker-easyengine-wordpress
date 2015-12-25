FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

COPY startDB.sh /
COPY my.cnf /etc/mysql/my.cnf

## ee stack install for mysql
RUN ee stack install --mysql

VOLUME ["/var/lib/mysql"]

ENTRYPOINT /startDB.sh

EXPOSE 3306
CMD ["bash"]
