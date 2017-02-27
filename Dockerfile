FROM alpine:latest
MAINTAINER Andrew Taranik <me@pureclouds.net>

ENV AGE 7
ENV INDEX logstash
ENV ELASTICSEARCH_HOST elasticsearch
ENV ELASTICSEARCH_PORT 9200

RUN apk --no-cache add \
        tini \
        python \
        py-setuptools \
        py-pip \
 && pip install elasticsearch-curator \
 && apk --no-cache del \
        py-pip

RUN echo '#!/bin/sh' | tee /etc/periodic/daily/curator \
 && echo 'curator --config /config.yml actions.yml' | tee -a /etc/periodic/daily/curator \
 && chmod +x /etc/periodic/daily/curator

ADD config.yml /config.yml
ADD actions.yml /actions.yml

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["crond","-f"]
