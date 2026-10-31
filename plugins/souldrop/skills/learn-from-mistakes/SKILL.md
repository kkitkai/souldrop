---
name: learn-from-mistakes
description: Turn a user correction or a failed approach into a permanent memory so the same mistake never repeats. Use whenever the user corrects you ("no, not like that", "I told you before...", "sai rồi"), rejects an output, or an approach fails for a reason worth remembering.
---

# Learn from mistakes

A correction is a gift: it's the user teaching you how they want things done.
Capture it or it will happen again next session.

## The loop

1. **Name the mistake** in one plain line, and **fix** the immediate issue
   first. The lesson-capture never delays the actual fix.
2. **Find the real cause from evidence**, not a guess: re-read what the user
   asked, what you did, and what came out. One sentence: what did you assume
   or do that was wrong, and what rule prevents it? ("I changed the layout
   without being asked → only change what was requested.")
3. **Save it** to `~/.claude/memory/` (via the `remember` skill) as a
   feedback-type memory:

   ```markdown
   # <Rule as a short imperative title>

   **What happened:** <one line>
   **Rule:** <what to always/never do>
   **Why:** <the user's reason, if they gave one>
   ```

4. **Index it** in `MEMORY.md` under "Preferences & feedback".
5. **Make it impossible to repeat** where you can: if the mistake came from a
   skill (one in `~/.claude/skills/`) or from the profile, fix that file too —
   back it up first (`SKILL.md.backup-YYYY-MM-DD`), change only the lines
   involved, and tell the user in one line what you changed and how to undo
   it. A fixed skill beats "I'll remember".
6. **Confirm next time**: the next time the same kind of task comes up, apply
   the rule and, if it's a big one, mention it ("using the rule from last
   time: …"). If an old memory caused the mistake (outdated info), update or
   correct that memory too.

## Rules

- Capture the RULE, not the incident story.
- One correction = one memory. Don't batch unrelated lessons into one file.
- Repeated correction on the same topic = your saved rule is too weak;
  sharpen it, don't duplicate it.
