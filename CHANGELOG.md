# Changelog

All notable changes to this project are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/) · Versioning: [SemVer](https://semver.org/).

## [0.7.0] — 2026-10-31

The **"Works like a pro"** release: SoulDrop catches up with four months of
Claude Code changes, and every assistant it builds now follows proven working
habits — track every request, preview first, edit instead of remaking, keep
every version, check before saying "done".

### Fixed (Claude Code changed under us)
- **`/doctor` → `/health`.** Claude Code now ships its own built-in `/doctor`
  (a setup checkup), which takes the bare name, so SoulDrop's check could no
  longer be reached as `/doctor`. It is now `/health` (or `/souldrop:health`);
  the health card ends with a tip telling the two apart.
- **Safety net on Windows.** The hook only matched the `Bash` tool; on Windows
  Claude Code can route shell commands through its **PowerShell tool**, which
  the guard never saw. It now matches `Bash|PowerShell`, runs in exec form
  (`node` + `args`), and sets `onFailure: "continue"` so a missing Node never
  blocks the user's work. guard.js also catches Remove-Item aliases, `-r`/`-rec`
  prefixes, `$env:USERPROFILE` and `cmd /c rd /s` wrappers. Tests: 33 → 54
  (incl. end-to-end stdin runs for both tool shapes).
- **Taste pass.** taste-skill reorganised upstream and the folders the forge
  copied are gone, so design users silently got nothing. The forge now
  installs the `taste-skill` plugin from its author's own marketplace (web/app
  design work only; needs Node 22+ and a Chromium browser, per upstream).
- **Plan wording**: "a paid Claude plan (Pro or higher)" everywhere.
- **Browsing** now requires Node **20.19+** (chrome-devtools-mcp's engine
  range); 20.0–20.18 used to pass our check and then fail.

### Added
- **`/todo` — nothing gets lost.** Every real request becomes a line in
  `~/.claude/memory/tasks.md` (doing / waiting for you / done), marked done only
  after the user has seen the result. Ask "what's left?" / "còn gì chưa xong?"
  anytime; open items are mentioned once at the start of a session.
- **`check-before-install`.** Before any app, extension, plugin or repo is
  installed: is it the real one, who makes it, licence, last update, trouble
  reports, what it will change — explained in plain words, installed only
  after a yes, never with the user's password typed by the assistant.
- **"How I work" + "Safety" in every profile** (CLAUDE.md template, EN/VI):
  preview first and never silent; honest progress words; once something is
  approved it is locked and later changes *edit* it one step at a time;
  every version kept (`-v2`, `-v3`), nothing deleted without the user;
  check the real result before saying "done", say "I don't know" when true;
  options side by side; back up before changing a file and say how to undo;
  ask before delete/send/pay/install; never type a password.
- **learn-from-mistakes** is now a step-by-step loop that also fixes the skill or
  profile line that caused the mistake (with a backup).
- **create-skill**: "edit, don't remake" with numbered versions.
- **leader**: optional planner → maker → checker mode (the checker sees the
  real output, not the maker's summary) using built-in subagents.
- **forge-skills**: plain image-prompt habits for skills that make images.
- **Health check** also verifies Claude Code ≥ 2.1.295 (suggests
  `claude update`), whether SoulDrop is up to date, Node for browsing, and
  whether the safety net can run.
- README: "How your assistant works with you" and "Built into Claude Code"
  (`/powerup`, `/doctor`, `/memory`, `/insights`) sections (EN + VI; one-line
  summary in TH/KO/ZH).
- Free tier persona (both launchers + brain template): compact version of the
  same working habits.

### Changed
- Installers (both, in sync): one-step `claude plugin install <p>
  --marketplace <source>` (Claude Code 2.1.292+) with the classic two-step as
  fallback; 5 steps instead of 6; Claude Code older than 2.1.295 gets one
  `claude update`; plain note when the safety net is off for lack of Node
  (Linux: shows the `sudo` line for the user to type — we never sudo).
- Optional `SOULDROP_ENGINE=pro|free` and `SOULDROP_REF=<branch|tag>` for
  scripted and branch testing. Default behaviour unchanged.
- Custom commands were merged into skills upstream: the duplicate
  `commands/*.md` files are gone; `setup-vault` is a real skill now;
  `uninstall` only runs when typed.
- Profile template: one line separating SoulDrop's personal memory
  (`~/.claude/memory/`) from Claude Code's automatic project memory.
- Demo animation uses a neutral example user.

### Not changed (on purpose)
- Free-tier models stay as they are (llama3.x). Newer small models look
  stronger for Vietnamese, but we only switch after a real VN chat test on
  each size — planned for v0.8.

## [0.6.0] — 2026-07-06

The **"Superior"** release: capability breadth + trust. The assistant stops
being "chat that remembers" and starts producing real files, browsing, and
diagnosing itself — every new piece optional, silent-skip, zero questions.

### Added
- **Everyday-tools pack** in both installers (new Pro Step 4/6, fully
  non-blocking):
  - **Documents pack** — Anthropic's official document skills
    (`claude plugin marketplace add anthropics/skills` +
    `claude plugin install document-skills@anthropic-agent-skills`): the
    assistant now makes REAL Word/Excel/PowerPoint/PDF files. Installed from
    Anthropic's own marketplace, never vendored (source-available license).
    Creative extras (`example-skills`, Apache-2.0, incl. canvas-design)
    installed the same way.
  - **Browsing power** — `claude mcp add chrome-devtools --scope user --
    npx chrome-devtools-mcp@latest` (Google's chrome-devtools MCP, no
    account/key), gated on Chrome actually being installed (registry /
    App Paths / standard paths on Windows; `/Applications` on macOS;
    `google-chrome`/`chromium` on Linux) and Node 20+ (auto-installed via
    winget/brew where safe). No Chrome → one friendly "install Chrome to
    unlock it" line, never an error.
  - Node.js bootstrap refactored into shared helpers
    (`Ensure-NodeLts` / `ensure_node`) reused by browsing + smart memory.
- **`/doctor`** — health check command + skill: verifies engine, plugin,
  profile, memory bank, custom toolkit, second brain, documents pack,
  browsing, and the Free-tier Ollama state; quietly auto-fixes what's safe
  (re-install plugin, recreate missing scaffolding, re-register the MCP) and
  prints one bilingual, jargon-free health card. Never touches brain files.
- **Taste pass in the forge** — for design/web/content/slides professions,
  `forge-skills` now also installs 1–2 matching pro taste skills
  (`design-taste-frontend`, `high-end-visual-design`) from
  [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) (MIT,
  57k★) — fetched at forge time via shallow git clone, upstream LICENSE
  copied alongside, attribution added to NOTICE. Non-design professions get
  nothing extra (no bloat).
- **Capability gallery** — `assets/gallery/` six self-made SVG conversation
  cards (VN primary, brand style, honest "minh họa · illustration" footer —
  explicitly not fake screenshots): read-a-PDF, make-an-Excel, remember,
  forged quote-builder, daily-note, free-local. Embedded as a "What can it
  do?" grid in all 5 READMEs. TODO kept to swap in real captured sessions.
- **Uninstall section** in all 5 READMEs — one line
  (`claude plugin uninstall souldrop ; claude plugin marketplace remove souldrop`)
  plus the promise: brain files are never auto-deleted.
- **PDF reading advertised** — the built-in capability is now told to the
  user: `/onboard`'s final hello lists 3 concrete things to try, both
  installers print a "drop a PDF on it" closing line, and the READMEs say it.
- **Taste locks** recorded in `.github/README-design-notes.md`: amber = Pro,
  teal = Free semantics; rx 16/10/4 radius trio; one dominant install CTA;
  gallery honesty rule.

- **Safety-net hook** (`plugins/souldrop/hooks/`) — a PreToolUse hook on the
  Bash tool blocks the obviously catastrophic commands a beginner should
  never see run: `rm -rf` on `/`/home/drive roots, `del`/`rd /s` on a drive
  root, `Remove-Item -Recurse` on roots, `diskpart`, `mkfs`,
  `Format-Volume`/`format C:`, fork bombs — with a bilingual friendly
  denial ("Lệnh này nguy hiểm — trợ lý đã chặn để bảo vệ bạn"); and
  `git reset --hard` surfaces the permission prompt (ask, not deny) so the
  human decides. Pure-Node guard (Windows+macOS+Linux), fail-open by design
  (any hook error → command proceeds; the net never breaks the flow),
  33-case self-test (`hooks/guard.test.js`) wired into CI.
- **`/uninstall`** — real removal command: one plain-words confirmation,
  removes plugin + marketplace + the extras the installer added (read from
  the manifest), optional documents-pack removal — and NEVER deletes the
  brain (profile, memories, second-brain stay; the goodbye message says so).
  README uninstall sections now lead with `/uninstall`; the one-liner stays
  as the manual fallback.
- **Install manifest** — both installers write `~/.souldrop/installed.json`
  (SoulDrop version, engine, date, which extras actually installed);
  `/doctor` and `/uninstall` read it. `/doctor` now opens its health card
  with the version ("SoulDrop v0.6.0") prominently.

### Changed
- Pro installer steps renumbered 5 → 6; NOTICE now covers the Anthropic
  marketplace installs, chrome-devtools-mcp, agentmemory, and taste-skill.
- Engines table: Pro row now lists real Office/PDF files + browsing;
  "coming in v0.6" for other engines corrected to "planned".
- **Plugin-path hardening:** every skill/command now resolves plugin files
  via `${CLAUDE_PLUGIN_ROOT}` only — relative paths like
  `../../templates/vault/` were unreliable at runtime because the working
  directory is not the skill's directory (onboard vault copy, i18n +
  CLAUDE.md/MEMORY.md templates, forge domain-map, create-skill template).
- CI: new `hooks` job (hooks.json parses + guard self-tests).

### Roadmap (considered for v0.6.0, deliberately deferred to v0.7+)
- Install profiles (Minimal / Standard / Full) · non-interactive `--yes`
  flag · auto-update check · web-based onboarding · GitHub Pages docs site ·
  SoulDrop cloud · Telegram bridge · multi-soul switching · voice mode.

### Pending (release ritual)
- Push to GitHub, cut the **v0.6.0 release** with `SoulDrop-Installer.bat`
  attached as a release asset, and record the demo videos for the reserved
  README slots. Sandbox-test both installers end-to-end.

## [0.5.1] — 2026-07-05

The Windows walkthrough gets siblings: **macOS and Linux hand-holding at the
same quality level**, in all 5 README languages.

### Added
- **🍎 "How to open Terminal on a Mac"** section in all 5 READMEs
  (Vietnamese primary): Cmd ⌘ + Space → type "Terminal" → Enter → paste with
  Cmd + V — with **4 new SVG step cards**
  (`assets/guide/open-terminal-mac-1..4.svg`) in the exact same brand style
  as the PowerShell cards (dark tile, gold badge, teal highlight, simplified
  self-drawn mockups — Spotlight bar, Mac keyboard, terminal window; no real
  Apple UI copied). The Mac one-paste command (`curl … | bash`) is repeated
  right beside the cards, plus an honest note about Apple's
  "command line developer tools" dialog (click Install, re-run). No
  Gatekeeper warning to explain — the script is piped straight to bash, so
  there is no quarantined file.
- **🐧 "Opening a terminal on Linux"** section in all 5 READMEs (shorter, 2
  SVG cards: `open-terminal-linux-1..2.svg`): Ctrl + Alt + T on most
  distros, paste with **Ctrl + Shift + V** (not Ctrl+V — the classic
  beginner trap), and an honest note that the installer **never runs sudo by
  itself** — it prints the `apt-get` hint for the user to run themselves
  (matches existing `go.sh` behavior).
- Walkthrough restructured as three platform subsections — 🪟 Windows ·
  🍎 macOS · 🐧 Linux — with a pick-your-system line in the intro. The
  one-click `.bat` stays clearly labeled Windows-only, and Mac users get a
  pointer that the one-paste command is their easiest path. The
  macOS / Linux install line now links to the illustrated guide, same as the
  Windows line always did.

### Idea for later
- A downloadable double-click `.command` file for Mac (the `.bat`
  equivalent) was considered and postponed: as a downloaded file it would be
  quarantined and hit the Gatekeeper "unidentified developer" wall — exactly
  the friction the piped one-paste command avoids. Revisit if we ever sign
  the installer.

## [0.5.0] — 2026-07-05

The **beginner-love** release: hand-hold everything, one-click for lazy people.
Nobody should ever have to install a tool by hand again.

### Added
- **One-click installer for Windows:** `SoulDrop-Installer.bat` at the repo
  root — download, double-click, done. It relaunches the official `go.ps1`
  with `-ExecutionPolicy Bypass` and pauses at the end so the window never
  vanishes. READMEs explain the SmartScreen "More info → Run anyway" step
  honestly (it appears for any unsigned download).
- **Git auto-install:** `claude plugin marketplace add` clones this repo with
  git, so both installers now install git themselves when it's missing —
  winget `Git.Git` on Windows; brew or Apple's Command Line Tools on macOS;
  a one-line `apt-get` hint on Linux (we never auto-sudo). Silent,
  non-blocking, one friendly line — users are never told to install git.
- **Complete beginner walkthrough** in all 5 READMEs (Vietnamese richest):
  how to open PowerShell with 4 self-made SVG step cards
  (`assets/guide/open-powershell-1..4.svg`, brand palette, simplified UI —
  no copyrighted screenshots); **two ways to use Claude** — Claude Desktop's
  built-in Code tab (`/plugin marketplace add` + `/plugin install` +
  `/onboard`, no terminal at all) vs the CLI, as a friendly Easy-vs-Power
  table; manual Ollama install with a pick-your-model-by-RAM table; and a
  "🎬 Video tutorials" slot wired for GitHub's inline-player rule (only
  `user-attachments` uploads render inline — repo `.mp4` files do not; see
  `assets/media/README.md` for the drop-zone recipe).
- README install section now has **two paths**: 🖱️ download-and-double-click
  (the .bat) and ⌨️ the one-paste command.

### Fixed
- **Ollama launchers (`adapters/ollama/souldrop.ps1` / `.sh`): model checked
  before chat.** The launcher now verifies the model exists via `/api/tags`
  and auto-pulls it with visible progress if missing — no more chatting into
  a void. After 3 consecutive chat failures it states the REAL reason
  (engine down / model missing / likely low memory) instead of repeating
  "the engine hiccuped".
- **`go.sh`:** no more raw `/dev/tty` error line when there is no usable
  terminal (CI, containers) — the engine question quietly defaults to Free.
- **`go.ps1` / `go.sh`:** no longer print "OK: Official installer finished"
  when Anthropic's installer actually failed — the failure is now caught and
  reported honestly, with the usual fix (low RAM ≈ 512 MB free needed; open
  a new terminal and re-run).

### Changed
- Future-engine mentions (Codex · Antigravity · OpenClaw) moved from
  "v0.5" to "v0.6" in READMEs and `assets/engines.svg` — this release is
  about beginners, not new engines.

## [0.4.0] — 2026-07-05

The **SoulDrop** release: rebrand + multi-engine architecture + a free tier.
"Drop a soul into any machine — your personal AI assistant, fully automatic."

### Presentation & CI (2026-07-05 — README pro redesign, no version bump)
- **README hero redesign, all 5 languages:** centered logo (dark/light
  `<picture>` swap), shields.io badge row (CI · version · license · platform ·
  languages · PRs-welcome), language switcher in the hero, **animated SVG
  terminal demo** (`assets/demo.svg` — the full install → `/onboard` →
  skill-forge flow, ~18 s CSS-animated loop that plays right on GitHub),
  engines illustration, emoji section icons, centered footer. All prose and
  install URLs unchanged — presentation only.
- **New self-made SVG assets** in `assets/`: `logo.svg` (+`-dark`/`-light`),
  `banner.svg`, `demo.svg` (animated), `engines.svg` (animated connectors,
  abstract engine shapes — no trademarked artwork).
- **CI:** `.github/workflows/validate.yml` — JSON manifest parse, `bash -n`
  on shell scripts, PowerShell AST parse on `.ps1`, and a SKILL.md
  frontmatter lint (`.github/scripts/lint-skills.mjs`). Status badge in
  every README.

### Renamed
- **Project renamed: `claude-easy-install` → `souldrop` (product name: SoulDrop).**
  Marketplace name, plugin name (`nick-starter` → `souldrop`), plugin folder
  (`plugins/nick-starter/` → `plugins/souldrop/`), install URLs, banners, and
  all five READMEs. Old GitHub URLs redirect automatically. New install:
  `claude plugin marketplace add kkitkai/souldrop` +
  `claude plugin install souldrop@souldrop`.

### Added
- **One brain, many engines.** New `brain/` spec: the portable assistant =
  persona file + memory bank + second-brain vault, all plain markdown —
  engines are interchangeable. New `adapters/` layer with a written adapter
  contract (install engine → install brain → wire persona → report status)
  so future engines (Codex, Antigravity, OpenClaw — v0.5) slot in without
  restructuring. `adapters/claude-code/` documents the existing Pro flow.
- **FREE TIER (Ollama, local).** For people with no subscription:
  - Engine auto-detect in both bootstraps: Claude Code present → Pro path,
    zero questions; otherwise ONE bilingual human question — Free (local,
    no account) or Pro (smarter, needs a Claude plan).
  - Free path, fully automatic: installs Ollama via official channels only
    (winget `Ollama.Ollama` / Homebrew / ollama.com install.sh), detects
    system RAM and picks a fitting model (≥16 GB → `llama3.1:8b`, 8–16 GB →
    `llama3.2:3b`, <8 GB → `llama3.2:1b` with an honest "it's basic" note),
    starts the server, pulls the model with visible progress.
  - **`souldrop` chat launcher** (`adapters/ollama/souldrop.ps1` /
    `souldrop.sh` — installed to the user's machine + Desktop shortcut /
    PATH command): first run is the onboarding interview (six human
    questions: language, name, work, goal, assistant name, personality) →
    writes the universal brain (`~/souldrop-brain/persona.md` + `memory/` +
    shared `~/second-brain/` vault); every run streams chat against the
    local `/api/chat` with persona + recent memory as system prompt; saying
    "remember ..." appends to the memory bank live. PowerShell 5.1-native /
    bash+curl with python3-assisted streaming and a pure-shell fallback —
    zero extra dependencies. `-Reset`/`--reset` re-onboards (old persona
    backed up, never deleted).
  - No skill-forge on this tier (small models can't author skills reliably);
    the generic SoulDrop skills' content is folded into the persona instead.
  - Every failure on the free path = one friendly bilingual line + pointer
    to the Pro path with the referral link. Never a stuck beginner.
- NOTICE now covers Ollama (installed via official channels, never re-hosted).

### Changed
- READMEs (all 5 languages) restructured around SoulDrop: bilingual tagline,
  "Choose your engine" table (Pro / Free / coming-soon engines), per-engine
  install + next steps, "One brain, many engines" section, free-tier FAQ.
- Bumped plugin + marketplace manifests to 0.4.0.

## [0.3.0] — 2026-07-05

The "everything automatic" release. Design rule enforced everywhere: the user
answers only HUMAN questions (name, profession, goal, assistant name,
personality, language); every technical step is automatic and non-blocking —
a failure means one friendly line, never a stuck beginner or a raw error.

### Added
- **Auto skill-forge (`forge-skills`)** — at the end of `/onboard`, the
  assistant automatically derives 3–5 tightly-scoped custom skills from the
  user's profession + goal (bundled `templates/domain-map.md` heuristics +
  reasoning over their free-text goal), generates each `SKILL.md` (Anthropic
  frontmatter spec: kebab name, pushy third-person description with concrete
  triggers), runs a 9-point quality gate (frontmatter lint, dedup, max 2
  regen retries — a failing skill is never installed), installs survivors to
  `~/.claude/skills/`, and greets the user showing what it built.
  Re-runnable anytime via `/forge-skills` or "my goals changed".
- **`create-skill`** — interactive single-skill author; same quality gate as
  the forge, beginner-safe wording ("teach your assistant a new ability").
- **`leader`** — generic plan → decompose → delegate → verify → report-one-
  answer orchestration doctrine.
- **`personal`** — personal-assistant baseline: persona-first, recall-before-
  asking, save-without-being-told memory habit, honesty + safety boundaries.
- **Auto second brain** — `/onboard` now auto-creates an Obsidian-compatible
  vault at `~/second-brain` (skeleton in `templates/vault/`: `.obsidian/`
  config, 7 folders, `Home.md`, `README.md`); `/setup-vault` re-runs it.
  New generic skills: `obsidian-markdown` (wikilinks/tags/callouts
  conventions) and `obsidian-cli` (safe vault file operations).
- **Bootstrap extras (both installers, silent + non-blocking):** Step 4 tries
  Node.js LTS (winget / Homebrew) + the open-source agentmemory plugin
  (`rohitg00/agentmemory`, Apache-2.0) for semantic memory — installed from a
  stable `~/.agentmemory` CWD so its data store persists; Step 5 tries the
  free Obsidian app (winget / Homebrew cask). Any failure prints one friendly
  line ("Smart memory skipped — your assistant still remembers via files")
  and continues.
- **Referral (disclosed):** the installers show a labeled referral line for a
  free 7-day Pro trial ONLY when no Claude login is detected; one line in
  each README's Requirements. Once per surface, always labeled "referral".
- `templates/SKILL.md.tmpl` — shared output template for forge + create-skill.

### Changed
- `/onboard` interview now also captures profession ("What do you do?") and a
  free-text #1 goal — the forge's fuel; recorded in the profile's new
  "About" section and `about-me.md`. Still zero technical questions.
- `CLAUDE.md.tmpl` gained the About section (profession + goal).
- `i18n.md` gained VI/TH/KO/ZH strings for the new questions + forge intro.
- Bumped plugin + marketplace manifests to 0.3.0; READMEs (all 5 languages)
  document the auto-forge, the second brain, and the referral.
- Install command URLs unchanged.

## [0.2.0] — 2026-07-05

### Added
- **Multi-language onboarding.** `/onboard`'s language gate now offers
  English · Tiếng Việt (primary) · ไทย · 한국어 · 中文, plus an "Other" escape
  that runs the interview in any language the user names. Language is a single
  clean variable through the whole flow — questions, preview, generated
  profile, and first greeting all follow it; the profile records the chosen
  reply language.
- `skills/onboard/templates/i18n.md` — compact native interview strings for
  VI/TH/KO/ZH (English canonical in SKILL.md), so adding a language later is
  one new block + one gate option.
- Translated READMEs with a language switcher on every page:
  `README.vi.md`, `README.th.md`, `README.ko.md`, `README.zh.md`.
  `README.md` is now English-primary (Vietnamese content moved to
  `README.vi.md`). EN & VI are the primary supported onboarding languages;
  TH/KO/ZH fully supported, others best-effort.

### Changed
- Bumped plugin + marketplace manifests to 0.2.0; descriptions/keywords now
  reflect the five supported languages.
- Install scripts, commands, and URLs unchanged.

## [0.1.0] — 2026-07-05

### Added
- First MVP release.
- `install/go.ps1` / `install/go.sh` — one-paste bootstrap: calls Anthropic's
  official Claude Code installer, then adds this marketplace and installs the
  `nick-starter` plugin. Idempotent, no admin, PowerShell 5.1-compatible.
- Plugin marketplace manifest (`.claude-plugin/marketplace.json`).
- `nick-starter` plugin v0.1.0:
  - `/onboard` — bilingual (VN/EN) interview that generates a personalized
    assistant profile (`~/.claude/CLAUDE.md`) and a memory scaffold
    (`~/.claude/memory/`), with backup/merge guardrails and preview-confirm.
  - Core skills: `work-smart`, `remember`, `recall`, `learn-from-mistakes`,
    `daily-note`.
  - Templates: `CLAUDE.md.tmpl`, `MEMORY.md.tmpl`.
- Bilingual README (EN/VN), MIT LICENSE, NOTICE.

### Notes
- SessionStart auto-hint hook deliberately deferred: plugin hooks are supported,
  but a hook command that runs reliably on beginner Windows machines (no bash,
  PowerShell 5.1) needs its own testing pass. Planned for 0.2.0. The bootstrap
  script and README both tell the user to type `/onboard`.
