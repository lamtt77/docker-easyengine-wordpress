FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY startDB.sh /

## ee stack install for mysql
RUN ee stack install --mysql

## change bind address to 0.0.0.0
RUN sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

VOLUME ["/var/lib/mysql","/var/log/mysql"]

ENTRYPOINT /startDB.sh

EXPOSE 3306
CMD ["bash"]
