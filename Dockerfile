# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Dmitry Zinovyev

RUN apt-get update --fix-missing
# Add libs
RUN apt-get install -y git-core gcc pkg-config make libpcre3 libpcre3-dev libssl-dev wget

# get latest rtmp-module
RUN git clone git://github.com/arut/nginx-rtmp-module.git

# get nginx
RUN wget http://nginx.org/download/nginx-1.5.9.tar.gz
RUN tar xzf nginx-1.5.9.tar.gz

# compile nginx with rtmp-module
RUN cd /nginx-1.5.9 && ./configure --add-module=/nginx-rtmp-module
RUN cd /nginx-1.5.9 && make && make install

RUN mkdir /flvs
VOLUME /flvs

EXPOSE 80
EXPOSE 1935

ADD nginx.conf /usr/local/nginx/conf/
CMD /usr/local/nginx/sbin/nginx
