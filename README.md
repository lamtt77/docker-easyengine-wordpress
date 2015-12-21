# docker-easyengine-wordpress
Orchestrate/Pre-Build the 15mins EasyEngine WordPress deployment into Docker image.

Once completed, we will be going to have:

1- Vanilla Official Ubuntu:14.04 docker base image

2- EasyEngine base installation created:
```sh
apt-get install wget
wget -qO ee rt.cx/ee && sudo bash ee
source /etc/bash_completion.d/ee_auto.rc
```

3- Next step is to run that base image and going inside setup the required stack and starting the services: MySQL (MariaDB), Web (Nginx + php5-fpm) and some admin utils
```sh
ee stack install
ee stack start
```

4- Once completed, a popular WordPress site is ready to get built automatically by the following command:
```sh
ee site create wp.example.dev --user=YOURUSER --pass=YOURPSW --email=YOUREMAIL
```

+ Or if you like to start with multi-site wordpress:
```sh
ee site create wp.example.dev --user=YOURUSER --pass=YOURPSW --email=YOUREMAIL --wpsubdom
```
	
Alternative to step (3), we could create a pre-build stack image as follows:
```sh
cd ee-stack
docker build -t ee-stack -f Dockerfile .
```

And then run ee-stack:
```sh
docker run --rm -p 80:80 -p 443:443 -p 22222:22222 ee-stack
```
A file type mis-match warning could be ignored if encountered.  Note that 'ee stack start' will be triggered automatically. 

Review entrypoint for the stack services:
```sh
docker exec -it ee-stack bash
-->#$ /startStack.sh
```

The pre-build Docker images are available to pull from Docker.  Please see Docker Auto Build section. 

# SECURITY
* Please do change your secure http password (admin port 22222) at first run of the ee-stack image:
```sh
ee secure --auth
```

# phusion/baseimage
* Switch to phusion-baseimage branch

# Docker Auto Build generated
+ [ee-base](https://hub.docker.com/r/lamtrantuan/docker-easyengine-wordpress/) on Ubuntu:14.04
+ [ee-base](https://hub.docker.com/r/lamtrantuan/docker-easyengine-wordpress/) on phusion/baseimage
+ [ee-stack](https://hub.docker.com/r/lamtrantuan/docker-easyengine-stack/) on Ubuntu:14.04
+ [ee-stack](https://hub.docker.com/r/lamtrantuan/docker-easyengine-stack/) on phusion/baseimage

# TODO for production site
+ Mapping actual data volumes to host: MariaDB (/var/lib/mysql), WordPress (htdocs/html/php)
+ Split each stack service into its own container as practice advice for miro-services

# Mapping volumes for web and db on auto-build ee-stack
```sh
docker run --rm --name wp-ee-stack \
  -p 80:80 -p 443:443 -p 22222:22222 \
  lamtrantuan/docker-easyengine-stack
  
sudo docker cp wp-ee-stack:/var/www/ /var/
sudo docker cp wp-ee-stack:/var/lib/mysql/ /var/lib/
```

+ MariaDB 10.1 is having an issue with mapping volume while 10.0 DOES work! So workaroud if still prefer to use 10.1
```hack
sudo useradd -U mysql && sudo chown -R mysql:mysql /var/lib/mysql
docker exec -it wp-ee-stack bash
id mysql -> get UID and GID
exit

+ Return to host, use usermod and groupmod to modify host's mysql to UID and GID above 
```

```sh
docker stop wp-ee-stack
docker run --rm --name wp-ee-stack \
  -p 80:80 -p 443:443 -p 22222:22222 \
  -v /var/lib/mysql:/var/lib/mysql \
  -v /var/www:/var/www \
  lamtrantuan/docker-easyengine-stack
```

# Running services separatedly in its own container:
* Database (MariaDB)
```bash
docker run --rm --name wp-ee-db -p 3306:3306 lamtrantuan/docker-easyengine-stack:db
```

* Web (Nginx, Php5-fpm, postfix by default.  HHVM, Redis, PhpMyAdmin could be manually turned on)
```bash
docker run --rm --name wp-ee-web -p 80:80 -p 443:443 -p 22222:22222 lamtrantuan/docker-easyengine-stack:web
```
