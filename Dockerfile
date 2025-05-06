FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive 

ARG UNAME=xxxx
ARG UID=1000
ARG GID=1000

USER root
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME


# Required packages for Yocto build
RUN apt-get update && apt-get install -y \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    python3-subunit \
    zstd \
    liblz4-tool \
    file \
    locales \
    libacl1 \
    tmux \
    vim

RUN locale-gen en_US.UTF-8

# Switch to user
USER $UNAME
CMD /bin/bash
RUN echo "PS1=\"${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\W\[\033[00m\]\$ \"" >> ~/.bashrc
WORKDIR "/home/$UNAME"
