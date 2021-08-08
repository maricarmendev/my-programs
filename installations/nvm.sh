#!/bin/bash

### NOTES ###
# Installations
#   - curl
# Terminals Availables
#   - bash
#   - zsh

### VARIABLES ###
nvm_repository="https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh"
bashrc_path="/home/$USER/.bashrc"
zshrc_path="/home/$USER/.zshrc"
snippetToExportNvm='export NVM_DIR=\"$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \n \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm'

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

############ PROGRAM ############

### CURL ###
if ! [ -x "$(command -v curl)" ]; then
    warningMessage 'Curl is not installed.'
    installCurl
    successMessage "Curl is installed" "  "
else
    successMessage "Curl is installed"
fi

### DOWNLOAD AND INSTALL ###
if ! [ -x "/home/maria/.nvm" ]; then
    warningMessage 'nvm is not installed.'
    curl -o- $nvm_repository | bash
    successMessage "nvm is installed" "  "
else
    successMessage "nvm is installed"
fi 

### CONFIGURE ZSH ###
if  [ -f $zshrc_path ]; then
    if [ -z "cat $zshrc_path | grep \"NVM_DIR\"" ]; then
        echo $snippetToExportNvm >> $zshrc_path
        successMessage "Zsh is configured"
    fi
fi 

### CONFIGURE BASH ###
if [ -f $bashrc_path ]; then
    if [ -z "cat $bashrc_path | grep \"NVM_DIR\"" ]; then        
        echo $snippetToExportNvm >> $bashrc_path
        successMessage "Bash is configured"
    fi
fi 