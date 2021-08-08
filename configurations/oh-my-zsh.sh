#!/bin/bash

### VARIABLES ###
plugin_syntax_highlighting="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
plugin_zsh_autosuggestions="$ZSH_CUSTOM/plugins/zsh-autosuggestions"

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

function installPluginsSyntaxHighlighting(){
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugin_syntax_highlighting
}

function installPluginsZshAutoSuggestions(){
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $plugin_zsh_autosuggestions
}

############ PROGRAM ############

# PLUGIN ZSH-SYNTAX-HIGHLIGHTING
if ! [ -x $plugin_syntax_highlighting ]; then 
    warningMessage "plugin plugin_syntax_highlighting is not installed"
    installPluginsSyntaxHighlighting 
    successMessage "plugin plugin_syntax_highlighting is installed" "  "
else
    successMessage "plugin plugin_syntax_highlighting is installed"
fi

# PLUGIN ZSH-AUTOSUGGESTIONS
if ! [ -x $plugin_zsh_autosuggestions ]; then 
    warningMessage "plugin zsh_autosuggestions is not installed"
    installPluginsZshAutoSuggestions 
    successMessage "plugin zsh-autosuggestions is installed" "  "
else
    successMessage "plugin zsh-autosuggestions is installed"
fi

### CONFIGURE .ZSHRC ###
if [ -x "~/.zshrc" ]; then
    mv ~/.zshrc ~/.zshrc_resp
fi

rm ~/.zshrc
cp ../dotfiles/.zshrc ~/.zshrc 
source ~/.zshrc
