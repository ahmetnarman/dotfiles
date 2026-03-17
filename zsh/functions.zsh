# =============================================================================
# functions.zsh — Shell functions
# =============================================================================

# ── brew install + auto-update Brewfile ──────────────────────────────────────
# Use `brewi` instead of `brew install` to keep Brewfile in sync
brewi() {
  brew install "$@" && \
  brew bundle dump --force --file="$HOME/dotfiles/Brewfile" && \
  echo "✓ Brewfile updated" && \
  (cd "$HOME/dotfiles" && git add Brewfile && git commit -m "chore: add $* to Brewfile" 2>/dev/null || true)
}

# ── Create and activate a new uv venv ────────────────────────────────────────
mkenv() {
  local python_version="${1:-3.12}"
  uv venv --python "$python_version" && source .venv/bin/activate
  echo "✓ venv created with Python $python_version"
}

# ── Smart venv activation (looks up directory tree) ──────────────────────────
activate() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      echo "✓ Activated $dir/.venv"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  echo "No .venv found in current or parent directories"
  return 1
}

# ── Quick Python script runner with uv inline deps ───────────────────────────
# Usage: pyrun script.py pandas numpy
pyrun() {
  local script="$1"; shift
  uv run --with "$*" "$script"
}

# ── Create a new DS project ──────────────────────────────────────────────────
new-ds-project() {
  bash "$HOME/dotfiles/scripts/new-ds-project.sh" "$@"
}

# ── Extract any archive ───────────────────────────────────────────────────────
extract() {
  case "$1" in
    *.tar.bz2) tar xjf "$1"   ;;
    *.tar.gz)  tar xzf "$1"   ;;
    *.bz2)     bunzip2 "$1"   ;;
    *.gz)      gunzip "$1"    ;;
    *.tar)     tar xf "$1"    ;;
    *.zip)     unzip "$1"     ;;
    *.7z)      7z x "$1"      ;;
    *)         echo "Unknown archive format: $1" ;;
  esac
}

# ── Pretty-print JSON ─────────────────────────────────────────────────────────
json() { echo "$1" | jq .; }

# ── Quick HTTP server in current directory ───────────────────────────────────
serve() {
  local port="${1:-8000}"
  python -m http.server "$port"
}

# ── Open Jupyter Lab in current directory ────────────────────────────────────
lab() {
  local port="${1:-8888}"
  jupyter lab --port="$port" --no-browser &
  sleep 2 && open "http://localhost:$port"
}

# ── Show top 10 largest files in directory ───────────────────────────────────
biggest() {
  du -sh ./* | sort -rh | head -10
}

# ── DuckDB quick query on a CSV/Parquet ──────────────────────────────────────
# Usage: dq "SELECT * FROM 'data.csv' LIMIT 5"
dq() {
  duckdb -c "$1"
}
