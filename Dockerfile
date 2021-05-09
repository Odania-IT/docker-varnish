FROM ubuntu:20.04
MAINTAINER Mike Petersen <mike@odania-it.de>

# Set correct environment variables.
ENV HOME /root

# install dependencies
RUN apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install -y apt-transport-https curl gnupg && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install varnish
RUN curl -L https://packagecloud.io/varnishcache/varnish60/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/varnishcache/varnish60/ubuntu/ xenial main" >> /etc/apt/sources.list.d/varnish-cache.list
RUN echo "deb-src https://packagecloud.io/varnishcache/varnish60/ubuntu/ xenial main" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update && \
	apt-get install -y varnish && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup
ENV VCL_CONFIG /etc/varnish/default.vcl
ENV CACHE_SIZE 128m
ENV LISTEN_PORT 80
COPY varnish.sh /varnish.sh

VOLUME ["/opt/varnish"]
CMD ["/varnish.sh"]

EXPOSE 80

