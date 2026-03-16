#!/usr/bin/env bash
# =============================================================================
# defaults.sh — macOS system preferences via `defaults write`
# =============================================================================

echo "  Applying macOS preferences..."

# Close System Preferences to avoid conflicts
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# ── Dock ─────────────────────────────────────────────────────────────────────
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true

# ── Finder ───────────────────────────────────────────────────────────────────
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true          # show hidden files
defaults write NSGlobalDomain AppleShowAllExtensions -bool true       # show all extensions
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # search current folder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"  # list view
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # no .DS_Store on network

# ── Keyboard ─────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # disable smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # disable smart dashes
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # disable autocorrect

# ── Trackpad ─────────────────────────────────────────────────────────────────
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true  # tap to click
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false  # natural scroll off

# ── Screenshots ──────────────────────────────────────────────────────────────
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# ── Activity Monitor ─────────────────────────────────────────────────────────
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0  # all processes

# ── TextEdit ─────────────────────────────────────────────────────────────────
defaults write com.apple.TextEdit PlainTextMode -bool true
defaults write com.apple.TextEdit RichText -bool false

# ── Restart affected apps ─────────────────────────────────────────────────────
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo "  ✓ macOS defaults applied (some require logout to take effect)"
