#!/bin/bash

install_snap() {
    if [[ ! -d "/snap" ]] ; then
        sudo ln -s /var/lib/snapd/snap /snap
    fi
    if command -v snap &> /dev/null ; then
        echo "snap is already installed, skipping"
        return
    fi
    git clone https://aur.archlinux.org/snapd.git ./snapd
    makepkg -D snapd -f -i -s --noconfirm && rm -rf ./snapd
    sudo systemctl enable snapd.socket
    sudo systemctl start snapd.socket
    sudo systemctl enable --now snapd.apparmor
}


install_zsh() {
    echo "Installing Zsh"
    sudo pacman -S --noconfirm zsh
    chsh -s $(which zsh)
}

init() {
    echo "Starting system update for Arch Linux"
    sudo pacman -Sy --noconfirm
    sudo pacman -S --noconfirm apparmor base-devel git
    sudo systemctl enable apparmor
    sudo systemctl start apparmor
    install_snap
    install_zsh
}

finish() {
    # Functions to be executed in the end of configuration
    echo "" >> /dev/null
}

install_cli_tools() {
    echo "Installing CLI tools"
    sudo pacman -S  --noconfirm the_silver_searcher tmux vim neovim jq direnv ttf-hack-nerd git shellcheck ripgrep fd sqlite python lua stylua lua-language-server
}

install_go() {
    echo "Installing Go"
    sudo pacman -S  --noconfirm go
}

install_slack() {
    if command -v slack &> /dev/null ; then
        echo "Slack is already installed, skipping"
        return
    fi
    echo "Installing Slack"
    sudo snap install slack
}

install_firefox() {
    if command -v firefox &> /dev/null ; then
        echo "Firefox is already installed, skipping"
        return
    fi
    echo "Installing Firefox"
    sudo pacman -S --noconfirm firefox
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
    sudo pacman -S --noconfirm docker
    sudo usermod -aG docker $USER
    newgrp docker
}

install_1password() {
    if command -v 1password &> /dev/null ; then
        echo "1Password is already installed, skipping"
        return
    fi
    echo "Installing 1Password"
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
    git clone https://aur.archlinux.org/1password.git
    makepkg -D 1password -f -i -s --noconfirm && rm -rf ./1password
}

install_ghostty() {
    if command -v ghostty &> /dev/null ; then
        echo "Ghostty is already installed, skipping"
        return
    fi
    echo "Installing Ghostty"
    sudo pacman -S --noconfirm ghostty
}

