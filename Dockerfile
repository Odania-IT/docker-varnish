FROM odaniait/docker-base:v2
MAINTAINER Mike Petersen <mike@odania-it.de>

# Set correct environment variables.
ENV HOME /root

RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
RUN echo "deb https://repo.varnish-cache.org/ubuntu/ precise varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
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
