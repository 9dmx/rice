# rice

Backup of my Omarchy Linux rice (Hyprland). Includes:

- `hypr/` — Hyprland config (`~/.config/hypr`)
- `omarchy/` — Omarchy configs, themes (snow_black, black_arch, grudbox), backgrounds, plugins, `shell.json`, hooks
- `alacritty/`, `foot/`, `kitty/`, `ghostty/` — terminal configs
- `fastfetch/`, `btop/`, `lazygit/` — tool configs
- `starship.toml`, `git/` — prompt + git config
- `hermes-skins/` — Hermes Agent `omarchy` skin

> **Note:** `.git` directories of cloned themes/plugins were excluded, so those are restored as plain files — they still work, they're just not git repos anymore.

## Setup (fresh machine)

### 1. Install Omarchy

Follow https://omarchy.org — this rice assumes Omarchy is already installed.

### 2. Download this repo

```bash
git clone https://github.com/9dmx/rice.git
cd rice
```

### 3. Restore

```bash
chmod +x install.sh
./install.sh
```

This copies everything into `~/.config/` and `~/.hermes/skins/`, backing up any existing configs to `~/.config-backup-<timestamp>/` first.

### 4. Apply

```bash
omarchy restart shell
omarchy theme set snow_black
omarchy restart terminal
```

### 5. Optional extras (things that aren't in this repo)

- Hermes skin is applied automatically, but verify with `hermes config get display.skin` → should be `omarchy`
- Third-party plugins (pets, wallpaper manager, notch) are included as files and work as-is

## Updating this backup

Run this to push your current rice to GitHub:

```bash
cd ~/rice
rsync -a --delete --exclude='.git' \
  ~/.config/hypr ~/.config/omarchy ~/.config/foot ~/.config/kitty \
  ~/.config/ghostty ~/.config/alacritty ~/.config/fastfetch ~/.config/btop \
  ~/.config/lazygit ~/.config/starship.toml ~/.config/git ~/rice/ && \
  rsync -a ~/.hermes/skins ~/rice/hermes-skins/
git add -A
git commit -m "rice update $(date +%F)"
git push
```

## What's included

| Path | What it is |
|---|---|
| `omarchy/themes/` | snow_black (main), black_arch, grudbox themes + wallpapers |
| `omarchy/shell.json` | Bar layout, idle settings (screensaver off, lock @ 300s) |
| `omarchy/backgrounds/` | Theme-matched wallpapers |
| `hypr/` | Window rules, keybindings, monitors, gaps |
| `hermes-skins/omarchy.yaml` | Grayscale Hermes skin matching this rice |
