#!/bin/bash

### NOTES ###
# exe with source
# $ source ./oh-my-zsh
# installations
# - curl
# - git
# - zsh
# - oh-my-zsh

### VARIABLES ###
zsh_url="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
gitUserName="Maricarmen"
gitEmail="mcrodriguez@ggtech.es"

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
    echo "$2 $icon_error ERROR $1"
}

function installCurl(){
    sudo apt install -y curl
}

function installGit(){
    sudo apt install -y git
}

function installZsh(){
    sudo apt install -y zsh
}

function installOhMyZsh(){
    sh -c "$(curl -fsSL $zsh_url)"
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

### GIT ###
if ! [ -x "$(command -v git)" ]; then
    warningMessage '[Alert] Git is not installed.'
    installGit
    successMessage "Git is installed" "  "
else
    successMessage "Git is installed"
fi 

if ! [ -z "$(cat ~/.gitconfig | grep name)" ];
then
    successMessage "Git user.name correct"  "  $icon_arror_from"
else
    warningMessage "Git user.name misconfigured" "  $icon_arror_from"
    git config --global user.name $gitUserName
    successMessage "Git user.name correct" "    $icon_arror_from"
fi 

if ! [ -z "$(cat ~/.gitconfig | grep email)" ];
then
    successMessage "Git user.email correct" "  $icon_arror_from"
else
    warningMessage "Git user.email misconfigured" "  $icon_arror_from"
    git config --global user.email $gitEmail
    successMessage "Git user.email correct" "    $icon_arror_from"
fi 

### ZSH ###
if ! [ -x "$(command -v zsh)" ]; then
    warningMessage 'zsh is not installed.'
    installZsh
    successMessage "Zsh is installed" "  "
else
    successMessage "Zsh is installed"
fi 

### OH MY ZSH ###
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --skip-chsh
successMessage "Oh my zsh is installed" "  "
chsh -s $(which zsh)