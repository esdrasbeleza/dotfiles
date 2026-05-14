# dotfiles

A set of scripts and configuration files to configure new computers using GNU Stow for dotfile management.

They work on macOS and Ubuntu so far.

## What they do

- Install GNU Stow and use it to symlink configuration files
- Install the command line tools that I like to use (tmux, neovim, jq, silversearcher)
- Install and configure zsh and tmux
- Install go
- Install Postman
- Install Firefox
- Download 1Password (part of the instalation needs to be manual on macOS)

### on macOS:

- Install homebrew
- Install Ghostty terminal
- Install Rectangle
- Configure home and end keys
- Add the apps above to the dock

## Usage

Simply run:

```bash
./apply.sh
```

This will install all applications and use GNU Stow to symlink your configuration files.

## Structure

Configuration files are organized into Stow packages:

- `zsh/` - ZSH configuration (.zshrc)
- `tmux/` - tmux configuration (.tmux.conf.local)
- `ghostty/` - Ghostty terminal configuration
- `git/` - Git configuration with delta integration
- `macos/` - macOS-specific configurations (KeyBindings)

Each package directory mirrors your home directory structure. GNU Stow creates symlinks from your home directory to these files.
