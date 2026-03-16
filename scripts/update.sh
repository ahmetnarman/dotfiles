#!/usr/bin/env bash
# =============================================================================
# update.sh — Pull latest dotfiles and sync everything
# Usage: bash ~/dotfiles/scripts/update.sh
# =============================================================================

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "Updating dotfiles..."

# Pull latest
cd "$DOTFILES"
git pull --rebase origin main && echo "  ✓ Pulled latest changes"

# Re-apply symlinks (handles any new files added)
source "$DOTFILES/install/symlinks.sh"

# Dump current Homebrew state to Brewfile
brew bundle dump --force --file="$DOTFILES/Brewfile"
echo "  ✓ Brewfile updated from current installs"

# Install anything in Brewfile not yet installed
brew bundle --file="$DOTFILES/Brewfile" --no-lock
echo "  ✓ Brew bundle synced"

# Stage and commit Brewfile if changed
cd "$DOTFILES"
if ! git diff --quiet Brewfile; then
  git add Brewfile
  git commit -m "chore: sync Brewfile $(date '+%Y-%m-%d')"
  echo "  ✓ Brewfile changes committed"
fi

echo ""
echo "Done. Run 'source ~/.zshrc' to reload shell config."
