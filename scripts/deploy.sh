#!/bin/bash
# Deploy Claude Code environment on a new device
# Usage: bash scripts/deploy.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Code Environment Deploy ==="
echo ""

# ── 1. Prerequisites ──────────────────────────────────────
echo "[1/7] Checking prerequisites..."

for cmd in gh jq git curl python3; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "  ERROR: '$cmd' not found. Install it first."
    exit 1
  fi
done

if ! command -v claude &>/dev/null; then
  echo "  ERROR: 'claude' CLI not found."
  echo "  Install: https://docs.anthropic.com/en/docs/claude-code/getting-started"
  exit 1
fi

echo "  All prerequisites OK."

# ── 2. Clone personal-os if running from elsewhere ────────
echo "[2/7] Checking personal-os repo..."

if [ ! -d "$HOME/projects/personal-os/.git" ]; then
  echo "  Cloning personal-os..."
  mkdir -p "$HOME/projects"
  git clone git@github.com:Uniss1/personal-os.git "$HOME/projects/personal-os"
  echo "  Cloned to ~/projects/personal-os"
else
  echo "  Already exists. Pulling latest..."
  git -C "$HOME/projects/personal-os" pull --ff-only 2>/dev/null || true
fi

# ── 3. Global CLAUDE.md ──────────────────────────────────
echo "[3/7] Installing global CLAUDE.md..."

mkdir -p "$CLAUDE_DIR"
cp "$REPO_DIR/dotfiles/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  Installed ~/.claude/CLAUDE.md"

# ── 4. settings.json ─────────────────────────────────────
echo "[4/7] Installing settings.json..."

cp "$REPO_DIR/dotfiles/settings.json" "$CLAUDE_DIR/settings.json"
echo "  Installed ~/.claude/settings.json"

# ── 5. statusline.sh ─────────────────────────────────────
echo "[5/7] Installing statusline..."

cp "$REPO_DIR/dotfiles/statusline.sh" "$CLAUDE_DIR/statusline.sh"
chmod +x "$CLAUDE_DIR/statusline.sh"
echo "  Installed ~/.claude/statusline.sh"

# ── 6. Custom skills ─────────────────────────────────────
echo "[6/7] Installing custom skills..."

SKILLS_SRC="$REPO_DIR/dotfiles/skills"
SKILLS_DST="$CLAUDE_DIR/skills"
mkdir -p "$SKILLS_DST"

if [ -d "$SKILLS_SRC" ]; then
  for skill_dir in "$SKILLS_SRC"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$SKILLS_DST/$skill_name"
    cp -r "$skill_dir"* "$SKILLS_DST/$skill_name/"
    echo "  Installed skill: $skill_name"
  done
else
  echo "  No custom skills to install."
fi

# ── 7. Shell alias ────────────────────────────────────────
echo "[7/7] Configuring shell alias..."

CLAUDE_BIN=$(which claude)
ALIAS_LINE="alias claude='cd ~/projects/personal-os && $CLAUDE_BIN'"

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$rc" ]; then
    if ! grep -q "alias claude=" "$rc"; then
      echo "" >> "$rc"
      echo "# Claude Code: always start from personal-os" >> "$rc"
      echo "$ALIAS_LINE" >> "$rc"
      echo "  Added alias to $(basename "$rc")"
    else
      echo "  Alias already exists in $(basename "$rc")"
    fi
  fi
done

# ── Done ──────────────────────────────────────────────────
echo ""
echo "=== Deploy complete ==="
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to log in (if not authenticated)"
echo "  2. The superpowers plugin will auto-install on first run"
echo "  3. Run 'gh auth login' if not authenticated with GitHub"
echo "  4. Restart terminal or run: source ~/.bashrc"
