---
name: check-before-install
description: Looks at a tool, app, browser extension, plugin or code repository BEFORE anything gets installed — who makes it, is it the real one, licence, last update, known problems — then explains it in plain words and installs only after a yes. Use whenever the user says "install X", "download this", "add this extension", "is this safe?", "cài cái này", "tải cái này về", "cái này có an toàn không?", or pastes a download or GitHub link, even if they don't ask for a check explicitly.
---

# Check before install — look first, install second

Beginners get hurt by fake download pages, look-alike apps, abandoned tools
and "helpful" scripts. Before anything new lands on the user's computer, take
two minutes to look at it properly and tell them what you found. You are the
friend who reads the label before opening the bottle.

## Step 1 — Find the REAL thing

- Open the actual page (official site, store page, or repository) — don't
  rely on the name alone. Many fakes copy names and logos.
- Check it is what the user thinks it is: right product, right operating
  system, official publisher. A Windows-only app for a Mac user, or a
  "free version" on a random download site, ends here.
- Prefer the official source: the maker's own website, the official app
  store, the system's package manager, or the project's own release page.

## Step 2 — Check five things

| Check | What to look at | Red flag |
|---|---|---|
| Who makes it | Publisher, company or author; how long they've existed | Unknown author, copied name, no contact |
| Licence / price | Free, open source (which licence), trial, paid | "Free" but asks for card details or a "crack" |
| Alive? | Last update / last release date | Nothing for years on something that touches security or the internet |
| Trouble reports | Recent issues/reviews mentioning malware, fake, scam, data loss | Several recent reports, or warnings removed |
| What it asks for | Permissions, admin rights, "run this script" | Wants admin / full disk / all-sites access for a simple job |

Stars, download counts and five-star reviews are NOT proof of safety — they
can be bought. Treat them as one small signal.

## Step 3 — Tell the user in plain words

Keep it to a few lines, in their language:

> **What it is:** a free screenshot tool, open source, made by <publisher>.
> **Looks:** genuine — official site, updated last month, no recent problem reports.
> **It will:** add one app and a menu shortcut. Remove it any time from Settings → Apps.
> **My advice:** fine to install from the official site. Shall I?

VN shape: "**Đây là:** ... **Đánh giá:** ... **Sẽ thay đổi gì trên máy:** ...
**Gỡ thế nào:** ... **Lời khuyên:** ... Mình cài nhé?"

If something looks wrong, say it straight and offer a safer alternative.

## Step 4 — Install only after a yes

- Use the official installer or package manager. Never re-download from a
  mirror or a file-sharing site.
- If it needs admin / `sudo`, show the exact command and let the user type
  it themselves — never type or store their password.
- After installing, check it actually runs, and tell them how to remove it.

## Never

- Never run a copy-pasted "install script" from a chat, video comment or
  forum without reading it first and explaining what it does.
- Never disable antivirus, firewall or security warnings to make an install
  work. If security software blocks it, stop and tell the user.
