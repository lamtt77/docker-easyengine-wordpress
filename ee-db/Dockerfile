FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

COPY startDB.sh /
COPY my.cnf /etc/mysql/my.cnf
COPY grantRemoteAccess.sql /

## ee stack install for mysql
RUN ee stack install --mysql

RUN ee stack start --mysql

RUN chown -R mysql:mysql /var/lib/mysql
RUN mysql -u root -p 'OACPbwFy' < grantRemoteAccess.sql

RUN service mysql stop

VOLUME ["/var/lib/mysql"]

ENTRYPOINT /startDB.sh

EXPOSE 3306
CMD ["bash"]
