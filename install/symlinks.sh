#!/usr/bin/env bash
# =============================================================================
# symlinks.sh — Create symlinks from dotfiles repo to their target locations
# Called by bootstrap.sh; safe to re-run
# =============================================================================

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date '+%Y%m%d_%H%M%S')"

link() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$2"
  local dir
  dir="$(dirname "$dst")"

  mkdir -p "$dir"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$2")"
    mv "$dst" "$BACKUP_DIR/$2"
    echo "  backed up ~/$2 → $BACKUP_DIR/$2"
  fi

  ln -sf "$src" "$dst"
  echo "  ✓ ~/$2"
}

echo "  Creating symlinks..."

# Zsh
link "zsh/.zshrc"          ".zshrc"
link "zsh/.zprofile"       ".zprofile"

# Git
link "git/.gitconfig"           ".gitconfig"
link "git/.gitignore_global"    ".gitignore_global"

# SSH
link "ssh/config"          ".ssh/config"
chmod 600 "$HOME/.ssh/config" 2>/dev/null || true

# Starship
link "config/starship.toml"     ".config/starship.toml"

# Tmux
link "config/tmux/tmux.conf"    ".config/tmux/tmux.conf"

# Neovim
link "config/nvim"              ".config/nvim"

# Claude Code
link "config/claude/CLAUDE.md"  ".claude/CLAUDE.md"
link "config/claude/settings.json" ".claude/settings.json"

# Ruff
link "config/ruff/ruff.toml"    ".config/ruff/ruff.toml"

# Pip
link "config/pip/pip.conf"      ".config/pip/pip.conf"

echo "  Done. Backups (if any) saved to $BACKUP_DIR"
