FROM ubuntu:16.04

ARG USERNAME="android"
ARG GROUPNAME="android"
ARG PASSWORD="android"
ARG SRC_PATH="/aosp"

# 安装软件
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
RUN sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https ca-certificates \
    sudo vim rsync bc cpio \
    default-jdk build-essential ccache gcc-multilib g++-multilib \
    gnupg flex bison zip curl xsltproc unzip fontconfig \
    libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils zlib1g-dev \
    libncurses5 libncurses5-dev libssl-dev \
    python3 python3-pip python python-pip \
    && apt-get -y upgrade \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install pycrypto==2.6.1 -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install pycrypto==2.6.1 -i https://pypi.tuna.tsinghua.edu.cn/simple

# ------------------------------------------

# 创建普通用户和同名用户组并添加到sudo组中
RUN useradd -m -G sudo -s /bin/bash $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME
RUN echo "${USERNAME}:${PASSWORD}" | chpasswd

# 创建aosp源码目录并设置其权限
RUN mkdir $SRC_PATH && chown -R "$USERNAME:$GROUPNAME" "$SRC_PATH" && chmod -R 755 "$SRC_PATH"

# 挂载代码目录
VOLUME ["$SRC_PATH"]
WORKDIR "$SRC_PATH"

USER "$USERNAME"

ENV BUILD_ALL="/aosp/buildall_userdebug.sh E6555BD pac"
ENV LUNCH_TARGET="ums9230_1h10_Natv-userdebug-gms"

CMD ["/bin/bash"]
