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
docker build -t ee-stack -f Dockerfile-stackinstall .
```

And then run ee-stack:
```sh
docker run -itd -p 80:80 -p 443:443 -p 22222:22222 ee-stack bash
```

After that, going inside the container to start the services:
```sh
docker exec -it ee-stack bash
-->#$ /startStack.sh
```
