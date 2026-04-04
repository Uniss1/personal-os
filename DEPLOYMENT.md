# Deployment Guide

Deploy Claude Code environment on a new device.

## Quick Start

```bash
git clone git@github.com:Uniss1/personal-os.git ~/projects/personal-os
cd ~/projects/personal-os
bash scripts/deploy.sh
```

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| `claude` | Claude Code CLI | `npm install -g @anthropic-ai/claude-code` |
| `gh` | GitHub CLI (issues, journal) | `sudo apt install gh` / `brew install gh` |
| `jq` | JSON processing (hooks, statusline) | `sudo apt install jq` |
| `git` | Version control | `sudo apt install git` |
| `python3` | Statusline time calculations | Usually pre-installed |
| `curl` | API calls for usage limits | Usually pre-installed |

After install:
```bash
gh auth login
claude  # triggers Anthropic login
```

## What Gets Deployed

### 1. `~/.claude/CLAUDE.md` — Global Agent Rules

Source: `dotfiles/CLAUDE.md`

- One-session-one-task discipline
- Session drift detection
- Context checkpoint at ~15 prompts
- Personal OS integration rules

### 2. `~/.claude/settings.json` — Hooks + Plugins

Source: `dotfiles/settings.json`

**Hooks:**
- `SessionStart` — shows active issues and recent bookmarks from all repos
- `PostToolUse(Bash)` — after `git push`, reminds to update issues + logs journal entry

**Plugins:**
- `superpowers@superpowers-marketplace` — brainstorming, TDD, debugging, code review skills

**Status line:**
- Git branch, model, usage limits (5h/weekly), cost, context %

### 3. `~/.claude/statusline.sh` — Custom Status Line

Source: `dotfiles/statusline.sh`

Shows: `dir (branch) • model • 2h30m 75% W90% • $0.42 • 35%`
- Usage limits from Anthropic OAuth API (cached 2 min)
- Color-coded: green < 50% context, yellow < 80%, red > 80%

### 4. `~/.claude/skills/` — Custom Skills

Source: `dotfiles/skills/`

| Skill | Purpose |
|-------|---------|
| `cc-analytics` | Claude Code usage stats and weekly reports |
| `ceo-council` | Multi-expert strategic analysis |
| `claude-md-writer` | CLAUDE.md best practices |
| `frontend-design` | Production-grade UI generation |
| `gemini-tmux-orchestration` | Parallel tasks via Gemini CLI |

### 5. `scripts/` — Hook Scripts

| Script | Trigger |
|--------|---------|
| `session-start.sh` | Every session start |
| `post-push.sh` | After `git push` |

### 6. Shell Alias

Adds to `~/.bashrc` / `~/.zshrc`:
```bash
alias claude='cd ~/projects/personal-os && claude'
```

## Manual Steps After Deploy

1. **Authenticate Claude** — run `claude` and follow login prompt
2. **Authenticate GitHub** — `gh auth login` if not already done
3. **Superpowers plugin** — auto-installs on first `claude` run (approve when prompted)
4. **Restart terminal** — or `source ~/.bashrc` to activate alias

## File Structure

```
personal-os/
├── CLAUDE.md              # Project-level agent rules
├── DEPLOYMENT.md          # This file
├── projects.yaml          # Project catalog
├── scripts/
│   ├── deploy.sh          # Deployment script
│   ├── session-start.sh   # SessionStart hook
│   └── post-push.sh       # PostPush hook
└── dotfiles/
    ├── CLAUDE.md           # Global ~/.claude/CLAUDE.md
    ├── settings.json       # Global ~/.claude/settings.json
    ├── statusline.sh       # Global ~/.claude/statusline.sh
    └── skills/             # Custom skills
        ├── cc-analytics/
        ├── ceo-council/
        ├── claude-md-writer/
        ├── frontend-design/
        └── gemini-tmux-orchestration/
```

## Updating

After changing configs locally:
```bash
# Sync live configs back to repo
cp ~/.claude/CLAUDE.md dotfiles/CLAUDE.md
cp ~/.claude/settings.json dotfiles/settings.json
cp ~/.claude/statusline.sh dotfiles/statusline.sh
```

Or re-deploy from repo to system:
```bash
bash scripts/deploy.sh
```
