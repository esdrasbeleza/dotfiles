#!/bin/bash
set -e

source functions_global.sh

OS=`( lsb_release -ds || cat /etc/*release || uname -o ) 2>/dev/null | head -n1 | tr '[:upper:]' '[:lower:]'`
ARCH=$(uname -p)

if [[ "$OS" =~ ^darwin ]]; then
    OS="darwin"
    source functions_macos.sh
elif [[ "$OS" =~ ^ubuntu ]]; then
    OS="linux-ubuntu"
    source functions_linux_ubuntu.sh
elif [[ "$OS" =~ ^debian ]]; then
    if grep -qi "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
        OS="linux-debian-raspberry"
        source functions_linux_debian_raspberry.sh
    else
        OS="linux-debian"
        source functions_linux_debian.sh
    fi
elif [[ -f "/etc/arch-release" ]]; then
    OS="linux-arch"
    source functions_linux_arch.sh || exit 1
else
    echo "Not supported"
    exit 1
fi

# Those functions must be implemented in functions_*.sh files,
# since they have a different implementation for each platform
init
install_cli_tools
install_go
install_stow
install_asdf
install_ohmyzsh
install_ohmytmux
install_nordtmux
install_1password

if ! grep -qi "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
    install_ghostty
    install_slack
    install_firefox
    install_vscode
    install_postman
    install_docker
fi

migrate_git_config
stow_configs
finish

echo "Finished. You might need to restart your system to reload some settings."
