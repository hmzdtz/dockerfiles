FROM ubuntu:18.04

ARG USERNAME="android"
ARG GROUPNAME="android"
ARG PASSWORD="android"
ARG SRC_PATH="/aosp"

ARG TIMEZONE="Asia/Shanghai"
ARG GIT_LFS_DEB="./git-lfs_2.13.3_amd64.deb"

ENV DEBIAN_FRONTEND="noninteractive"

# change apt mirror
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
RUN sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

# upgrade system
RUN apt-get update && apt-get upgrade -y

# change timezone
RUN apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

# install basic tools
RUN apt-get install -y apt-transport-https ca-certificates \
    git \
    sudo vim psmisc \
    rsync bc cpio \
    default-jdk build-essential ccache gcc-multilib g++-multilib \
    gnupg flex bison zip curl xsltproc unzip fontconfig \
    libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils zlib1g-dev \
    libncurses5 libncurses5-dev libssl-dev \
    python3 python3-pip

# install repo
RUN mkdir -p /usr/local/bin
RUN curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o /usr/local/bin/repo
RUN chmod +x /usr/local/bin/repo

# install git-lfs
COPY $GIT_LFS_DEB /git-lfs.deb
RUN apt-get install -y /git-lfs.deb && rm -f /git-lfs.deb


# install python2 and some tools for building t616
RUN apt-get install -y python python-pip
RUN pip install pycrypto==2.6.1 -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install pycrypto==2.6.1 -i https://pypi.tuna.tsinghua.edu.cn/simple

# clean apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# ------------------------------------------

# create normal user
RUN useradd -m -G sudo -s /bin/bash $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME
RUN echo "root:root" | chpasswd
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# 创建aosp源码目录并设置其权限
RUN mkdir $SRC_PATH && chown -R "$USERNAME:$GROUPNAME" "$SRC_PATH" && chmod -R 755 "$SRC_PATH"

# 挂载代码目录
VOLUME ["$SRC_PATH"]
WORKDIR "$SRC_PATH"

USER "$USERNAME"

ENV PROJECT="E6555BD"
ENV BUILD_ALL="/aosp/buildall_userdebug.sh $PROJECT pac"
ENV LUNCH="lunch ums9230_1h10_Natv-userdebug-gms"

CMD ["/bin/bash"]
