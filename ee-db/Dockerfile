FROM lamtrantuan/docker-easyengine-wordpress
MAINTAINER Lam Tran <lamtt77@gmail.com>

COPY startDB.sh /
COPY my.cnf /etc/mysql/my.cnf
COPY grantRemoteAccess.sql /

## ee stack install for mysql
RUN ee stack install --mysql
RUN mysql -u root -p 'OACPbwFy' < grantRemoteAccess.sql

VOLUME ["/var/lib/mysql"]

ENTRYPOINT /startDB.sh

EXPOSE 3306
CMD ["bash"]
