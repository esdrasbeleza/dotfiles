#!/bin/bash

install_stow() {
    if command -v stow &> /dev/null ; then
        echo "GNU Stow is already installed"
        return
    fi
    echo "Installing GNU Stow"
    sudo apt install -y stow
}

init() {
    echo "Starting system update for Debian"
    install_zsh
}

finish() {
    echo "" >> /dev/null
}

install_cli_tools() {
    echo "Installing CLI tools"
    sudo apt install -y silversearcher-ag tmux vim neovim jq direnv fonts-hack git shellcheck ripgrep fd-find sqlite3 python3 python3-pip bat

    if ! command -v zoxide &> /dev/null ; then
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi

    if ! command -v eza &> /dev/null ; then
        ARCH=$(dpkg --print-architecture)
        if [ "$ARCH" = "arm64" ]; then
            curl -Lo /tmp/eza.deb "https://github.com/eza-community/eza/releases/latest/download/eza_aarch64-unknown-linux-gnu.tar.gz"
            tar xzf /tmp/eza.deb
            sudo install eza /usr/local/bin
            rm eza /tmp/eza.deb
        else
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
            sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
            sudo apt update
            sudo apt install -y eza
        fi
    fi

    if ! command -v delta &> /dev/null ; then
        ARCH=$(dpkg --print-architecture)
        DELTA_VERSION="0.19.1"
        if [ "$ARCH" = "arm64" ]; then
            wget -qO- "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_arm64.deb" -O /tmp/delta.deb
        else
            wget -qO- "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -O /tmp/delta.deb
        fi
        sudo dpkg -i /tmp/delta.deb
        rm /tmp/delta.deb
    fi

    if ! command -v lazygit &> /dev/null ; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
        ARCH=$(dpkg --print-architecture)
        if [ "$ARCH" = "arm64" ]; then
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_arm64.tar.gz"
        else
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        fi
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    fi

    if ! command -v starship &> /dev/null ; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
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

install_asdf() {
    if [ -d "$HOME/.asdf" ]; then
        echo "asdf is already installed, skipping"
        return
    fi
    echo "Installing asdf"
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.1
}
