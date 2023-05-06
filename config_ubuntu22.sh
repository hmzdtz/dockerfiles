#!/bin/bash

echo '------ upgrade system ------'
sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sudo sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sudo apt-get update && apt-get upgrade -y

echo '------ install common ------'
sudo apt-get install -y zsh nala apt-file build-essential curl default-jdk vim-gtk3 git git-lfs
sudo snap install --classic code

echo '------ install repo ------'
mkdir -p $HOME/bin
curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o $HOME/bin/repo
chmod +x $HOME/bin/repo
echo "export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'" >> $HOME/.bashrc

echo '------ install gnome tools ------'
sudo apt-get install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager

echo '------ install qemu ------'
sudo apt-get install -y qemu-system

# install docker
echo '------ install docker ------'
sudo apt-get remove -y docker docker-engine docker.io containerd runc
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

# config git
git config --add oh-my-zsh.hide-dirty 1
