# dotfiles

Personal dotfiles for Ahmet Narman — Senior Data Scientist / ML Engineer.

Designed for macOS, Python-first, AI-workflow-aware.

## Quick Start (New Machine)

```bash
git clone https://github.com/ahmetnarman/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

That's it. The bootstrap script handles everything.

---

## What's Included

| File/Dir | Purpose |
|---|---|
| `Brewfile` | All Homebrew packages (formulae + casks) |
| `bootstrap.sh` | One-command setup for a new Mac |
| `zsh/` | `.zshrc`, `.zprofile`, `aliases.zsh`, `functions.zsh` |
| `git/` | `.gitconfig` (delta, LFS, nbstripout), `.gitignore_global` |
| `ssh/config` | SSH multiplexing, key agent, common hosts |
| `config/starship.toml` | Prompt: git, python env, AWS profile, command duration |
| `config/tmux/tmux.conf` | Session persistence, vi keys, TPM plugins |
| `config/claude/CLAUDE.md` | Global AI memory — preferences baked into every session |
| `config/claude/settings.json` | MCP servers (filesystem, github, sqlite) |
| `config/ruff/ruff.toml` | Global Python linting defaults |
| `macos/defaults.sh` | Dock, Finder, keyboard, trackpad preferences |
| `scripts/new-ds-project.sh` | Scaffold a new DS project in one command |
| `scripts/update.sh` | Pull latest + sync everything |

---

## Keeping It Up to Date

### Installing new packages

Use `brewi` instead of `brew install` — it automatically updates the Brewfile and commits:

```bash
brewi <package-name>
```

### Syncing a new machine with your latest setup

```bash
bash ~/dotfiles/scripts/update.sh
```

### Editing dotfiles

All config files are **symlinked** from `~/dotfiles/` to their target locations. Editing them in place edits the repo file directly. Just `git commit` when happy.

---

## New DS Project

```bash
new-ds-project my-analysis
```

Creates a fully configured project with `src/` layout, `pyproject.toml`, `ruff`, `mypy`, `pytest`, `pre-commit`, and a `uv` venv — all ready to go.

---

## Manual Steps After Bootstrap

1. Sign into **1Password** and sync secrets
2. Add SSH key to GitHub: `cat ~/.ssh/id_ed25519.pub`
3. Run `gh auth login` for GitHub CLI
4. Copy `.env.example` to `~/.env` and fill in API keys
