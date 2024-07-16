#!/bin/sh


init() {
    echo "Starting configuration for macOS"
    install_homebrew
    install_iterm
    install_rectangle
    fix_home_and_end_keys
}

install_homebrew() {
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_iterm() {
    echo "Installing iterm2"
    brew install iterm2
    echo "Configuring iterm2"
    defaults read macos/com.googlecode.iterm2.plist
}

install_rectangle() {
    echo "Installing rectangle"
    brew install rectangle
}

fix_home_and_end_keys() {
    echo "Fix home and end keys"
    if [ ! -f "" ]; then
        mkdir -p ~/Library/KeyBindings/
        cp macos/DefaultKeyBinding.dict ~/Library/KeyBindings/
    fi
}

install_firefox() {
    # Based on https://scriptingosx.com/2021/09/scripting-macos-part-7-download-and-install-firefox/

    # download latest Firefox disk image
    curl --location "https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US" \
        --output Firefox.dmg

    # mount downloaded disk image
    hdiutil attach Firefox.dmg -nobrowse -readonly

    # copy Firefox application to /Applications
    echo "copying Firefox to /Applications"
    cp -R /Volumes/Firefox/Firefox.app /Applications/

    # unmount disk image
    hdiutil detach /Volumes/Firefox/ -force
}

install_vscode() {
    curl --location "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal" \
        --output VSCode.zip
    unzip VSCode.zip
    mv "Visual Studio Code.app" /Applications
    rm VSCode.zip
}

install_postman() {
    if [[ "$ARCH" == "arm"  ]]; then
        curl --location "https://dl.pstmn.io/download/latest/osx_arm64" --output postman.zip
    else
        curl --location "https://dl.pstmn.io/download/latest/osx_64" --output postman.zip
    fi
    unzip postman.zip
    mv Postman.app /Applications/
    rm postman.zip
}

install_spotify() {
    echo "Downloading Spotify"
    curl -O https://download.scdn.co/SpotifyInstaller.zip
    unzip SpotifyInstaller.zip
    echo "⚠️ Spotify was downloaded, but you need to install it manually!"
}

install_docker() {
    brew install --cask docker
}

install_1password() {
    echo "Downloading 1Password"
    curl -O https://downloads.1password.com/mac/1Password.zip
    unzip 1Password.zip
    echo "⚠️ 1Password was downloaded, but you need to install it manually!"
}

install_cli_tools() {
    echo "Installing CLI tools"
    brew install the_silver_searcher font-hack-nerd-font tmux vim nvim jq direnv
}

