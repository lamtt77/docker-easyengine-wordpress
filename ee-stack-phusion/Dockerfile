FROM phusion/baseimage
#FROM ubuntu:14.04
MAINTAINER Lam Tran <lamtt77@gmail.com>

## Making EasyEngine aware of our name and email
COPY ../ee-gitconfig /root/.gitconfig

RUN echo `cat ~/.gitconfig`

## Get and install EasyEngine
RUN apt-get install -y wget
RUN wget -qO ee rt.cx/ee && sudo bash ee

## Source auto completion
CMD "source /etc/bash_completion.d/ee_auto.rc"

## ee stack install for mysql and web
RUN ee stack install --web

COPY ../startStack.sh /

ENTRYPOINT /startStack.sh

EXPOSE 80 443 22222
CMD ["bash"]
