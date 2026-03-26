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
    packages=("zsh" "tmux" "ghostty" "wezterm" "git" "starship")

    # Add macos package only on macOS
    if [[ "$OS" == "darwin" ]]; then
        packages+=("macos")
    fi

    BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    backup_all=false
    skip_all=false

    # Stow each package
    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            echo "Stowing $package..."

            # Temporarily disable exit-on-error to handle stow failures gracefully
            set +e
            stow_output=$(stow -v -t "$HOME" "$package" 2>&1)
            stow_status=$?
            set -e

            if [ $stow_status -ne 0 ]; then
                echo "Stow failed with exit code: $stow_status"
                echo "Output was:"
                echo "$stow_output"

                # Check if it's a conflict error
                set +e
                echo "$stow_output" | grep -q "existing target" 2>/dev/null
                has_conflicts=$?
                set -e

                if [ $has_conflicts -eq 0 ]; then
                    # Extract conflicting files - stow format is "... over existing target <filename> since ..."
                    conflicts=$(echo "$stow_output" | grep "existing target" 2>/dev/null | sed -E 's/.*existing target ([^ ]+).*/\1/')

                    echo "DEBUG: Found conflicts:"
                    echo "$conflicts"

                    while IFS= read -r conflict; do
                        [ -z "$conflict" ] && continue
                        echo "DEBUG: Processing conflict: '$conflict'"

                        # Skip if user chose skip all
                        if [ "$skip_all" = true ]; then
                            echo "Skipping $conflict"
                            continue
                        fi

                        # Auto backup if user chose backup all
                        if [ "$backup_all" = false ]; then
                            echo "File $conflict already exists."
                            read -p "Backup and override? (y)es/(n)o/(a)ll yes/(s)kip all: " -n 1 -r choice < /dev/tty
                            echo

                            case "$choice" in
                                a|A)
                                    backup_all=true
                                    ;;
                                s|S)
                                    skip_all=true
                                    echo "Skipping $conflict and all remaining conflicts"
                                    continue
                                    ;;
                                n|N)
                                    echo "Skipping $conflict"
                                    continue
                                    ;;
                                y|Y)
                                    ;;
                                *)
                                    echo "Invalid choice, skipping $conflict"
                                    continue
                                    ;;
                            esac
                        fi

                        # Create backup directory if it doesn't exist
                        if [ ! -d "$BACKUP_DIR" ]; then
                            mkdir -p "$BACKUP_DIR"
                            echo "Created backup directory: $BACKUP_DIR"
                        fi

                        # Backup the conflicting file
                        target_file="$HOME/$conflict"
                        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
                            backup_path="$BACKUP_DIR/$conflict"
                            mkdir -p "$(dirname "$backup_path")"
                            mv "$target_file" "$backup_path"
                            echo "Backed up $conflict to $BACKUP_DIR/$conflict"
                        fi
                    done <<< "$conflicts"

                    # Retry stowing after handling conflicts
                    if [ "$skip_all" = false ]; then
                        echo "Retrying stow for $package..."
                        set +e
                        stow -v -t "$HOME" "$package" 2>&1 || {
                            echo "Warning: Failed to stow $package after backup"
                        }
                        set -e
                    fi
                else
                    echo "Warning: Failed to stow $package"
                    echo "$stow_output"
                fi
            fi
        fi
    done

    echo "Stowing complete!"
    if [ -d "$BACKUP_DIR" ]; then
        echo "Backup files saved to: $BACKUP_DIR"
    fi
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

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
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

