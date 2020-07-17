ARG VERSION=current
FROM node:$VERSION-alpine

# add git and open ssh
RUN echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && echo @edgecommunity http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && apk update && apk add --upgrade apk-tools@edge && apk upgrade \
    && apk add --no-cache bash openssh \
    # installing build dependencies
    git python make g++ xz shadow \
    && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing vips-tools@edgecommunity 

RUN apk add --update \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
  vips-tools \
  && rm -rf /var/cache/apk/*

RUN apk update \
    && apk add \
        sudo \
        docker \
        'py-pip' \
        zsh \
        vim \
        curl \
        zip \
        sed \
        jq \
        perl-utils \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade awscli==1.16.232 s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
RUN apk add python3=3.5.1-r0
RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
