# =============================================================================
# aliases.zsh — Shell aliases
# =============================================================================

# ── Modern CLI replacements ───────────────────────────────────────────────────
alias cat='bat --paging=never'
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons -L 2'
alias vim='nvim'
alias vi='nvim'
alias find='fd'
alias grep='rg'

# ── Navigation ────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias ws='cd ~/workspace'

# ── Git shortcuts ─────────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gwip='git add -A && git commit -m "wip"'
alias gundo='git reset HEAD~1 --soft'

# ── Python / uv ───────────────────────────────────────────────────────────────
alias py='python'
alias py3='python3'
alias pip='uv pip'
alias venv='uv venv'
alias pipi='uv pip install'
alias pipir='uv pip install -r requirements.txt'

# ── Data Science ─────────────────────────────────────────────────────────────
alias jnb='jupyter notebook'
alias jlab='jupyter lab'
alias ddb='duckdb'
alias ipy='ipython'

# ── Claude Code ───────────────────────────────────────────────────────────────
alias cc='claude'
alias ccc='claude --continue'

# ── LLM CLI ───────────────────────────────────────────────────────────────────
alias ask='llm prompt'

# ── Docker ────────────────────────────────────────────────────────────────────
alias dk='docker'
alias dkc='docker compose'
alias dkps='docker ps'
alias dkpsa='docker ps -a'

# ── Kubernetes ────────────────────────────────────────────────────────────────
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kl='kubectl logs'

# ── Homebrew ─────────────────────────────────────────────────────────────────
alias brewup='brew update && brew upgrade && brew cleanup'

# ── System ────────────────────────────────────────────────────────────────────
alias reload='source ~/.zshrc'
alias dotfiles='cd ~/dotfiles'
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -i -P -n | grep LISTEN'
alias ip='curl -s ifconfig.me'
alias myip='ipconfig getifaddr en0'
