# Adapter: Claude Code (Pro tier)

The richest engine — full skills, auto skill-forge, subagents. Needs a paid
Claude plan (Pro or higher).

## How it fulfills the [adapter contract](../README.md)

1. **Install the engine** — calls Anthropic's official installer
   (`https://claude.ai/install.ps1` / `install.sh`); never re-hosted.
   Logic: `Install-ClaudeEngine` in `install/go.ps1`,
   `install_claude_engine` in `install/go.sh`.
2. **Install the brain** — adds this repo as a plugin marketplace and
   installs the `souldrop` plugin; `/onboard` runs the human interview and
   writes persona (`~/.claude/CLAUDE.md`), memory (`~/.claude/memory/`), and
   the vault (`~/second-brain/`).
3. **Wire the persona** — Claude Code natively loads `~/.claude/CLAUDE.md`
   every session; the plugin's skills (remember/recall/personal/...) wire
   the memory habits.
4. **Report status** — bilingual step lines; optional extras (agentmemory
   smart memory, Obsidian app) skip with one friendly line on any failure.

## Extras only this tier has

- **Auto skill-forge** (`/forge-skills`) — generates 3–5 custom skills from
  the user's profession + goal, quality-gated.
- `create-skill`, `leader`, `work-smart`, `learn-from-mistakes`, and the
  full skill set in `plugins/souldrop/skills/`.

Install commands (what the bootstrap runs):

```
claude plugin marketplace add kkitkai/souldrop
claude plugin install souldrop@souldrop
```
