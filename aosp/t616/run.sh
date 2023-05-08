#!/bin/bash

IMAGE_NAME="aosp:t616"
CONTAINER_NAME="aosp-t616"
SOURCE_PATH="$HOME/src/aosp/t616"

if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.ustc.edu.cn/docker-ce/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce
fi

if [[ -z "$(docker images -q $IMAGE_NAME 2> /dev/null)" ]]; then
    docker build -t aosp:t616 .
fi


if [[ -z "$(docker inspect $CONTAINER_NAME 2> /dev/null | grep "\"Name\": \"/$CONTAINER_NAME\"")" ]]; then
    docker run --name $CONTAINER_NAME -v $SOURCE_PATH:/aosp -it $IMAGE_NAME
else
    # docker stop $CONTAINER_NAME
    docker start -a -i $CONTAINER_NAME
fi
