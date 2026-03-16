# =============================================================================
# .zprofile — Login shell PATH (loaded before .zshrc, needed for GUI apps)
# =============================================================================

eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
