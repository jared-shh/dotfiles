#!/bin/bash
# Symlink dotfiles into place. Existing non-symlink targets are moved aside
# to <target>.pre-dotfiles rather than overwritten.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$DOTFILES/$1" dst="$2"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.pre-dotfiles"
        echo "backed up $dst -> $dst.pre-dotfiles"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "linked $dst -> $src"
}

link zshrc            "$HOME/.zshrc"
link gitconfig        "$HOME/.gitconfig"
link gitignore_global "$HOME/.gitignore_global"
link karabiner        "$HOME/.config/karabiner"

# Git identity stays out of the repo — seed a local file if none exists.
if [ ! -f "$HOME/.gitconfig.local" ]; then
    printf '[user]\n\tname = Your Name\n\temail = you@example.com\n' > "$HOME/.gitconfig.local"
    echo "created ~/.gitconfig.local — edit it with your git name/email"
fi
