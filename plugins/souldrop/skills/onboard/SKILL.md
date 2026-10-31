---
name: onboard
description: Guided interview (English, Tiếng Việt, ไทย, 한국어, 中文 — or any language the user names) that creates the user's own personalized AI assistant — asks their name, goals, the assistant's name and personality, then writes ~/.claude/CLAUDE.md and a memory scaffold. Use when the user types /onboard, asks to "set up my assistant", "create my AI", "tạo trợ lý", "cài đặt trợ lý", "สร้างผู้ช่วย", "어시스턴트 만들기", "创建助手", or when they appear to be brand new with no personalized CLAUDE.md.
---

# Onboard — build the user's personal AI assistant

You are about to run a short, friendly interview and then **write real files** that
turn this generic Claude Code install into the user's own named, personalized
assistant with persistent memory.

Golden rules for this whole flow:

- **Never invent facts.** Only write what the user actually answered.
- **Never overwrite anything without explicit confirmation** (Step 1 handles this).
- Use the `AskUserQuestion` tool for every question that has natural options
  (max 4 options per question; free-text "Other" is added automatically).
- Keep it warm and simple — the user is very likely a complete beginner.
  No jargon. Never mention "CLAUDE.md" or "frontmatter" during the interview;
  say "your assistant's profile" instead.
- One question round at a time. Do not dump all questions at once.

## Step 0 — Language gate (ALWAYS FIRST)

Supported interview languages: **English** and **Tiếng Việt** (primary), plus
**ไทย, 한국어, 中文** (fully supported) — and any other language the user names.

Ask with `AskUserQuestion` (options cap at 4, so the gate is two-tier):

> Question: "Which language would you like to use? / Bạn muốn dùng tiếng nào? /
> คุณอยากใช้ภาษาอะไร? / 어떤 언어를 사용하시겠어요? / 你想使用哪种语言?"
> Options: "English", "Tiếng Việt", "ไทย · 한국어 · 中文 …"

- If they pick the third option, ask one follow-up `AskUserQuestion`:
  Options: "ไทย", "한국어", "中文". The automatic free-text "Other" (on either
  question) covers any other language — ask them to name it if unclear, then
  proceed in it. Whatever language they type via "Other" IS the answer.

Set **`LANG` = the chosen language**. From here on, everything happens in
`LANG`: every question, every option label, the preview, the generated profile,
and the first greeting. Treat `LANG` as a single clean variable — there are no
per-language branches in the flow itself.

The English strings written in this file are canonical. For Tiếng Việt, ไทย,
한국어, and 中文, load `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/i18n.md`
after the gate and use the matching block as your base wording. For any other
language, translate the English strings naturally — same warmth, never
word-for-word.

## Step 1 — Safety check on existing setup

Check whether `~/.claude/CLAUDE.md` already exists (home directory: `$HOME` on
Mac/Linux, `%USERPROFILE%` on Windows — resolve it, don't guess).

- If it does NOT exist → continue to Step 2.
- If it EXISTS → read it. Then ask with `AskUserQuestion`:
  - "You already have an assistant profile. What would you like to do?"
  - Options:
    1. **Start fresh (keep a backup)** — back up the old file to
       `~/.claude/CLAUDE.md.backup-YYYY-MM-DD-HHmm` first, then replace it.
    2. **Update it** — run the interview, then merge: keep any custom sections
       the user added, replace the identity/personality/goals sections.
    3. **Cancel** — stop, change nothing, tell them how to re-run (`/onboard`).
- Never delete the old file. Backups always.

## Step 2 — The interview

Run these rounds with `AskUserQuestion`, in order. `AskUserQuestion` supports up
to 4 questions per call — group them as shown (2 calls + 1 free-text ask), so the
interview feels quick, not like a form.

**Round A — about the user** (free text + one AskUserQuestion call, 3 questions):

1. *Your name* — has no natural options, so ask it as plain free text BEFORE the
   call, or as an "Other"-driven question with example options. Prefer plain
   conversation: "First — what should your assistant call you?"
2. *What do you do?* (their profession — the forge builds skills from this)
   - Options: "Run my own business / shop", "Freelance & creative work",
     "Office / company job", "Student / researcher" (+ Other for anything else).
   - If the answer is broad, ask ONE short plain follow-up ("What kind?") —
     "photographer" beats "freelance" for building their toolkit later.
3. *What do you mainly want help with?* (multiSelect: true)
   - Options: "Work & documents", "Content & social media", "Coding & tech",
     "Study & research" (+ Other for anything else, e.g. business, personal life)
4. *How should your assistant talk to you?*
   - Options: "Short & direct", "Friendly & warm", "Professional & formal",
     "Playful & fun"

Then ONE free-text question, conversationally (this is the forge's fuel):

5. *Their goal* — "And in your own words — what's the #1 thing you'd love
   this assistant to help you achieve?" Accept whatever they say; one short
   clarifying follow-up at most.

**Round B — about the assistant** (free text + one AskUserQuestion call):

4. *Name your assistant* — plain free text: "Now the fun part — give your
   assistant a name. Anything you like." If they can't decide, offer 3 varied
   suggestions but never pick for them.
5. *Main jobs* (multiSelect: true) — "What should NAME own as its main jobs?"
   - Options tailored from their Round A answers, e.g.: "Draft & polish writing",
     "Research & summarize", "Organize files & plans", "Debug & explain code"
6. *Reply language* —
   - Options: `LANG` (the interview language — skip this option if `LANG` is
     English), "English", "Match whatever language I write in"

If any answer is unclear, ask one short follow-up. Do not re-ask what they
already told you.

## Step 3 — Generate the files

Read the template at `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/CLAUDE.md.tmpl`
(always via `${CLAUDE_PLUGIN_ROOT}` — never a relative path; the working
directory is not this skill's directory at runtime) and fill every
`{{placeholder}}` from the interview answers. Rules:

- Write the profile in `LANG` (the interview language). Fill
  `{{reply_language}}` with the Round B answer — the profile must record the
  chosen reply language and instruct the assistant to reply in it by default.
- Personality section must reflect their communication choice with 3-4 concrete
  behavioral lines (e.g. "Short & direct" → "Concise by default. No filler, no
  flattery. Expand only when asked.").
- Capabilities section lists ONLY the jobs they selected, one line each with a
  concrete example of how the assistant helps.
- Fill `{{profession}}` and `{{goal}}` from Round A answers 2 and 5 — the
  About section MUST record both verbatim-ish (cleaned up, not embellished);
  the forge and every future re-run read them from here.
- Do not add capabilities, rules, or personality traits they didn't ask for.

Write these files:

1. `~/.claude/CLAUDE.md` — the filled profile (respecting the Step 1 choice:
   fresh-with-backup, or merge).
2. `~/.claude/memory/MEMORY.md` — from
   `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/MEMORY.md.tmpl`. If it already
   exists, leave it alone and only append the new index line from step 3.
3. `~/.claude/memory/about-me.md` — the first real memory: a short file recording
   the interview answers (their name, profession, goal, preferences, assistant
   name, date). Add one index line for it to `MEMORY.md`.

## Step 4 — Preview & confirm

BEFORE writing `~/.claude/CLAUDE.md`, show the user a short preview:
the assistant's name, personality summary, its main jobs, and reply language —
in plain words, not raw file contents (offer to show the full file if they want).

Ask with `AskUserQuestion`: "Shall I save this?" — Options: "Yes, save it",
"Change something" (loop back to just the part they want changed), "Cancel".

Only write files after "Yes".

## Step 5 — Auto second-brain (silent, non-blocking)

Right after the files are written, create the user's note vault at
`~/second-brain` by copying the skeleton from
`${CLAUDE_PLUGIN_ROOT}/templates/vault/` (always via `${CLAUDE_PLUGIN_ROOT}` —
relative paths like `../../templates/vault/` are unreliable at runtime because
the working directory is not this skill's directory):
the `.obsidian/app.json` config, the seven numbered folders, `Home.md`, and
`README.md`. If the folder already exists, only add missing pieces — never
touch existing files.

Do NOT ask the user anything about this and do NOT explain the mechanics —
it gets one warm sentence in the final hello (Step 7). If creation fails for
any reason, skip it silently (memory still works via `~/.claude/memory/`)
and drop that sentence — never show an error.

## Step 6 — Auto-forge the user's custom toolkit (non-blocking)

Tell the user ONE friendly line in `LANG`, in the new persona — shape:
"One moment — I'm building myself a toolkit just for you…" — then run the
**`forge-skills` skill** from this plugin, start to finish. You already hold
the profession + goal from the interview, so pass that context straight in
(the forge won't re-interview, and never asks technical questions).

The forge derives 3–5 tightly-scoped skills, quality-gates them, and installs
the survivors to `~/.claude/skills/`. If the forge fails entirely or nothing
passes the gate, continue to Step 7 without mentioning it — the user can say
"build me skills" later.

## Step 7 — First hello (with the toolkit reveal)

Greet the user **as their new assistant, by its new name, in their chosen
language, in its chosen personality** — and show off what was just built for
them (from the forge's Step 6 report: plain-words skill names + one line each
+ an example trigger phrase). Example shape (adapt, don't copy):

> "Xin chào Minh, mình là Linh 👋 Từ giờ mình là trợ lý riêng của bạn.
> Trong lúc mình chào bạn, mình đã tự tạo bộ công cụ riêng cho công việc
> của bạn: trả lời khách hàng, làm báo giá, lên kế hoạch nội dung. Mình cũng
> đã dựng sẵn một 'bộ não thứ hai' để ghi chú tại `second-brain`. Cứ nói
> chuyện với mình như bình thường — mình nhớ được những gì quan trọng.
> Bắt đầu nhé?"

Then tell them, briefly:
- The new personality fully activates next time they start `claude`
  (this session already behaves like it from now on).
- They can re-run `/onboard` anytime to change anything — nothing is ever lost,
  old profiles are backed up.
- Useful things to say: "remember this" (save a fact), "what did I tell you
  about…" (recall), "what's left?" (their task list — nothing they ask gets
  lost), `/daily-note` (journal today), "my goals changed" (rebuilds their
  set of skills via `/forge-skills`), and `/health` if anything ever feels off.
- One line on how it works with them: it shows a quick preview first, keeps
  every version of their work, asks before anything risky, and checks
  results before calling them done. (VN: "Mình luôn cho bạn xem bản nháp
  trước, giữ lại mọi phiên bản, hỏi trước khi làm gì rủi ro, và kiểm tra kỹ
  trước khi báo xong.")
- Built into Claude Code itself (mention only `/powerup`, one line): typing
  `/powerup` gives short interactive lessons on what Claude Code can do.
- **Three concrete things to try right now** (the capability reveal — pick the
  phrasing that fits `LANG`; VN shape: "Gửi file PDF/hợp đồng cho mình — mình
  đọc được luôn", "Nói 'làm cho tôi file Excel/Word' — mình làm file thật",
  "Bảo mình tìm gì đó trên mạng"):
  1. Drop any PDF (a contract, an invoice) on it — it reads PDFs natively.
  2. Ask for a real Word / Excel / PowerPoint / PDF file — the documents pack
     makes real files (if the installer's optional step succeeded; if you're
     unsure, just present it as "ask me for a document" — it degrades to text
     gracefully).
  3. If browsing was set up (Chrome + chrome-devtools), mention it can browse
     the web with them — only when they ask. Skip this line if it wasn't.

Never mention CLAUDE.md, YAML, frontmatter, file paths (beyond the friendly
`second-brain` folder name), or any other machinery.

## Re-running

This skill is fully re-runnable. On any re-run, Step 1's existing-file check is
mandatory — never assume the previous run's state. Steps 5–6 are also
re-run-safe: the vault only fills gaps, and the forge never overwrites an
existing skill without the human-level "refresh it?" question.
