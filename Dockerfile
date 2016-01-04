# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Dmitry Zinovyev

RUN apt-get update --fix-missing
# Add libs
RUN DEBIAN_FRONTEND=noninteractiveapt-get install -y git-core gcc pkg-config make libpcre3 libpcre3-dev libssl-dev wget python-software-properties software-properties-common


#RUN sudo apt-add-repository multiverse && wget -O - http://installrepo.kaltura.org/repo/apt/debian/kaltura-deb.gpg.key|sudo apt-key add - && sudo echo "deb [arch=amd64] http://installrepo.kaltura.org/repo/apt/debian kajam main" > /etc/apt/sources.list.d/kaltura.list && sudo apt-get update
RUN apt-add-repository multiverse && apt-get update


# get latest rtmp-module
RUN git clone https://github.com/kaltura/nginx-vod-module.git

# get nginx
RUN wget http://nginx.org/download/nginx-1.8.0.tar.gz
RUN tar xzf nginx-1.8.0.tar.gz

# compile nginx with rtmp-module
RUN cd /nginx-1.8.0 && ./configure --add-module=/nginx-vod-module --with-file-aio --with-threads
RUN cd /nginx-1.8.0 && make && make install

RUN mkdir /media
VOLUME /media

EXPOSE 8886
#EXPOSE 1935

ADD nginx.conf /usr/local/nginx/conf/
CMD /usr/local/nginx/sbin/nginx
