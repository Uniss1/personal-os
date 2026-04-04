# Global Rules

## One Function, One Bug, One Feature

Each session must focus on ONE concrete task. Do not mix types of work in a single session.

### How to enforce:

1. At session start — identify the task type and state it:
   - "This session: [fix bug X / implement feature Y / deploy Z]"

2. Track drift — if the user shifts to a different type of work mid-session, STOP and remind:
   > "We started this session to [original task]. You're now asking about [new task].
   > This will fill context and reduce quality. Start a new session for this — /clear or open a new terminal."

3. Detect these drift patterns:
   - Code work -> deployment debugging
   - Feature implementation -> unrelated bug fix
   - One project's task -> questions about another project
   - Implementation -> exploratory research
   - Writing code -> pasting large logs (>50 lines)

4. Large paste warning — if user pastes >50 lines of logs/output, suggest trimming to relevant lines only. Full logs waste context.

5. Context checkpoint at ~15 prompts — remind user:
   > "We're at ~15 prompts. Context is getting heavy. Good time to commit, save progress, and consider a fresh session if more work is needed."

## Session Hygiene

- Do not ask "save context?" at the end — just do it automatically if the session produced meaningful work
- Commit after each completed sub-task, not at the end
- If deployment fails, fix the root cause — don't retry the same command

## Personal OS

Working directory for personal management: ~/projects/personal-os
SessionStart hook automatically loads active Issues from all repos.
After git push, hook reminds to update Issues and logs journal entry.
Bookmarks are stored as Issues with label `bookmark` in Uniss1/personal-os.
