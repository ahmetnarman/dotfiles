#!/usr/bin/env bash
# =============================================================================
# bootstrap.sh — One-command Mac setup for Ahmet Narman's dotfiles
# Usage: bash bootstrap.sh
# Safe to re-run (idempotent)
# =============================================================================

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
LOG="$HOME/.dotfiles-bootstrap.log"

# ── Helpers ───────────────────────────────────────────────────────────────────
log()  { echo "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG"; }
ok()   { echo "  ✓ $*"; }
info() { echo "  → $*"; }
warn() { echo "  ! $*"; }

log "Starting dotfiles bootstrap"

# ── Phase 1: Prerequisites ────────────────────────────────────────────────────
log "Phase 1: Prerequisites"

if ! xcode-select -p &>/dev/null; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install
  warn "Xcode CLT install launched. Re-run this script after it completes."
  exit 1
fi
ok "Xcode CLT installed"

if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Ensure brew is in PATH for this session
eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null
ok "Homebrew available"

# ── Phase 2: Clone dotfiles ───────────────────────────────────────────────────
log "Phase 2: Clone dotfiles repo"

if [[ ! -d "$DOTFILES" ]]; then
  info "Cloning dotfiles..."
  git clone https://github.com/ahmetnarman/dotfiles.git "$DOTFILES"
else
  ok "Dotfiles already cloned at $DOTFILES"
fi

# ── Phase 3: Install packages ─────────────────────────────────────────────────
log "Phase 3: Homebrew packages"

info "Running brew bundle (this may take a while)..."
brew bundle --file="$DOTFILES/Brewfile" || warn "Some packages may have failed — check output above"
ok "Brew bundle complete"

# ── Phase 4: Symlinks ─────────────────────────────────────────────────────────
log "Phase 4: Symlinks"
source "$DOTFILES/install/symlinks.sh"

# ── Phase 5: Python environment ───────────────────────────────────────────────
log "Phase 5: Python"
source "$DOTFILES/install/python.sh"

# ── Phase 6: Git identity ─────────────────────────────────────────────────────
log "Phase 6: Git identity"

if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  echo ""
  info "Setting up git identity..."
  read -rp "  Git name  [Ahmet Narman]: " git_name
  git_name="${git_name:-Ahmet Narman}"
  read -rp "  Git email [ahmetnarman@users.noreply.github.com]: " git_email
  git_email="${git_email:-ahmetnarman@users.noreply.github.com}"

  cat > "$HOME/.gitconfig.local" <<EOF
[user]
  name  = $git_name
  email = $git_email
EOF
  ok "Git identity saved to ~/.gitconfig.local"
else
  ok "~/.gitconfig.local already exists"
fi

# ── Phase 7: SSH key ──────────────────────────────────────────────────────────
log "Phase 7: SSH key"

if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
  info "Generating SSH key..."
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "ahmetnarman@users.noreply.github.com" -f "$HOME/.ssh/id_ed25519" -N ""
  ok "SSH key generated"
  echo ""
  warn "Add this public key to GitHub (https://github.com/settings/ssh/new):"
  echo ""
  cat "$HOME/.ssh/id_ed25519.pub"
  echo ""
else
  ok "SSH key already exists"
fi

# ── Phase 8: macOS preferences ────────────────────────────────────────────────
log "Phase 8: macOS preferences"
source "$DOTFILES/macos/defaults.sh" && ok "macOS defaults applied"

# ── Phase 9: Shell ────────────────────────────────────────────────────────────
log "Phase 9: Default shell"

ZSH_PATH="$(brew --prefix)/bin/zsh"
if ! grep -q "$ZSH_PATH" /etc/shells 2>/dev/null; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  chsh -s "$ZSH_PATH"
  ok "Default shell set to Homebrew zsh"
else
  ok "zsh already default shell"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
log "Bootstrap complete! Log saved to $LOG"
echo ""
echo "  Next steps:"
echo "  1. Restart your terminal (or: exec zsh)"
echo "  2. Sign into 1Password and sync secrets"
echo "  3. Add SSH key to GitHub if prompted above"
echo "  4. Run: gh auth login"
echo ""
