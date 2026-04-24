#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlink tmux config (XDG path)
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.config/tmux/tmux.conf"
echo "Linked tmux.conf -> ~/.config/tmux/tmux.conf"

# Install TPM if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "Installed TPM"
fi

# Install plugins
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || {
    echo "Auto-install failed (no tmux server). Start tmux and press prefix + I to install plugins."
}

echo "Done!"
