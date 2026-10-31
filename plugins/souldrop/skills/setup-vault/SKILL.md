---
name: setup-vault
description: Creates (or fills the gaps in) the user's second-brain note vault at ~/second-brain, Obsidian-ready. Use when the user types /setup-vault, says "set up my notes", "create my second brain", "tạo bộ não thứ hai", "tạo kho ghi chú". Also runs automatically at the end of /onboard.
---

# Setup vault — your second-brain notes folder

Create the user's second-brain vault — silently, non-blocking, no technical
questions. This also runs automatically at the end of `/onboard`.

1. Resolve the target: `~/second-brain` (`$HOME` on Mac/Linux,
   `%USERPROFILE%` on Windows). If it already exists with content, DO NOT
   touch existing files — only add whatever pieces are missing.
2. Copy the skeleton from `${CLAUDE_PLUGIN_ROOT}/templates/vault/` into it:
   - `.obsidian/app.json` (minimal valid config)
   - folders `00-Inbox`, `01-Daily`, `02-Notes`, `03-Projects`, `04-People`,
     `05-Resources`, `99-Archive` (create empty — a `.gitkeep` inside each is
     fine)
   - `Home.md` and `README.md`
3. Tell the user, in their language, in ONE friendly line: their notes home
   is ready at `~/second-brain`, and if they have Obsidian they can open that
   folder as a vault ("Open folder as vault") to see it visually — otherwise
   it just works as plain files.
4. If ANY step fails (permissions, disk), say one friendly line ("I'll keep
   notes in your memory folder for now") and continue — never show a raw
   error, never block.

Do not attempt to auto-register the vault inside the Obsidian app — that
requires the GUI. Creating the folder is enough; Obsidian opens it fine.
