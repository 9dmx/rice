#!/bin/bash
# Restore the Omarchy rice into $HOME
# Usage: ./install.sh
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME:?}"

echo "Backing up any existing configs first..."
mkdir -p "$HOME_DIR/.config-backup-$(date +%s)"

backup_and_copy() {
  local src="$1" dest="$2"
  if [[ -e "$dest" ]]; then
    cp -a "$dest" "$HOME_DIR/.config-backup-$(date +%s)/" 2>/dev/null || true
  fi
  mkdir -p "$(dirname "$dest")"
  cp -a "$DIR/$src" "$dest"
}

# Hyprland + Omarchy
backup_and_copy "hypr" "$HOME_DIR/.config/hypr"
backup_and_copy "omarchy" "$HOME_DIR/.config/omarchy"

# Terminals
backup_and_copy "alacritty" "$HOME_DIR/.config/alacritty"
backup_and_copy "foot" "$HOME_DIR/.config/foot"
backup_and_copy "kitty" "$HOME_DIR/.config/kitty"
backup_and_copy "ghostty" "$HOME_DIR/.config/ghostty"

# Small tool configs
backup_and_copy "fastfetch" "$HOME_DIR/.config/fastfetch"
backup_and_copy "btop" "$HOME_DIR/.config/btop"
backup_and_copy "lazygit" "$HOME_DIR/.config/lazygit"
backup_and_copy "starship.toml" "$HOME_DIR/.config/starship.toml"
backup_and_copy "git" "$HOME_DIR/.config/git"

# Hermes skin
mkdir -p "$HOME_DIR/.hermes/skins"
cp -a "$DIR/hermes-skins/." "$HOME_DIR/.hermes/skins/"

echo "Done! Restarts you may want:"
echo "  omarchy restart shell"
echo "  omarchy theme set snow_black   # or your theme of choice"
echo "  omarchy restart terminal"
