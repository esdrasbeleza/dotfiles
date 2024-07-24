#!/bin/sh

# Those functions work in macOS or Linux

DOTFILES=`pwd`

install_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        cat "$DOTFILES/zshrc" > ~/.zshrc
    fi
}

install_ohmytmux() {
    if [ ! -d "$HOME/.tmux" ]; then
        echo "Installing oh-my-tmux"
        git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
        ln -s -f "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
        cat "$DOTFILES/tmux.conf.local" > ~/.tmux.conf.local
    fi
}

install_nordtmux() {
    if [ ! -d "$HOME/.tmux/themes/nord-tmux" ]; then
        echo "Installing nord-tmux"
        git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/themes/nord-tmux
    fi
}
