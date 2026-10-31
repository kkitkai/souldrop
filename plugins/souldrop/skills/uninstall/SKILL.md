---
name: uninstall
description: Cleanly removes SoulDrop — plugin, marketplace, and the optional extras the installer added — while ALWAYS keeping the user's brain (profile, memories, second-brain notes). Use when the user types /uninstall, says "remove souldrop", "uninstall my assistant", "gỡ trợ lý", "xóa SoulDrop", "ลบผู้ช่วย", "어시스턴트 제거", "卸载助手".
disable-model-invocation: true
---

# Uninstall — remove SoulDrop cleanly, keep the brain

The user wants SoulDrop gone. Do it properly and honestly. One rule stands
above everything: **their brain is theirs — never delete it.**
`~/.claude/CLAUDE.md`, `~/.claude/memory/`, and `~/second-brain` stay on disk
no matter what; tell them so.

## Step 1 — Confirm once, in plain words

One human question (in their language), via `AskUserQuestion`:

> "I'll remove SoulDrop from this machine. Your profile, memories and notes
> stay safe on disk — only the tool itself goes. Continue?"
> Options: "Yes, remove it" / "Also remove the extras (documents pack,
> browsing)" / "Cancel".

Never proceed without the confirmation. "Cancel" → stop, change nothing.

## Step 2 — Read the install manifest (best effort)

Read `~/.souldrop/installed.json` if it exists — it records what the
installer actually added (`documentsPack`, `browsing`, `smartMemory`, the
Free-tier launcher/model...). Missing manifest = fine; fall back to checking
what's present (`claude plugin list`, `claude mcp get chrome-devtools`).

## Step 3 — Remove (each line best-effort, never show raw errors)

Base removal ("Yes, remove it"):

1. `claude mcp remove chrome-devtools` — only if it's registered.
2. `claude plugin uninstall souldrop`
3. `claude plugin marketplace remove souldrop`
4. Delete `~/.souldrop/installed.json` (and the `~/.souldrop` folder if empty).

Extras removal (only if they chose "Also remove the extras"):

5. `claude plugin uninstall document-skills` and
   `claude plugin uninstall example-skills`, then
   `claude plugin marketplace remove anthropic-agent-skills`.
6. If `agentmemory` is installed: `claude plugin uninstall agentmemory` and
   `claude plugin marketplace remove agentmemory`.

Do NOT touch: forged skills in `~/.claude/skills/` (they're the user's own
toolkit and keep working without SoulDrop), Obsidian, Ollama, Node, git —
apps the user may use for other things. Mention the Free-tier bits in the
final message instead (the `souldrop` folder + Desktop shortcut are safe to
delete by hand; Ollama uninstalls like any normal app).

## Step 4 — Say goodbye honestly

Close with a short message in their language, shaped like:

> "Done — SoulDrop is removed. Kept safe on your disk: your profile, all your
> memories, and your `second-brain` notes (plain files, yours forever). Your
> custom skills still work too. If you ever want me back:
> one install command and `/onboard` — I'll read those files and remember you."

Vietnamese shape: "Xong — đã gỡ SoulDrop. Vẫn giữ nguyên: hồ sơ, toàn bộ ký
ức và sổ tay `second-brain` của bạn (file thuần, mãi là của bạn). Muốn mình
quay lại: một lệnh cài + `/onboard` — mình sẽ đọc lại và nhớ bạn ngay."

Note: uninstalling the plugin removes this skill too — run the removals in
Step 3's order (plugin last-ish) and print the goodbye yourself; nothing
after this turn depends on the plugin still existing.
