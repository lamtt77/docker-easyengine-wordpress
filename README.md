# TL;DR - One-command deployment
Orchestrate/Pre-Build the 10-min EasyEngine WordPress deployment into Docker image.

+ Requirements: Docker & Docker-Compose have already installed

1- Let's start
```sh
cp .env.sample .env 
  --> Edit and fill up blank fields in the file '.env' with your secret user & password
docker-compose up
```

Note that maria auto-generated password at /etc/mysql/conf.d/my.cnf will be ignored and replaced by your new one set at '.env'

== Tada == 

Pros:
+ 10-min deployment reduced to ~3min -- assumed that internet speed of your cloud provider should be on par with AWS, DigitalOcean, Gcloud Compute (my test was gcloud)
+ Our deployment is now 'portable' and 'cloud provider' independent

Trade-off:
- Installation time of docker & docker-compose might get longer than 10-min if you are not familiar with 'Docker'.  The good news is that most cloud providers support Docker-preinstalled -- You just need to pick the appropriate VPS and install docker-compose through 'wget'. 

2- Just go and create your wordpress site, automatically
```sh
docker exec dockereasyenginewordpress_wp-ee-web_1 \
  ee site create wp.example.dev --user=YOURUSER --pass=YOURPSW --email=YOUREMAIL
```

Note
+ 'docker ps' would reveal the name of your 'wp-ee-web' container in case of needed.
+ Please ensure your /etc/hosts contain en entry for 'wp.example.dev' if you have not owned that domain yet

3- Getting bored with that name, want to delete and create new site
```sh
docker exec dockereasyenginewordpress_wp-ee-web_1 \
  ee site delete --no-prompt wp.example.dev
```
== Tada ==

Bonus: I used the following to create my Gcloud Docker VM ('docker-machine' required):
```sh
docker-machine create --driver google \
  --google-project myDockerPrj \
  --google-zone CHANGE-TO-YOUR-ZONE \
  --google-machine-type g1-small \
  --google-disk-size 30 \
  myVM
```

# SECURITY
* Please do change to your-own secure http password (admin port 22222) at first run of the deployed image
```sh
docker exec dockereasyenginewordpress_wp-ee-web_1 bash
ee secure --auth
```

# docker-easyengine-wordpress
Once completed, we will be going to have

1- Vanilla Official Ubuntu:14.04 docker base image

2- EasyEngine base installation created
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

4- Once completed, a popular WordPress site is ready to get built automatically by the following command
```sh
ee site create wp.example.dev --user=YOURUSER --pass=YOURPSW --email=YOUREMAIL
```

+ Or if you like to start with multi-site wordpress
```sh
ee site create wp.example.dev --user=YOURUSER --pass=YOURPSW --email=YOUREMAIL --wpsubdom
```
	
Alternative to step (3), we could create a pre-build stack image as follows
```sh
cd ee-stack
docker build -t ee-stack -f Dockerfile .
```

And then run ee-stack
```sh
docker run --rm -p 80:80 -p 443:443 -p 22222:22222 ee-stack
```
A file type mis-match warning could be ignored if encountered.  Note that 'ee stack start' will be triggered automatically. 

Review entrypoint for the stack services
```sh
docker exec -it ee-stack bash
-->#$ /startStack.sh
```

The pre-build Docker images are available to pull from Docker.  Please see Docker Auto Build section. 

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

```sh
docker stop wp-ee-stack
docker run --rm --name wp-ee-stack \
  -p 80:80 -p 443:443 -p 22222:22222 \
  -v /var/lib/mysql:/var/lib/mysql \
  -v /var/www:/var/www \
  lamtrantuan/docker-easyengine-stack
```

# Running services separatedly in its own container
* Database (MariaDB)
```bash
docker run --rm --name wp-ee-db -p 3306:3306 lamtrantuan/docker-easyengine-stack:db
```

* Web (Nginx, Php5-fpm, postfix by default.  HHVM, Redis, PhpMyAdmin could be manually turned on)
```bash
docker run --rm --name wp-ee-web -p 80:80 -p 443:443 -p 22222:22222 lamtrantuan/docker-easyengine-stack:web
```
