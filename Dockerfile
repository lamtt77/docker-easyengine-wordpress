FROM phusion/baseimage
MAINTAINER Lam Tran <lamtt77@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

## Making EasyEngine aware of our name and email
COPY ee-gitconfig /root/.gitconfig

RUN echo `cat ~/.gitconfig`
## Must run apt-get update before executing phusion/baseimage
RUN apt-get update

## Get and install EasyEngine
RUN apt-get install -y wget
RUN wget -qO ee rt.cx/ee && sudo bash ee

## Source auto completion
CMD "source /etc/bash_completion.d/ee_auto.rc"

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 443 22222

# Define default command.
CMD ["bash"]
