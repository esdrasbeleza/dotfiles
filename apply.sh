#!/bin/sh
source functions_global.sh

OS=`( lsb_release -ds || cat /etc/*release || uname -o ) 2>/dev/null | head -n1 | tr '[:upper:]' '[:lower:]'`
ARCH=`uname -p`

if [[ "$OS" =~ ^darwin ]]; then
    OS="darwin"
    source functions_macos.sh
elif [[ "$OS" =~ ^linux ]]; then
    OS="linux"
    # TODO
else
    echo "Not supported"
    exit 1
fi

init
install_cli_tools
install_go
install_zsh
install_slack
install_ohmytmux
install_nordtmux
install_firefox
install_vscode
install_postman
install_spotify
install_docker
install_1password

echo "Finished. You might need to restart your system to reload some settings."
