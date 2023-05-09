#!/bin/bash

echo '------ upgrade system ------'
sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sudo sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y


echo '------ install common ------'
sudo apt-get install -y zsh apt-file software-properties-common apt-transport-https wget curl vim-gtk3 git git-lfs
    

echo '------ install build tools ------'
sudo apt-get install -y build-essential default-jdk pkg-config python3 python-is-python3 python3-pip \
    clang clangd clang-format llvm

echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" \
    | sudo tee /etc/pip.conf > /dev/null


# android develop
sudo apt-get install -y android-sdk-platform-tools-common

echo '------ install repo ------'
mkdir -p $HOME/bin
curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o $HOME/bin/repo
chmod +x $HOME/bin/repo


# install tools for gnome
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
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker $LOGNAME


# config zsh
echo '------ config zsh ------'
sudo mkdir -p /etc/zsh
sudo touch /etc/zsh/zshrc
sudo apt-get install -y zsh-autosuggestions zsh-syntax-highlighting
echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' \
    | sudo tee -a /etc/zsh/zshrc > /dev/null
echo 'source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' \
    | sudo tee -a /etc/zsh/zshrc > /dev/null
git config --global --add oh-my-zsh.hide-dirty 1


# config env
# rust
echo 'RUSTUP_UPDATE_ROOT="https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup"' \
    | sudo tee -a /etc/environment > /dev/null
echo 'RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"' \
    | sudo tee -a /etc/environment > /dev/null
# git-repo
echo 'REPO_URL="https://mirrors.tuna.tsinghua.edu.cn/git/git-repo"' \
    | sudo tee -a /etc/environment > /dev/null
# nodejs
echo 'NODE_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/"' \
    | sudo tee -a /etc/environment > /dev/null
echo 'NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/' \
    | sudo tee -a /etc/environment > /dev/null
echo 'FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/' \
    | sudo tee -a /etc/environment > /dev/null

