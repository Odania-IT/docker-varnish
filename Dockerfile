FROM odaniait/docker-base:latest
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

VOLUME ["/opt/varnish"]

EXPOSE 80

CMD varnishd -F -a 0.0.0.0:$LISTEN_PORT -f $VCL_CONFIG

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*