#!/bin/sh
DOTFILES=`pwd`

cd $HOME

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	cat "$DOTFILES/zshrc" > ~/.zshrc
fi

if [ ! -d "$HOME/.tmux" ]; then
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
	cat "$DOTFILES/tmux.conf.local" > ~/.tmux.conf.local
fi
