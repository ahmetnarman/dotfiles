# =============================================================================
# .zshrc — Ahmet Narman
# =============================================================================

# ── PATH ─────────────────────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"         # pipx binaries
export PATH="$HOME/bin:$PATH"

# ── Homebrew ──────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── pyenv ─────────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ── uv ───────────────────────────────────────────────────────────────────────
export PATH="$HOME/.cargo/bin:$PATH"  # uv installs here on some systems

# ── History ──────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_VERIFY

# ── Completion ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ── Key bindings ─────────────────────────────────────────────────────────────
bindkey -e  # emacs-style (Ctrl+A, Ctrl+E, etc.)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── fzf ──────────────────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ── zoxide (smart cd) ────────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# ── Source aliases and functions ─────────────────────────────────────────────
[[ -f "$HOME/dotfiles/zsh/aliases.zsh" ]]   && source "$HOME/dotfiles/zsh/aliases.zsh"
[[ -f "$HOME/dotfiles/zsh/functions.zsh" ]] && source "$HOME/dotfiles/zsh/functions.zsh"

# ── Starship prompt ──────────────────────────────────────────────────────────
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# ── Editor ───────────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# ── Python / Data Science env vars ───────────────────────────────────────────
export PYTHONDONTWRITEBYTECODE=1   # no __pycache__ clutter
export PYTHONUNBUFFERED=1

# ── Local overrides (machine-specific, not in git) ───────────────────────────
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local" || true
