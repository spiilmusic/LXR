FROM ubuntu:trusty

COPY sources.list /etc/apt/sources.list

# RUN apt-get update \
# && apt-cache search glibc \
# && apt-cache search libstd \
# && exit 1 

RUN mkdir installing \
    && dpkg --add-architecture i386 \
#    && apt-get update && apt-get install libncurses5 libncurses5:i386 \
    && cd installing \
    && apt-get update \
# lib32ncurses5
    && apt-get install \
    curl \
    binutils \
    libc6:i386 \
    libbz2-1.0:i386 \
    gcc-avr \
    avr-libc \
    cpio \
    build-essential \
    make \
    --yes \
    && curl -OL https://launchpad.net/gcc-arm-embedded/4.8/4.8-2014-q1-update/+download/gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2

WORKDIR installing

RUN tar xvjf gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2 \
    && mv gcc-arm-none-eabi-4_8-2014q1 /opt/ARM \
    && rm gcc-arm-none-eabi-4_8-2014q1-20140314-linux.tar.bz2

ENV PATH="/opt/ARM/bin:${PATH}"

WORKDIR /app
