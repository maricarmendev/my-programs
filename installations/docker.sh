#!/bin/bash

### NOTES ###

### VARIABLES ###

### ICONS ###
icon_success=🟢
icon_warning=🟠
icon_error=🔴
icon_info=🔵
icon_arror_from=↪

### HELPERS ###
function successMessage(){
    echo "$2 $icon_success OK $1"
}

function warningMessage(){
    echo "$2 $icon_warning WARNING $1"
}

function errorMessage(){
    echo "$2 $icon_error ERROR $1"
}

function infoMessage(){
    echo "$2 $icon_info INFO $1"
}

function installCurl(){
    sudo apt install -y curl
}

function installDocker(){
    sudo apt update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
}

############ PROGRAM ############

### CURL ###
if ! [ -x "$(command -v curl)" ]; then
    warningMessage 'Curl is not installed.'
    installCurl
    successMessage "Curl is installed" "  "
else
    successMessage "Curl is installed"
fi

### 1
infoMessage 'Update the apt package index and install packages to allow apt to use a repository over HTTPS'
sudo apt update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

### 2
infoMessage 'Add Docker’s official GPG key'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

### 3
infoMessage 'Use the following command to set up the stable repository. To add the nightly or test repository,'
infoMessage 'add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.'
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


### DOCKER ###
infoMessage '### Install Docker ###'
infoMessage 'Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version'
if ! [ -x "$(command -v docker)" ]; then
    warningMessage 'Docker is not installed.'
    installDocker
    successMessage "Docker is installed" "  "
else
    successMessage "Docker is installed"
fi

infoMessage 'Enable without sudo permissions'
if [ -z "groups | grep -o docker" ]; then
    warningMessage 'Docker group not exist'
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker 
    successMessage "Docker group is created successfully"
fi 


### 4
docker run hello-world