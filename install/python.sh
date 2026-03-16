#!/usr/bin/env bash
# =============================================================================
# python.sh — Set up Python via pyenv and install global pipx tools
# =============================================================================

PYTHON_VERSION="3.12.3"

eval "$(pyenv init -)" 2>/dev/null || true

if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
  echo "  → Installing Python $PYTHON_VERSION via pyenv..."
  pyenv install "$PYTHON_VERSION"
fi

pyenv global "$PYTHON_VERSION"
echo "  ✓ Python $(python --version) set as global"

# Global pipx tools — install only if missing
PIPX_TOOLS=(
  ruff
  mypy
  pre-commit
  nbstripout
  llm
  visidata
  datasette
  csvkit
  ipython
)

echo "  → Installing global pipx tools..."
for tool in "${PIPX_TOOLS[@]}"; do
  if pipx list | grep -q "$tool"; then
    echo "  ✓ $tool already installed"
  else
    pipx install "$tool" && echo "  ✓ $tool"
  fi
done
