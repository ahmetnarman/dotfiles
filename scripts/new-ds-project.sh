#!/usr/bin/env bash
# =============================================================================
# new-ds-project.sh — Scaffold a new DS/ML project
# Usage: new-ds-project <project-name>
# =============================================================================

set -euo pipefail

PROJECT_NAME="${1:-}"
if [[ -z "$PROJECT_NAME" ]]; then
  echo "Usage: new-ds-project <project-name>"
  exit 1
fi

MODULE_NAME="${PROJECT_NAME//-/_}"  # convert hyphens to underscores
PYTHON_VERSION="3.12"
TARGET="$HOME/workspace/$PROJECT_NAME"

if [[ -d "$TARGET" ]]; then
  echo "Error: $TARGET already exists"
  exit 1
fi

echo "Creating project: $PROJECT_NAME"
mkdir -p "$TARGET"
cd "$TARGET"

# ── Directory structure ───────────────────────────────────────────────────────
mkdir -p \
  src/"$MODULE_NAME" \
  notebooks \
  data/{raw,processed,external} \
  models \
  tests

touch \
  src/"$MODULE_NAME"/__init__.py \
  tests/__init__.py \
  tests/conftest.py \
  notebooks/.gitkeep \
  data/raw/.gitkeep \
  data/processed/.gitkeep \
  data/external/.gitkeep \
  models/.gitkeep

# ── .python-version ───────────────────────────────────────────────────────────
echo "$PYTHON_VERSION" > .python-version

# ── pyproject.toml ───────────────────────────────────────────────────────────
cat > pyproject.toml <<EOF
[build-system]
requires      = ["hatchling"]
build-backend = "hatchling.build"

[project]
name        = "$PROJECT_NAME"
version     = "0.1.0"
description = ""
readme      = "README.md"
requires-python = ">=$PYTHON_VERSION"
dependencies = []

[project.optional-dependencies]
dev = [
  "pytest",
  "pytest-cov",
  "ruff",
  "mypy",
  "ipykernel",
]

[tool.ruff]
line-length    = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "UP", "B", "SIM"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts   = "-v --tb=short"

[tool.mypy]
python_version         = "$PYTHON_VERSION"
ignore_missing_imports = true
EOF

# ── .gitignore ────────────────────────────────────────────────────────────────
cat > .gitignore <<EOF
# Python
__pycache__/
*.py[cod]
.venv/
*.egg-info/
dist/
build/
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/

# Jupyter
.ipynb_checkpoints/

# Data & models (use git-lfs for large files)
data/raw/*
data/processed/*
models/*
!data/raw/.gitkeep
!data/processed/.gitkeep
!models/.gitkeep

# Secrets
.env
.env.*
!.env.example

# macOS
.DS_Store

# ML experiment tracking
mlruns/
wandb/
EOF

# ── .pre-commit-config.yaml ───────────────────────────────────────────────────
cat > .pre-commit-config.yaml <<EOF
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.4.4
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format
  - repo: https://github.com/kynan/nbstripout
    rev: 0.7.1
    hooks:
      - id: nbstripout
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: check-merge-conflict
EOF

# ── README ────────────────────────────────────────────────────────────────────
cat > README.md <<EOF
# $PROJECT_NAME

## Setup

\`\`\`bash
uv venv && source .venv/bin/activate
uv pip install -e ".[dev]"
pre-commit install
\`\`\`

## Structure

\`\`\`
$PROJECT_NAME/
├── src/$MODULE_NAME/    # source code
├── notebooks/           # exploration notebooks
├── data/                # raw, processed, external
├── models/              # saved models
└── tests/               # pytest tests
\`\`\`
EOF

# ── .env.example ──────────────────────────────────────────────────────────────
cat > .env.example <<EOF
# Copy to .env and fill in values — never commit .env
ANTHROPIC_API_KEY=
OPENAI_API_KEY=
AWS_PROFILE=default
EOF

# ── Git init ─────────────────────────────────────────────────────────────────
git init
git add .
git commit -m "feat: initial project scaffold for $PROJECT_NAME"

# ── Python env ────────────────────────────────────────────────────────────────
uv venv --python "$PYTHON_VERSION"
source .venv/bin/activate
uv pip install -e ".[dev]"
pre-commit install

echo ""
echo "✓ Project created at $TARGET"
echo ""
echo "  cd ~/workspace/$PROJECT_NAME"
echo "  source .venv/bin/activate"
echo ""
