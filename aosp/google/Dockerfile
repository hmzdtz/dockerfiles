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
    sudo vim psmisc \
    rsync bc cpio \
    \
    git-core gnupg flex bison build-essential zip curl \
    zlib1g-dev libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils \
    xsltproc unzip fontconfig \
    \
    python3 python3-pip python python-pip \
    && apt-get -y upgrade \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------

# 创建普通用户和同名用户组并添加到sudo组中
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

CMD ["/bin/bash"]

