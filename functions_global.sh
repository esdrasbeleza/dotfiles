#!/bin/bash

# Those functions work in macOS or Linux

DOTFILES=`pwd`

install_stow() {
    if command -v stow &> /dev/null ; then
        echo "GNU Stow is already installed"
        return
    fi

    echo "Installing GNU Stow"

    if [[ "$OS" == "darwin" ]]; then
        brew install stow
    elif [[ "$OS" == "linux-arch" ]]; then
        sudo pacman -S --noconfirm stow
    elif [[ "$OS" == "linux-ubuntu" ]]; then
        sudo apt-get update
        sudo apt-get install -y stow
    fi
}

stow_configs() {
    echo "Stowing configuration files..."

    cd "$DOTFILES"

    # Array of packages to stow
    packages=("zsh" "tmux" "ghostty" "wezterm")

    # Add macos package only on macOS
    if [[ "$OS" == "darwin" ]]; then
        packages+=("macos")
    fi

    # Stow each package
    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            echo "Stowing $package..."
            stow -v -t "$HOME" "$package" 2>&1 || {
                echo "Warning: Failed to stow $package (this may be normal if files already exist)"
            }
        fi
    done

    echo "Stowing complete!"
}

install_ohmyzsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh unattended"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    fi
}

install_ohmytmux() {
    if [ ! -d "$HOME/.tmux" ]; then
        echo "Installing oh-my-tmux"
        git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
        ln -s -f "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
    fi
}

install_nordtmux() {
    if [ ! -d "$HOME/.tmux/themes/nord-tmux" ]; then
        echo "Installing nord-tmux"
        git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/themes/nord-tmux
    fi
}

setup_git() {
  git config --global user.name "Esdras Beleza"
  git config --global --add --bool push.autoSetupRemote true

  # List branches
	git config --global alias.lb "for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:iso8601) %(refname:short)'"

  # Use "main" as default branch name
  git config --global init.defaultBranch main

  # Always use SSH for GitHub
  git config --global url.ssh://git@github.com/.insteadOf https://github.com/
}

