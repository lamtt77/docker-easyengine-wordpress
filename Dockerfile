FROM ubuntu:14.04

RUN echo "export TERM=xterm" >> /etc/bash.bashrc

## Making EasyEngine aware of our name and email
COPY ee-gitconfig /root/.gitconfig

RUN echo `cat ~/.gitconfig`

## Get and install EasyEngine
RUN apt-get install -y wget
RUN wget -qO ee rt.cx/ee && sudo bash ee

## Source auto completion
CMD "source /etc/bash_completion.d/ee_auto.rc"

EXPOSE 80 443 22222

# Define default command.
CMD ["bash"]
