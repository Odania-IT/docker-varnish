FROM odaniait/docker-base:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

# Set correct environment variables.
ENV HOME /root

RUN apt-get install -y apt-transport-https
RUN curl -L https://packagecloud.io/varnishcache/varnish5/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/varnishcache/varnish5/ubuntu/ trusty main" >> /etc/apt/sources.list.d/varnish-cache.list
RUN echo "deb-src https://packagecloud.io/varnishcache/varnish5/ubuntu/ trusty main" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update
RUN apt-get install -y varnish

ENV VCL_CONFIG /etc/varnish/default.vcl
ENV CACHE_SIZE 128m
ENV LISTEN_PORT 80

# setup varnish service
RUN mkdir -p /etc/service/varnish
COPY runit/varnish.sh /etc/service/varnish/run

VOLUME ["/opt/varnish"]

EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
