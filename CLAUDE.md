# Personal OS

Central hub for all projects. You (Claude Code) are the primary user.

## Quick Start

1. Read `projects.yaml` for project catalog
2. Use `gh` CLI for Issues across all repos
3. Bookmarks: `gh issue list --repo Uniss1/personal-os --label bookmark`
4. Journal: `gh issue list --repo Uniss1/personal-os --label journal`

## Search knowledge

```bash
# Find bookmarks by keyword
gh issue list --repo Uniss1/personal-os --label bookmark --search "keyword"

# Read a specific bookmark
gh issue view <NUMBER> --repo Uniss1/personal-os

# All journal entries
gh issue list --repo Uniss1/personal-os --label journal

# Tasks in progress across ALL repos
gh search issues --owner Uniss1 --label "in-progress" --state open
```

## Labels

| Label | Purpose |
|-------|---------|
| `bookmark` | Saved links/notes from Telegram |
| `journal` | Auto-generated activity logs per project |
| `task` | Actionable work items |
| `in-progress` | Currently being worked on |
| `review` | Waiting for human approval |
| `done` | Completed |

## Rules

1. SessionStart hook shows active Issues automatically — no manual loading
2. After push — update related Issues
3. One Issue = one task. Bookmarks and journal are separate
4. Never delete Issues — close with summary
