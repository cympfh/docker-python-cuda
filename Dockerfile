FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        tzdata \
        locales \
        build-essential \
        curl \
        zlib1g-dev \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# Python3
WORKDIR /tmp/python
RUN pwd
RUN curl https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz | tar xfz -
WORKDIR /tmp/python/Python-3.6.9
RUN ./configure && make install
RUN rm -rf /tmp/python
RUN ln -s /usr/local/bin/python3 /usr/local/bin/python
RUN ln -s /usr/local/bin/pip3 /usr/local/bin/pip
RUN ln -s /usr/local/bin/pydoc3 /usr/local/bin/pydoc

WORKDIR /
