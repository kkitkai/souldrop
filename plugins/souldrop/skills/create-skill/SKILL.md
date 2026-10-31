---
name: create-skill
description: Interactively turns one workflow the user describes into a new installed skill. Use when the user says "make a skill", "create a skill", "turn this into a skill", "automate this", "teach my assistant to always do X", "always do it this way", "tạo kỹ năng mới", "làm tự động", even if they don't say "skill" explicitly.
---

# Create Skill — turn one workflow into a permanent ability

The manual sibling of `forge-skills`: the user describes ONE thing they want
done the same way every time; you author it as a skill and install it. Same
quality bar as the forge — hand-made and forged skills share one gate.

The user is likely a beginner. Never mention YAML, frontmatter, or file
paths unless they ask. Talk about "teaching your assistant a new ability".

## Step 1 — Understand the job (human questions only)

Ask, conversationally (use `AskUserQuestion` where options are natural,
free text otherwise), until you know:

1. **What** — the task, in their words. ("Reply to booking inquiries.")
2. **When** — what they'd say/do when they want it. These become triggers.
3. **Output** — what "done" looks like: format, length, language, tone.
   If they have an example of a good past result, ask them to paste it —
   one real example is worth ten adjectives.

Don't interrogate — 2–3 short questions is usually enough. Reuse what you
already know from `~/.claude/CLAUDE.md` (their profession, language, tone).

## Step 2 — Draft the skill

Use `${CLAUDE_PLUGIN_ROOT}/templates/SKILL.md.tmpl` as the shape
(always resolve via `${CLAUDE_PLUGIN_ROOT}` — never a relative path; the
working directory is not this skill's directory at runtime):

- `name`: kebab-case, ≤64 chars, self-explanatory.
- `description`: THIRD person, ≤300 chars, pushy — what + when, with the
  user's own trigger phrases from Step 1 (in their language), ending
  "even if they don't say X explicitly".
- Body: imperative When/Steps/Output/Rules, grounded in their answers.
  Include their pasted example in the Output section if they gave one.

## Step 3 — Quality gate (same as forge-skills, all must pass)

1. `name` present, kebab-case `^[a-z][a-z0-9]*(-[a-z0-9]+)*$`, ≤64 chars.
2. `description` present, third person, ≤300 chars, contains a when/use
   trigger clause — and NO unquoted `: ` (colon + space) inside it, which
   breaks YAML parsing (use a dash, or quote the whole description).
3. Body: ≥10 non-empty lines, ≥1 `##` section, imperative steps, ≤500 lines.
4. Dedup: if `~/.claude/skills/<name>/` already exists, tell them in plain
   words and ask the human question: replace it, or name this one differently?

Fails → fix and re-lint (max 2 tries). Never install a failing skill.

## Step 4 — Preview, confirm, install

Show a plain-words preview: the ability's name, what it does, and what
they'd say to trigger it (NOT the raw file). On a yes, write
`~/.claude/skills/<name>/SKILL.md` and confirm in one line:

> "Done — NAME now knows how to <job>. Just say '<trigger>' anytime."

Mention that `learn-from-mistakes` will keep sharpening it as they correct
its output.

## Changing a skill later — edit, don't remake

Once the user has approved a skill, it is LOCKED. When they want a change:

1. Back up the current file next to it (`SKILL.md.v1`, `SKILL.md.v2`, …) —
   never delete an old version; the user decides what to clean up.
2. Write down in one short list what changes and what stays the same.
3. Change one thing at a time, inside the existing file. Never regenerate the
   whole skill from scratch.
4. Show the change in plain words, and say how to go back ("say 'undo the
   last skill change' and I'll restore v2").

If the user is choosing between versions or ideas, show them side by side,
numbered, and let them pick.
