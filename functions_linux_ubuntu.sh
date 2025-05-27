#!/bin/bash

init() {
    echo "Starting system update for Ubuntu"
    # sudo apt update -y
    install_zsh
}

finish() {
    # Functions to be executed in the end of configuration
}

install_cli_tools() {
    echo "Installing CLI tools"
    sudo apt install -y silversearcher-ag tmux vim neovim jq direnv fonts-hack-ttf git shellcheck ripgrep fd sqlite python3 python3-pip
}

install_go() {
    echo "Installing Go"
    sudo apt install -y golang-go
}

install_zsh() {
    if command -v zsh &> /dev/null ; then
        echo "Zsh is already installed, skipping"
        return
    fi
    echo "Installing Zsh"
    sudo apt install -y zsh
    chsh -s $(which zsh)
}

install_slack() {
    if command -v slack &> /dev/null ; then
        echo "Slack is already installed, skipping"
        return
    fi
    echo "Installing Slack"
    sudo snap install slack --classic
}

install_firefox() {
    if command -v firefox &> /dev/null ; then
        echo "Firefox is already installed, skipping"
        return
    fi
    echo "Installing Firefox"
    sudo apt install -y firefox
}

install_vscode() {
    if command -v code &> /dev/null ; then
        echo "VS Code is already installed, skipping"
        return
    fi
    echo "Installing Visual Studio Code"
    sudo snap install code --classic
}

install_postman() {
    if command -v postman &> /dev/null ; then
        echo "Postman is already installed, skipping"
        return
    fi
    echo "Installing Postman"
    sudo snap install postman
}

install_spotify() {
    if command -v spotify &> /dev/null ; then
        echo "Spotify is already installed, skipping"
        return
    fi
    echo "Installing Spotify"
    sudo snap install spotify
}

install_docker() {
    if command -v docker &> /dev/null ; then
        echo "Docker is already installed, skipping"
        return
    fi
    echo "Installing Docker"
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
}

install_1password() {
    if command -v 1password &> /dev/null ; then
        echo "1Password is already installed, skipping"
        return
    fi
    echo "Installing 1Password"
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo 'deb [signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/1password.list
    sudo apt update
    sudo apt install -y 1password
}

