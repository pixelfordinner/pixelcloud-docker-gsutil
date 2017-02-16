FROM alpine:3.5
MAINTAINER Karl Fathi <karl@pixelfordinner.com>

ENV LANG C.UTF-8

RUN addgroup -S duplicity && \
    mkdir -p /mnt/app && \
    adduser -D -S -u 1896 -h /mnt/app -s /sbin/nologin -G duplicity duplicity

RUN apk add --no-cache \
    su-exec \
    python \
    py-setuptools \
    py-pip \
    py-cffi \
    py-cryptography

RUN pip install --upgrade pip
RUN pip install gsutil

RUN apk del --purge py-pip

ADD ./data/bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENTRYPOINT ["entrypoint"]
