#!/bin/bash
# PostPush hook for Claude Code
# 1. Reminds to update Issues for current repo
# 2. Creates/updates journal entry in personal-os

# Skip if gh is not available or not in a git repo
command -v gh >/dev/null 2>&1 || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

repo=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null)
[ -z "$repo" ] && exit 0

branch=$(git branch --show-current)
commits=$(git log --oneline -5 2>/dev/null)

# 1. Reminder: show in-progress issues for this repo
active=$(gh issue list --repo "$repo" --label "in-progress" --state open \
  --json title,number --limit 5 2>/dev/null)

if [ -n "$active" ] && [ "$active" != "[]" ]; then
  echo "Pushed to $repo. In-progress issues:"
  echo "$active" | jq -r '.[] | "  #\(.number)  \(.title)"'
  echo "Consider updating or closing related issues."
  echo ""
fi

# 2. Journal: find or create journal Issue for this repo
journal_number=$(gh issue list --repo Uniss1/personal-os --label journal \
  --search "Journal: $repo" --json number -q '.[0].number' 2>/dev/null)

journal_body="**$(date '+%Y-%m-%d %H:%M')** push to \`$branch\`

\`\`\`
$commits
\`\`\`"

if [ -n "$journal_number" ]; then
  gh issue comment "$journal_number" --repo Uniss1/personal-os \
    --body "$journal_body" >/dev/null 2>&1
else
  gh issue create --repo Uniss1/personal-os \
    --label journal \
    --title "Journal: $repo" \
    --body "Activity log for $repo" >/dev/null 2>&1
  # Get the new issue number and add first comment
  new_number=$(gh issue list --repo Uniss1/personal-os --label journal \
    --search "Journal: $repo" --json number -q '.[0].number' 2>/dev/null)
  [ -n "$new_number" ] && gh issue comment "$new_number" --repo Uniss1/personal-os \
    --body "$journal_body" >/dev/null 2>&1
fi
