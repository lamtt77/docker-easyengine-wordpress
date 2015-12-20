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
docker build -t ee-stack -f ee-stack/Dockerfile .
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

# SECURITY
* Please do change your secure http password (admin port 22222) at first run of the ee-stack image:
```sh
ee secure --auth
```

# TODO for production site:
+ Mapping actual data volumes to host: MariaDB (/var/lib/mysql), WordPress (htdocs/html/php)
+ Split each stack service into its own container as practice advice for miro-services
