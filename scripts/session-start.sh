#!/bin/bash
# SessionStart hook for Claude Code
# Shows active Issues from all repos + recent bookmarks

# Skip if gh is not available
command -v gh >/dev/null 2>&1 || exit 0

# 1. In-progress issues from all repos
active=$(gh search issues --owner Uniss1 --label "in-progress" --state open \
  --json repository,title,number --limit 10 2>/dev/null)

if [ -n "$active" ] && [ "$active" != "[]" ]; then
  echo "Active tasks:"
  echo "$active" | jq -r '.[] | "  \(.repository.nameWithOwner)#\(.number)  \(.title)"'
  echo ""
fi

# 2. Recent bookmarks from personal-os
bookmarks=$(gh issue list --repo Uniss1/personal-os --label bookmark \
  --state open --limit 3 --json title,number 2>/dev/null)

if [ -n "$bookmarks" ] && [ "$bookmarks" != "[]" ]; then
  echo "Recent bookmarks:"
  echo "$bookmarks" | jq -r '.[] | "  personal-os#\(.number)  \(.title)"'
  echo ""
fi

# 3. Hint if nothing found
if [ "$active" = "[]" ] && [ "$bookmarks" = "[]" ]; then
  echo "No active tasks or bookmarks. If this session produces meaningful work, create an issue to track it."
fi
