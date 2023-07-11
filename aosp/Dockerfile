FROM ubuntu:18.04

ARG USERNAME="aosp"
ARG GROUPNAME="aosp"
ARG PASSWORD="aosp"
ARG TIMEZONE="Asia/Shanghai"

ARG SRC_PATH="/aosp"

# config apt mirror
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
RUN sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

# upgrade system
RUN apt-get update && apt-get upgrade -y

# config timezone
RUN apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# config locales
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"

# install basic tools
RUN apt-get install -y \
    apt-transport-https ca-certificates \
    sudo vim psmisc bash-completion \
    rsync bc cpio

# install package required by AOSP, based on Google's documentation
RUN apt-get install -y \
    git gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 \
    libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
    libxml2-utils xsltproc unzip fontconfig

# install other basic build tools
RUN apt-get install -y \
    default-jdk python3 python3-pip ccache

# install repo
RUN mkdir -p /usr/local/bin
RUN curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o /usr/local/bin/repo
RUN chmod +x /usr/local/bin/repo

# clean apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# create normal user
RUN useradd -m -G sudo -s /bin/bash $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME
RUN echo "root:root" | chpasswd
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# create AOSP source directory
RUN mkdir $SRC_PATH && chown -R "$USERNAME:$GROUPNAME" "$SRC_PATH" && chmod -R 755 "$SRC_PATH"

# specify a volume mount for the source code directory, 
VOLUME ["$SRC_PATH"]

# switch work directory to source code directory.
WORKDIR "$SRC_PATH"

USER "$USERNAME"
