#!/bin/sh

init() {
    echo "Starting configuration for macOS"
    install_homebrew
    install_iterm
    install_rectangle
    fix_home_and_end_keys
}

install_slack() {
    echo "Installing Slack"

    # download latest Slack disk image
    curl --location "https://slack.com/api/desktop.latestRelease?arch=universal&variant=dmg&redirect=true" \
        --output Slack.dmg

    # mount downloaded disk image
    hdiutil attach Slack.dmg -nobrowse -readonly

    echo "copying Slack to /Applications"
    cp -R /Volumes/Slack/Slack.app /Applications/

    # unmount disk image
    hdiutil detach /Volumes/Slack/ -force
}

install_homebrew() {
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_iterm() {
    echo "Installing iterm2"
    brew install iterm2
    echo "Please import the settings manually into iTerm!"
}

install_rectangle() {
    echo "Installing rectangle"
    brew install rectangle
}

fix_home_and_end_keys() {
    echo "Fix home and end keys"
    if [ ! -f "$HOME/Library/KeyBindings/DefaultKeyBinding.dict" ]; then
        mkdir -p "$HOME/Library/KeyBindings/"
        cp macos/DefaultKeyBinding.dict "$HOME/Library/KeyBindings/"
    fi
}

install_firefox() {
    echo "Installing Firefox"

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
    echo "Installing VS Code"

    curl --location "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal" \
        --output VSCode.zip
    unzip VSCode.zip
    mv "Visual Studio Code.app" /Applications
    rm VSCode.zip
}

install_postman() {
    echo "Installing Postman"

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
    unzip SpotifyInstaller.zip && rm SpotifyInstaller.zip
    echo "⚠️ Spotify was downloaded, but you need to install it manually!"
    open "Install Spotify.app" &
}

install_docker() {
    echo "Installing Docker Desktop"
    brew install --cask docker
}

install_1password() {
    echo "Downloading 1Password"
    curl -O https://downloads.1password.com/mac/1Password.zip
    unzip 1Password.zip && rm 1Password.zip
    echo "⚠️ 1Password was downloaded, but you need to install it manually!"
    open "1Password Installer.app" &
}

install_cli_tools() {
    echo "Installing CLI tools"
    brew install the_silver_searcher font-hack-nerd-font tmux vim nvim jq direnv
}

