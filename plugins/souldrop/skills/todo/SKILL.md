---
name: todo
description: Keeps one simple task list so nothing the user asks for gets lost — every request becomes a line (doing / waiting for you / done) until the result is delivered. Use when the user types /todo, asks "what's left?", "what are you working on?", "did you finish X?", "còn gì chưa xong?", "việc còn lại", "danh sách việc", and at the start of every session to mention open tasks, even if they don't say "todo" explicitly.
---

# Todo — nothing you ask gets lost

The user is busy and may ask for five things in one message, or come back
tomorrow to "that thing from yesterday". Keep ONE plain list so every request
is tracked from "asked" to "delivered", and so "what's left?" always has an
honest answer.

## Where the list lives

`~/.claude/memory/tasks.md` (create it on first use). Plain markdown the user
can open and read. Shape:

```markdown
# Tasks

## Open
- [doing] 2026-11-02 — Draft the price list for the spring menu — first draft shown, waiting for feedback
- [waiting for you] 2026-11-02 — Book the dentist — need your preferred day

## Done
- [done] 2026-11-01 — Excel of last month's sales — sent sales-october.xlsx, user said ok
```

One line per request: status, date asked, what was asked (in the user's own
words, short), and the latest real state or result in plain words.

## The rules

1. **Add before you start.** When the user asks for something that takes more
   than a quick answer, add the line first (status `doing`). Several requests
   in one message = several lines.
2. **Update at each real step**, not at each thought: "first draft shown",
   "waiting for your photos", "file saved". Use honest words — `drafted`,
   `running`, `finished`, `checked` are different things.
3. **Done means delivered.** Mark `done` only after the user has actually seen
   the result (the file, the answer, the change). Write what was delivered.
   "I think it's done" is still `doing`.
4. **Waiting is a status.** If you need something from the user, mark it
   `waiting for you` and say exactly what you need.
5. **Never delete lines.** Done items move to "Done". If the user cancels
   something, mark it `cancelled` — they decide what to clean up.
6. **Start of a session:** read the list. If anything is open, mention it in
   one line ("Still open from last time: the price list draft. Continue?").
   Don't nag more than once per session.

## When the user asks "what's left?" / "còn gì chưa xong?"

Answer from the file, short, in their language, newest first:

> Still open:
> 1. Price list — first draft shown, waiting for your feedback
> 2. Dentist — I need your preferred day
>
> Finished this week: 3 (say "show done" to see them)

VN shape: "Còn đang làm: 1. Bảng giá — đã gửi bản nháp đầu, chờ bạn góp ý.
2. Lịch nha sĩ — mình cần biết ngày bạn muốn."

## Small things

- A one-line question ("what's 15% of 200?") is not a task — don't log it.
- Don't show the file path or the markdown unless the user asks.
- Keep it short: the list is a tool for the user, not a diary.
