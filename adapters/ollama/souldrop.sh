#!/usr/bin/env bash
# =====================================================================
#  souldrop.sh — SoulDrop chat launcher (Free tier, Ollama engine)
#
#  Your personal AI assistant, running 100% on your own computer.
#  Tro ly AI ca nhan cua ban, chay 100% tren may cua ban.
#
#  What it does:
#   - First run: a friendly interview (name, work, goal, assistant name,
#     personality, language) -> writes your universal SoulDrop brain:
#       ~/souldrop-brain/persona.md      (who your assistant is)
#       ~/souldrop-brain/memory/         (long-term memory bank)
#       ~/second-brain/                  (note vault - Obsidian-compatible)
#   - Every run: loads the brain as the system prompt and chats with the
#     local Ollama model (streaming). Say "remember ..." to save a fact.
#
#  The brain is plain markdown — engines are interchangeable. The same
#  brain works with the Pro engine (Claude Code) and future engines.
#
#  Dependencies: bash + curl (+ python3 if present, for perfect streaming;
#  falls back to a pure-shell parser without it).
#  Re-run onboarding anytime:  souldrop --reset
# =====================================================================
set -u

# --- Paths (the universal SoulDrop brain) ----------------------------
SD_HOME="$HOME/.souldrop"
BRAIN_DIR="$HOME/souldrop-brain"
MEM_DIR="$BRAIN_DIR/memory"
PERSONA_FILE="$BRAIN_DIR/persona.md"
MEM_FILE="$MEM_DIR/MEMORY.md"
VAULT_DIR="$HOME/second-brain"
CONFIG_FILE="$SD_HOME/config.txt"
API_BASE="http://127.0.0.1:11434"

sys_line()  { printf '\033[90m%s\033[0m\n' "$1"; }
warn_line() { printf '\033[33m%s\033[0m\n' "$1"; }

# --- Config (plain key=value written by the installer) ---------------
MODEL="llama3.2:3b"
if [ -f "$CONFIG_FILE" ]; then
  M="$(sed -n 's/^[[:space:]]*model[[:space:]]*=[[:space:]]*//p' "$CONFIG_FILE" | head -n1)"
  [ -n "$M" ] && MODEL="$M"
fi

# --- python3 for perfect JSON handling (macOS: only if CLT is real,
# otherwise the python3 stub pops the Xcode install dialog) ------------
PY=""
if command -v python3 >/dev/null 2>&1; then
  if [ "$(uname -s)" != "Darwin" ] || xcode-select -p >/dev/null 2>&1; then
    PY="python3"
  fi
fi

# --- Make sure the Ollama engine is up (auto-start, never a raw error)
engine_up() { curl -fsS --max-time 2 "$API_BASE/api/version" >/dev/null 2>&1; }

if ! engine_up; then
  sys_line "Starting the AI engine... / Dang khoi dong dong co AI..."
  if command -v ollama >/dev/null 2>&1; then
    nohup ollama serve >/dev/null 2>&1 &
    i=0
    while [ "$i" -lt 30 ]; do
      sleep 1
      engine_up && break
      i=$((i + 1))
    done
  fi
fi
if ! engine_up; then
  warn_line ""
  warn_line "  The AI engine (Ollama) is not responding."
  warn_line "  Dong co AI (Ollama) khong phan hoi."
  warn_line ""
  warn_line "  Try: open a new terminal and run 'souldrop' again."
  warn_line "  Thu: mo terminal moi va chay 'souldrop' lan nua."
  warn_line ""
  warn_line "  Or install the Pro engine (smarter, needs a Claude plan):"
  warn_line "  https://claude.ai/referral/QbA1I722cA  (free 7-day trial - referral link)"
  exit 1
fi

# --- Make sure the model is actually downloaded (auto-pull, one time).
# v0.4.1 bug: we used to chat against a missing model and show a vague
# "hiccup" — now we check /api/tags first and pull with visible progress.
model_present() {
  case "$MODEL" in
    *:*) WANT="\"name\":\"$MODEL\"" ;;
    *)   WANT="\"name\":\"$MODEL:latest\"" ;;
  esac
  curl -fsS --max-time 5 "$API_BASE/api/tags" 2>/dev/null | grep -qF "$WANT"
}

if ! model_present; then
  sys_line "Your AI brain ($MODEL) is not downloaded yet - getting it now (one time only)..."
  sys_line "Bo nao AI ($MODEL) chua duoc tai - dang tai ngay (chi mot lan)..."
  # ollama prints its own progress bar — let it show.
  ollama pull "$MODEL" || true
  if ! model_present; then
    warn_line ""
    warn_line "  Could not download the model (check internet and disk space)."
    warn_line "  Khong tai duoc model (kiem tra mang va dung luong o dia)."
    warn_line "  Try again later, or re-run the installer. / Thu lai sau, hoac chay lai trinh cai dat."
    exit 1
  fi
  sys_line "AI brain ready. / Bo nao AI da san sang."
fi

# =====================================================================
#  FIRST RUN — the onboarding interview (human questions only)
# =====================================================================
if [ "${1:-}" = "--reset" ] && [ -f "$PERSONA_FILE" ]; then
  # Never delete a brain — back it up with a timestamp.
  STAMP="$(date +%Y%m%d-%H%M%S)"
  cp "$PERSONA_FILE" "$PERSONA_FILE.$STAMP.bak"
  rm -f "$PERSONA_FILE"
  sys_line "Old persona backed up to persona.md.$STAMP.bak"
fi

if [ ! -f "$PERSONA_FILE" ]; then
  mkdir -p "$BRAIN_DIR" "$MEM_DIR"

  printf '\n\033[35m=====================================================\n'
  printf '  SoulDrop - lets create your assistant!\n'
  printf '  SoulDrop - cung tao tro ly cua ban!\n'
  printf '=====================================================\033[0m\n\n'
  printf '  Six friendly questions. No tech talk. / Sau cau hoi than thien. Khong ky thuat.\n\n'

  printf '  1) Which language should your assistant speak?\n'
  printf '     Tro ly nen noi ngon ngu nao?\n'
  printf '     [1] English   [2] Tieng Viet   [3] Other (type its name)\n'
  printf '     1 / 2 / 3: '
  read -r LANG_PICK || LANG_PICK="1"
  case "$(printf '%s' "$LANG_PICK" | tr -d '[:space:]')" in
    2) LANG_NAME="Vietnamese (Tieng Viet)" ;;
    3) printf '     Language name / Ten ngon ngu: '; read -r LANG_NAME || LANG_NAME="English" ;;
    *) LANG_NAME="English" ;;
  esac

  printf '  2) Your name? / Ten cua ban? '
  read -r USER_NAME || USER_NAME=""
  printf '  3) What do you do? (job/study) / Ban lam nghe gi? '
  read -r USER_WORK || USER_WORK=""
  printf '  4) Your #1 goal right now? / Muc tieu so 1 cua ban luc nay? '
  read -r USER_GOAL || USER_GOAL=""
  printf '  5) What will you name your assistant? / Ban dat ten tro ly la gi? '
  read -r AGENT_NAME || AGENT_NAME=""
  printf '  6) Its personality? (e.g. friendly, calm, funny) / Tinh cach? '
  read -r PERSONALITY || PERSONALITY=""

  [ -n "$(printf '%s' "$USER_NAME" | tr -d '[:space:]')" ]   || USER_NAME="Friend"
  [ -n "$(printf '%s' "$AGENT_NAME" | tr -d '[:space:]')" ]  || AGENT_NAME="Soul"
  [ -n "$(printf '%s' "$PERSONALITY" | tr -d '[:space:]')" ] || PERSONALITY="friendly and helpful"

  TODAY="$(date +%Y-%m-%d)"

  # --- persona.md — the universal brain's core file -------------------
  # Compact on purpose: small local models get a short, dense system
  # prompt with the generic SoulDrop skills folded in as rules.
  cat > "$PERSONA_FILE" <<EOF
# $AGENT_NAME — personal AI assistant of $USER_NAME

Created by SoulDrop on $TODAY. Engine tier: Free (local Ollama).
This file is the portable "soul": plain markdown, engine-independent.

## Identity
- Your name is **$AGENT_NAME**. You are the personal AI assistant of **$USER_NAME**.
- Personality: $PERSONALITY.
- Always reply in **$LANG_NAME** (switch only if $USER_NAME clearly switches).
- Address your owner by name: $USER_NAME.

## About $USER_NAME
- Work: $USER_WORK
- #1 goal right now: $USER_GOAL
- Actively help toward this goal: suggest next steps, keep things practical.

## How you behave (core skills)
- **Personal:** warm but no fluff, no sycophancy. Be honest — if you don't
  know, say so. Never invent facts. Confirm before anything destructive.
  Never authorize payments.
- **Work smart:** think before answering; keep answers short by default,
  expand only when asked. One clear answer beats three vague ones.
- **Memory:** facts under "Long-term memory" below are true — use them
  naturally without re-asking. When $USER_NAME says "remember ...", the fact
  is saved to your memory bank automatically; acknowledge it briefly.
- **Daily notes:** $USER_NAME has a note vault at ~/second-brain
  (Inbox, Daily, Notes, Projects, People). Suggest writing things there
  when it helps.

## How you work with $USER_NAME
- **Preview first:** for anything longer, give a short draft or outline
  first, then the full version. Never pretend something is finished.
- **Edit, don't remake:** when $USER_NAME says they like a version, keep it and
  change only what they ask, one thing at a time.
- **Honest results:** if you are not sure, say "I don't know". Never invent
  facts, numbers or quotes.
- **Safety:** never ask for or repeat passwords. Before anything risky
  (deleting, sending, paying), stop and ask.

## Honesty about yourself
- You run locally on $USER_NAME's own computer — private, free, offline-capable.
- You are a small model: for very hard tasks, say so honestly and suggest
  the Pro engine (Claude) rather than guessing.
EOF

  # --- memory bank -----------------------------------------------------
  if [ ! -f "$MEM_FILE" ]; then
    cat > "$MEM_FILE" <<EOF
# Long-term memory of $AGENT_NAME

One fact per line. Newest at the bottom. Say "remember ..." in chat to add.

- [$TODAY] $USER_NAME's work: $USER_WORK
- [$TODAY] $USER_NAME's #1 goal: $USER_GOAL
EOF
  fi
  cat > "$MEM_DIR/about-me.md" <<EOF
# About $USER_NAME
- Name: $USER_NAME
- Work: $USER_WORK
- Goal: $USER_GOAL
- Language: $LANG_NAME
- Assistant: $AGENT_NAME ($PERSONALITY)
EOF

  # --- second-brain vault (shared with the Pro engine) -----------------
  for d in 00-Inbox 01-Daily 02-Notes 03-Projects 04-People 05-Resources 99-Archive; do
    mkdir -p "$VAULT_DIR/$d"
  done
  if [ ! -f "$VAULT_DIR/Home.md" ]; then
    cat > "$VAULT_DIR/Home.md" <<'EOF'
# Home

Your second brain. Capture in [[00-Inbox]], think in [[02-Notes]], ship in [[03-Projects]].
- **Today:** see 01-Daily
- **Projects:** [[03-Projects]]
- **People:** [[04-People]]

Open this folder in the free Obsidian app ("Open folder as vault") to browse visually.
EOF
  fi

  printf '\n\033[32m  Done! Meet %s. / Xong! Gap %s nao.\033[0m\n\n' "$AGENT_NAME" "$AGENT_NAME"
fi

# =====================================================================
#  CHAT LOOP — streaming against the local Ollama API
# =====================================================================

AGENT_LABEL="$(head -n1 "$PERSONA_FILE" | sed -n 's/^# *\([^ ]*\).*/\1/p')"
[ -n "$AGENT_LABEL" ] || AGENT_LABEL="Assistant"

json_escape() {
  # stdin -> a JSON string literal (with quotes).
  if [ -n "$PY" ]; then
    $PY -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
  else
    # Pure-shell fallback: escape backslash, quote; input is one line.
    printf '"%s"' "$(sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')"
  fi
}

build_system_prompt() {
  cat "$PERSONA_FILE"
  if [ -f "$MEM_FILE" ]; then
    printf '\n\n## Long-term memory (facts to honor)\n'
    tail -n 60 "$MEM_FILE"
  fi
}

# Rolling message history as ready-made JSON objects.
MSGS=()
HICCUPS=0   # consecutive failures — after 3 we say the REAL reason

printf '\n\033[35m  SoulDrop - chatting with %s (model: %s, 100%% local)\033[0m\n' "$AGENT_LABEL" "$MODEL"
printf '\033[90m  Type your message. "exit" to quit. Say "remember ..." to save a fact.\n'
printf '  Go tin nhan. "exit" de thoat. Noi "nho ..." de luu mot dieu can nho.\033[0m\n\n'

REQ_FILE="$(mktemp 2>/dev/null || printf '%s' "$SD_HOME/req.json")"
trap 'rm -f "$REQ_FILE"' EXIT

while true; do
  printf '\033[36mYou> \033[0m'
  IFS= read -r USER_INPUT || break
  USER_INPUT="$(printf '%s' "$USER_INPUT" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  [ -n "$USER_INPUT" ] || continue
  case "$USER_INPUT" in
    exit|quit|bye|thoat) printf '\033[32m  Bye! / Tam biet!\033[0m\n'; break ;;
  esac

  # "remember ..." heuristic -> append to the memory bank.
  if printf '%s' "$USER_INPUT" | grep -qiE '^(please +)?(remember|hay nho|nho rang|nho la|nho|ghi nho)[:,]? +.'; then
    FACT="$(printf '%s' "$USER_INPUT" | sed -E 's/^[Pp]lease +//; s/^([Rr]emember|[Hh]ay nho|[Nn]ho rang|[Nn]ho la|[Nn]ho|[Gg]hi nho)[:,]? +//')"
    if [ -n "$FACT" ]; then
      printf -- '- [%s] %s\n' "$(date +%Y-%m-%d)" "$FACT" >> "$MEM_FILE"
      sys_line "  (saved to memory / da luu vao bo nho)"
    fi
  fi

  USER_JSON="$(printf '%s' "$USER_INPUT" | json_escape)"
  MSGS+=("{\"role\":\"user\",\"content\":$USER_JSON}")
  # Keep the rolling window small — kind to small local models.
  while [ "${#MSGS[@]}" -gt 20 ]; do MSGS=("${MSGS[@]:2}"); done

  SYS_JSON="$(build_system_prompt | json_escape)"
  MSG_LIST="{\"role\":\"system\",\"content\":$SYS_JSON}"
  for m in "${MSGS[@]}"; do MSG_LIST="$MSG_LIST,$m"; done

  printf '\033[32m%s> \033[0m' "$AGENT_LABEL"

  if [ -n "$PY" ]; then
    # Streaming: chunks shown live via stderr, full reply captured via stdout.
    printf '{"model":"%s","stream":true,"messages":[%s]}' "$MODEL" "$MSG_LIST" > "$REQ_FILE"
    REPLY="$(curl -sN --max-time 600 "$API_BASE/api/chat" -d @"$REQ_FILE" | $PY -c '
import sys, json
full = []
for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    try:
        j = json.loads(line)
    except ValueError:
        continue
    c = j.get("message", {}).get("content", "")
    if c:
        sys.stderr.write(c); sys.stderr.flush()
        full.append(c)
    if j.get("done"):
        break
sys.stderr.write("\n")
sys.stdout.write("".join(full))')"
  else
    # Fallback without python3: non-streaming + careful shell extraction.
    printf '{"model":"%s","stream":false,"messages":[%s]}' "$MODEL" "$MSG_LIST" > "$REQ_FILE"
    RESP="$(curl -fsS --max-time 600 "$API_BASE/api/chat" -d @"$REQ_FILE" 2>/dev/null || true)"
    REPLY="$(printf '%s' "$RESP" \
      | sed -e 's/.*"message":{"role":"assistant","content":"//' -e 's/"},"done.*//' \
      | sed -e 's/\\"/"/g')"
    # Interpret \n, \t, \\ escapes for display.
    printf '%b\n' "$REPLY"
  fi

  if [ -z "$REPLY" ]; then
    HICCUPS=$((HICCUPS + 1))
    if [ "$HICCUPS" -lt 3 ]; then
      warn_line "  The engine hiccuped - try again. / Dong co bi loi - thu lai nhe."
    else
      # 3 fails in a row is not a hiccup — tell the user the real reason.
      warn_line "  This keeps failing - here is the real reason / Loi lien tuc - ly do that su:"
      if ! engine_up; then
        warn_line "  -> The Ollama engine stopped responding. Open a new terminal and run 'souldrop' again."
        warn_line "     Ollama ngung phan hoi. Mo terminal moi va chay 'souldrop' lan nua."
      elif ! model_present; then
        warn_line "  -> The AI model ($MODEL) is missing. Re-run 'souldrop' to download it again."
        warn_line "     Model AI ($MODEL) bi thieu. Chay lai 'souldrop' de tai lai."
      else
        warn_line "  -> The engine returned empty replies. Likely low memory - close other apps and try again."
        warn_line "     Dong co tra loi rong. Co the thieu RAM - dong bot ung dung khac roi thu lai."
      fi
    fi
    # Drop the unanswered user turn so history stays consistent.
    MSGS=("${MSGS[@]:0:${#MSGS[@]}-1}")
    continue
  fi
  HICCUPS=0

  REPLY_JSON="$(printf '%s' "$REPLY" | json_escape)"
  MSGS+=("{\"role\":\"assistant\",\"content\":$REPLY_JSON}")
done
