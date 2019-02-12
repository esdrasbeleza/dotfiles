#!/bin/sh
if [ ! -d "$HOME/.oh-my-zsh"]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	cat zshrc > ~/.zshrc
fi

