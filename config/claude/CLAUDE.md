# Global Claude Code Preferences — Ahmet Narman

## Identity
- Senior Data Scientist / ML Engineer
- Based in London, UK
- Working primarily in Python

## Workspace
- All projects live in `~/workspace/`
- Dotfiles repo: `~/dotfiles/` (symlinked from `~/workspace/dotfiles`)

---

## Python Standards

- **Package management:** always use `uv` (never `pip` directly)
  - Create envs: `uv venv`
  - Install: `uv pip install`
  - Run scripts: `uv run`
- **Formatting & linting:** `ruff` (replaces black, isort, flake8 — one tool)
- **Type hints:** required on all function signatures
- **Tests:** pytest with fixtures in `conftest.py`
- **Minimum Python version:** 3.11

## Preferred Libraries

| Purpose | Library |
|---|---|
| DataFrames | **polars** (prefer over pandas for new code) |
| ML | scikit-learn, pytorch |
| Data validation | pydantic v2 |
| HTTP client | httpx |
| CLI tools | typer |
| Async | asyncio + anyio |
| Experiment tracking | MLflow or W&B |
| Config management | Hydra or pydantic-settings |

## Code Style

- Docstrings: Google style
- Max line length: 100
- Prefer explicit over implicit
- No bare `except:` clauses
- No unnecessary comments — code should be self-documenting
- Keep solutions simple; don't over-engineer

## Project Structure (DS/ML)

```
project/
├── pyproject.toml       # single config file for everything
├── .python-version      # pyenv pin
├── .pre-commit-config.yaml
├── src/
│   └── project_name/
├── notebooks/           # exploration only, never production logic
├── data/
│   ├── raw/
│   ├── processed/
│   └── external/
├── models/
└── tests/
    └── conftest.py
```

## Git Conventions

- Commit style: **conventional commits** (`feat:`, `fix:`, `chore:`, `docs:`, `refactor:`)
- Never commit `.env` files or credentials
- Strip notebook outputs before committing (nbstripout handles this via pre-commit)
- Never force-push to main/master without explicit confirmation

## AI Workflow Notes

- Claude Code is the primary AI coding assistant
- `llm` CLI (Simon Willison) is available for quick one-off queries
- MCP servers configured: filesystem, github, sqlite
- Prefer iterative, incremental changes over large rewrites
