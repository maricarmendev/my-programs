#!/bin/bash

### NOTES ###
# Installations
#   - curl
# Terminals Availables
#   - bash
#   - zsh

### VARIABLES ###
nvm_repository="https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh"
bashrc_path="~/.bashrc"
zshrc_path="~/.zshrc"

### ICONS ###
icon_success=🟢
icon_warning=🟠
icon_error=🔴
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

function installCurl(){
    sudo apt install -y curl
}

