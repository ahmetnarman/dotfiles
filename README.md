# dotfiles

Personal dotfiles for Ahmet Narman — Senior Data Scientist / ML Engineer.

Designed for macOS (Apple Silicon), Python-first, AI-workflow-aware.

![Bootstrap Test](https://github.com/ahmetnarman/dotfiles/actions/workflows/bootstrap-test.yml/badge.svg)

---

## Quick Start (New Machine)

```bash
git clone https://github.com/ahmetnarman/dotfiles.git ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

That's it. One command. ~10 minutes. Fully configured machine.

---

## What Gets Installed

### Homebrew Packages

| Category | Tools |
|---|---|
| **Shell** | `zsh`, `starship`, `tmux` |
| **Python** | `pyenv`, `uv`, `pipx`, `miniforge` |
| **Data / ML** | `duckdb`, `jq`, `yq` |
| **Dev** | `git`, `git-lfs`, `gh`, `pre-commit`, `act` |
| **Code quality** | `ruff` |
| **AI / LLM** | `ollama`, `node` (for MCP servers) |
| **Cloud** | `awscli`, `google-cloud-sdk`, `terraform`, `kubectl`, `helm`, `k9s` |
| **Terminal utils** | `bat`, `eza`, `fd`, `ripgrep`, `fzf`, `zoxide`, `delta`, `btop`, `htop`, `hyperfine`, `watch`, `wget`, `curl`, `tree` |
| **Editor** | `neovim` |
| **Apps (casks)** | VS Code, Cursor, WezTerm, Raycast, 1Password, Rectangle, Docker Desktop, miniforge, Google Cloud SDK |

### Python Global Tools (via pipx)

`ruff` · `mypy` · `pre-commit` · `nbstripout` · `llm` · `visidata` · `datasette` · `csvkit` · `ipython`

---

## What's Configured

| File / Dir | Purpose |
|---|---|
| `bootstrap.sh` | One-command Mac setup — idempotent, safe to re-run |
| `Brewfile` | Single source of truth for all installed packages |
| `install/symlinks.sh` | Links all dotfiles to their target locations (backs up existing files) |
| `install/python.sh` | Installs Python 3.12 via pyenv + all global pipx tools |
| `macos/defaults.sh` | Dock, Finder, keyboard, trackpad, screenshots preferences |
| `zsh/.zshrc` | PATH, pyenv, fzf, zoxide, starship, history settings |
| `zsh/.zprofile` | Login shell PATH (for GUI apps) |
| `zsh/aliases.zsh` | Modern CLI replacements, git shortcuts, DS/ML aliases, Claude Code shortcuts |
| `zsh/functions.zsh` | `brewi`, `mkenv`, `activate`, `new-ds-project`, `dq`, `lab`, and more |
| `git/.gitconfig` | delta pager, git-lfs, nbstripout filter, useful aliases |
| `git/.gitignore_global` | Global ignores: macOS, Python, Jupyter, ML artifacts, secrets |
| `ssh/config` | Multiplexing, key agent, `ServerAliveInterval` for long remote jobs |
| `config/starship.toml` | Prompt: git status, Python env, AWS profile, command duration |
| `config/tmux/tmux.conf` | Session persistence (TPM + resurrect), vi keys, Ctrl+A prefix |
| `config/nvim/init.lua` | Minimal Neovim: lazy.nvim, LSP (pyright + ruff), telescope, treesitter |
| `config/claude/CLAUDE.md` | **Global AI memory** — coding preferences baked into every Claude session |
| `config/claude/settings.json` | MCP servers: filesystem, github, sqlite |
| `config/ruff/ruff.toml` | Global Python linting defaults (line length 100, Python 3.11+) |
| `config/pip/pip.conf` | pip timeout and binary preference settings |
| `scripts/new-ds-project.sh` | Scaffolds a full DS/ML project in one command |
| `scripts/update.sh` | Pull latest dotfiles + sync Brewfile + re-apply symlinks |
| `templates/.pre-commit-config.yaml` | Reusable pre-commit config (ruff, nbstripout, standard hooks) |
| `.github/workflows/bootstrap-test.yml` | CI: verifies full bootstrap on a fresh macOS runner on every push |

---

## Keeping It Up to Date

### Installing new packages

Use `brewi` instead of `brew install` — it installs, updates the Brewfile, and commits automatically:

```bash
brewi htop          # installs + updates Brewfile + git commits
```

### Syncing dotfiles across machines

```bash
bash ~/dotfiles/scripts/update.sh
```

Pulls latest changes, re-applies symlinks, and syncs the Brewfile.

### Editing dotfiles

All config files are **symlinked** from `~/dotfiles/` to their target locations. Editing them in place edits the repo file directly. Commit when happy:

```bash
cd ~/dotfiles
git add config/starship.toml
git commit -m "feat: tweak starship prompt"
git push
```

---

## New DS/ML Project

```bash
new-ds-project my-analysis
```

Scaffolds instantly:

```
my-analysis/
├── pyproject.toml        # ruff, mypy, pytest configured
├── .python-version       # pyenv pin
├── .pre-commit-config.yaml
├── src/my_analysis/
├── notebooks/
├── data/{raw,processed,external}/
├── models/
└── tests/conftest.py
```

Also runs `uv venv`, installs dev dependencies, and sets up pre-commit hooks.

---

## Manual Steps After Bootstrap

The bootstrap script handles everything automatically except:

1. **Change default shell** (if `chsh` failed — requires password):
   ```bash
   chsh -s /opt/homebrew/bin/zsh
   ```
2. **Restart terminal** to load the new shell config
3. **Sign into 1Password** and sync secrets
4. **Add SSH key to GitHub**: Settings → SSH Keys → paste output of:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
5. **Authenticate GitHub CLI**:
   ```bash
   gh auth login
   ```
6. **Fill in API keys**: copy `.env.example` to `~/.env` and add keys for Anthropic, OpenAI, AWS, etc.

---

## CI

Every push runs a full bootstrap test on a fresh `macos-latest` GitHub Actions runner, verifying:

- All 37 Homebrew packages install correctly
- All 12 symlinks are created
- Python 3.12 is active via pyenv
- All pipx tools are available
- macOS defaults apply without error

View runs: [github.com/ahmetnarman/dotfiles/actions](https://github.com/ahmetnarman/dotfiles/actions)
