FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y \
    curl \
    autoconf \
    automake \
    build-essential \
    byacc \
    flex \
    xa65 \
    gawk \
    libgtk-3-dev \
    texinfo \
    texlive-fonts-recommended \
    texlive-latex-extra \
    dos2unix \
    libpulse-dev \
    libasound2-dev \
    libglew-dev \
    libcurl4-openssl-dev \
    libpng-dev \
    libgif-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/vice-3.8

RUN curl -L https://sourceforge.net/projects/vice-emu/files/releases/vice-3.8.tar.gz/download | tar -xvz --strip-components=1

RUN ./autogen.sh && \
    ./configure \
    --enable-gtk3ui \
    --enable-debug-gtk3ui \
    --enable-debug && \
    make && \
    make install

ENV DISPLAY=":0.0"