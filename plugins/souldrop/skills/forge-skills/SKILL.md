---
name: forge-skills
description: Automatically builds a set of custom skills tailored to the user's profession and goal, then installs them to ~/.claude/skills/. Runs automatically at the end of /onboard, and again whenever the user types /forge-skills, says "build me skills", "make skills for my work", "my goals changed", "tạo kỹ năng", "สร้างสกิล", "스킬 만들어줘", "生成技能" — even if they never say the word "skill".
---

# Forge Skills — auto-build the user's custom toolkit

Turn what you know about the user (profession + goal, captured at onboarding)
into 3–5 small, sharp, installed skills — **automatically, with zero technical
questions**. The user is a complete beginner; they never see the machinery.

Golden rules for the whole flow:

- **Never ask a technical question.** No questions about files, folders,
  frontmatter, YAML, or "skills" as a concept. If you must ask anything, it is
  a human question ("Anything else you'd love NAME to handle?") — and even
  that is optional.
- **Non-blocking always.** If any step fails (missing profile, unreadable
  file, a skill that won't pass the gate), say ONE friendly line and continue
  with what works. Never show a raw error. Never leave the user stuck.
- **Speak the user's language** (`LANG` from their profile / the session).
  Skill FILES are written in English internally EXCEPT the description's
  trigger phrases, which should include the user's own language so the skills
  fire when they type naturally.

## Step 1 — Load context (never re-interview)

Read what onboarding already stored:

1. `~/.claude/CLAUDE.md` — the "About" section has their profession and goal.
2. `~/.claude/memory/about-me.md` — the interview answers.

If neither exists (forge run before onboarding), say in one friendly line that
you'll get to know them first, run the `onboard` skill, and stop — onboarding
will call the forge itself at the end.

## Step 2 — Derive 3–5 candidate skills

Two sources, merged:

1. **The domain map** — read `${CLAUDE_PLUGIN_ROOT}/templates/domain-map.md`
   (always via `${CLAUDE_PLUGIN_ROOT}`, never a relative path — the working
   directory is not this skill's directory at runtime). Find the
   profession row(s) that match the user and start from its candidate skills.
2. **Their free-text goal** — reason over the goal itself. The goal always
   beats the map: a photographer whose goal is "post more on TikTok" needs
   content skills, not just photography skills.

Selection rules:

- **3–5 skills, no more.** Each tightly scoped to ONE recurring job the user
  will plausibly do weekly (reply to an inquiry, draft a quote, plan a
  shoot…). Reject vague catch-alls ("help-with-business").
- Skip anything already covered by the bundled core skills (remember, recall,
  daily-note, work-smart, learn-from-mistakes, personal, leader).
- Names in kebab-case English, self-explanatory: `client-inquiry-reply`,
  `quote-builder`, `weekly-content-plan`.

## Step 3 — Generate each SKILL.md

Use `${CLAUDE_PLUGIN_ROOT}/templates/SKILL.md.tmpl` as the shape. For each
candidate fill:

- **`name`** — kebab-case, 1–64 chars, matches the folder name.
- **`description`** — THIRD person, under 300 characters, deliberately
  "pushy": what it does + WHEN to use it, with 3+ concrete trigger phrases
  the user would actually type (include their language), ending the trigger
  list with "even if they don't say X explicitly". The description is the
  entire triggering mechanism — Claude under-triggers, so make it eager.
- **Body** — imperative instructions, under 150 lines: When to use / Steps /
  Output shape / Rules. Ground it in the user's real context (their name,
  business type, language, tone from the profile). Concrete beats generic:
  a real example inquiry-reply outline, not "be helpful".

YAML trap (real bug): an unquoted `: ` (colon + space) inside the
description breaks frontmatter parsing and the skill silently loads with no
metadata. Use a dash instead of a colon, or quote the whole description.

## Step 4 — Quality gate (blocks junk; never install a failing skill)

Lint every generated skill BEFORE installing. ALL checks must pass:

| # | Check | Rule |
|---|---|---|
| 1 | name present | non-empty `name:` in frontmatter |
| 2 | name format | kebab-case `^[a-z][a-z0-9]*(-[a-z0-9]+)*$`, ≤64 chars |
| 3 | description present | non-empty `description:` |
| 4 | description length | ≤300 characters |
| 5 | description voice | third person — describes the skill ("Drafts…", "Builds…"), never "I will" / "You should" |
| 6 | description trigger | contains a when-clause: "Use when/whenever…", "Runs when…", or equivalent |
| 7 | body substance | ≥10 non-empty lines, ≥1 `##` section, imperative steps |
| 8 | body length | ≤500 lines |
| 9 | dedup | no existing `~/.claude/skills/<name>/` (if exists: skip silently on auto-run; on manual re-run, ask the human-level question "want me to refresh it?") |

Also: frontmatter must PARSE as YAML — no unquoted `: ` inside the
description (see the trap above).

- A skill that fails → regenerate it (fix only what failed), **max 2
  retries**. Still failing → drop it silently from the batch; never install
  it, never show the user an error about it.
- Also dedup within the batch itself — no two skills with the same name or
  near-identical purpose.

## Step 5 — Install

For each passing skill, write `~/.claude/skills/<name>/SKILL.md`
(user scope — resolve `$HOME` / `%USERPROFILE%`, create folders as needed).
Never overwrite an existing skill on the auto-run.

## Step 5.5 — Taste pass (only for web/app design professions; silent)

If — and only if — the user's profession or goal touches **websites, landing
pages, apps, dashboards or UI design**, also install the open-source
[taste-skill](https://github.com/Leonxlnx/taste-skill) plugin (MIT, © Leonxlnx
— attribution recorded in this repo's NOTICE). It gives the assistant an eye
for high-end web design. A shop owner, teacher, or accountant gets NOTHING
from this step — skip it entirely; never install it "just in case".

Requirements (upstream): Node.js **22 or newer** and Chrome, Edge or Chromium
installed. Check quietly (`node -v`; a browser on the usual paths). Missing →
skip this step silently.

How (non-interactive, silent-fail like everything else) — install it the
official plugin way, straight from its author's own marketplace, so updates
come from upstream and nothing is copied by hand:

1. `claude plugin install taste-skill --marketplace Leonxlnx/taste-skill`
   (Claude Code 2.1.292+). On an older Claude Code, use the two-step form:
   `claude plugin marketplace add Leonxlnx/taste-skill` then
   `claude plugin install taste-skill@taste-skill`.
2. Already installed (`claude plugin list` shows `taste-skill`) → do nothing.

If the install fails for any reason (offline, old Claude Code), skip
silently — the forged skills from Step 5 are the main event; this is a bonus.
In Step 6's show-off list, present it in plain words ("an eye for high-end
web design"), never as "taste-skill" or a GitHub URL. `/uninstall` with
"also remove the extras" removes it again.

## Step 5.6 — Image-prompt habits (only if a forged skill makes images)

If one of the forged skills writes prompts for an AI image tool (common for
designers, shops and content creators), add these plain rules to its body:

- Describe the camera and the light (lens, angle, time of day, light source)
  instead of writing "photorealistic" or "8k" — realism comes from removing
  fake polish, not adding adjectives.
- Every visible detail needs a reason to be there (worn edges on an old
  table, steam above hot coffee).
- An edit request = what changes + what must stay the same; one change per
  round.
- Show the prompt and get a yes before running a generation that costs money
  or credits.

## Step 6 — Show off (this is the payoff moment)

Tell the user — in THEIR language, in the assistant's persona — what was just
built for them, as a short friendly list: skill name in plain words + one line
on what it does + an example phrase that triggers it. Shape (adapt, don't copy):

> "While we talked, I built myself a toolkit just for you:
> • **Client inquiry reply** — send me any inquiry and I'll draft the answer.
> • **Quote builder** — say 'quote for a full-day wedding' and I'll draft it.
> • **Shoot shot-list** — tell me the venue and I'll plan the shots.
> They're ready now — just talk to me normally. Say 'my goals changed' anytime
> and I'll build new ones."

Do NOT show file paths, YAML, or the word "frontmatter". If ZERO skills
survived the gate, just skip this moment gracefully — greet them normally and
mention they can say "build me skills" later.

## Re-running

Fully re-runnable (`/forge-skills` or "my goals changed"). On re-runs:
re-read the profile (it may have changed), never touch existing skills
without the human-level "refresh it?" question, and aim to ADD what's
missing, not duplicate what exists.
