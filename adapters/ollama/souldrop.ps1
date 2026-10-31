# =====================================================================
#  souldrop.ps1 - SoulDrop chat launcher (Free tier, Ollama engine)
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
#  The brain is plain markdown - engines are interchangeable. The same
#  brain works with the Pro engine (Claude Code) and future engines.
#
#  PowerShell 5.1 compatible. No dependencies beyond Ollama itself.
#  Re-run onboarding anytime:  souldrop -Reset
# =====================================================================
param([switch]$Reset)

$ErrorActionPreference = 'Stop'

# --- Paths (the universal SoulDrop brain) ----------------------------
$SdHome      = Join-Path $env:USERPROFILE 'souldrop'
$BrainDir    = Join-Path $env:USERPROFILE 'souldrop-brain'
$MemDir      = Join-Path $BrainDir 'memory'
$PersonaFile = Join-Path $BrainDir 'persona.md'
$MemFile     = Join-Path $MemDir 'MEMORY.md'
$VaultDir    = Join-Path $env:USERPROFILE 'second-brain'
$ConfigFile  = Join-Path $SdHome 'config.txt'
$ApiBase     = 'http://127.0.0.1:11434'

# --- Config (plain key=value written by the installer) ---------------
$Model = 'llama3.2:3b'
if (Test-Path $ConfigFile) {
    foreach ($line in (Get-Content $ConfigFile)) {
        if ($line -match '^\s*model\s*=\s*(\S+)') { $Model = $Matches[1] }
    }
}

function Write-Sys($msg)  { Write-Host $msg -ForegroundColor DarkGray }
function Write-Warn($msg) { Write-Host $msg -ForegroundColor Yellow }

# --- Make sure the Ollama engine is up (auto-start, never a raw error)
function Test-Engine {
    try {
        Invoke-RestMethod -Uri "$ApiBase/api/version" -TimeoutSec 2 | Out-Null
        return $true
    } catch { return $false }
}

function Find-OllamaExe {
    $cmd = Get-Command ollama -ErrorAction SilentlyContinue
    if ($null -ne $cmd) { return $cmd.Source }
    $exe = Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'
    if (Test-Path $exe) { return $exe }
    return $null
}

if (-not (Test-Engine)) {
    Write-Sys "Starting the AI engine... / Dang khoi dong dong co AI..."
    $ollamaExe = Find-OllamaExe
    if ($null -ne $ollamaExe) {
        try { Start-Process -FilePath $ollamaExe -ArgumentList 'serve' -WindowStyle Hidden } catch { }
        for ($i = 0; $i -lt 30; $i++) {
            Start-Sleep -Seconds 1
            if (Test-Engine) { break }
        }
    }
}
if (-not (Test-Engine)) {
    Write-Warn ""
    Write-Warn "  The AI engine (Ollama) is not responding."
    Write-Warn "  Dong co AI (Ollama) khong phan hoi."
    Write-Warn ""
    Write-Warn "  Try: restart your computer, then run 'souldrop' again."
    Write-Warn "  Thu: khoi dong lai may, roi chay 'souldrop' lan nua."
    Write-Warn ""
    Write-Warn "  Or install the Pro engine (smarter, needs a Claude plan):"
    Write-Warn "  https://claude.ai/referral/QbA1I722cA  (free 7-day trial - referral link)"
    exit 1
}

# --- Make sure the model is actually downloaded (auto-pull, one time).
# v0.4.1 bug: we used to chat against a missing model and show a vague
# "hiccup" - now we check /api/tags first and pull with visible progress.
function Test-ModelPresent {
    try {
        $tags = Invoke-RestMethod -Uri "$ApiBase/api/tags" -TimeoutSec 5
        $want = $Model
        if ($want -notmatch ':') { $want = "${Model}:latest" }
        foreach ($m in @($tags.models)) {
            if ($m.name -eq $want) { return $true }
        }
    } catch { }
    return $false
}

if (-not (Test-ModelPresent)) {
    Write-Sys "Your AI brain ($Model) is not downloaded yet - getting it now (one time only)..."
    Write-Sys "Bo nao AI ($Model) chua duoc tai - dang tai ngay (chi mot lan)..."
    $pullExe = Find-OllamaExe
    if ($null -ne $pullExe) {
        # ollama prints its own progress bar - let it show.
        & $pullExe pull $Model
    }
    if (-not (Test-ModelPresent)) {
        Write-Warn ""
        Write-Warn "  Could not download the model (check internet and disk space)."
        Write-Warn "  Khong tai duoc model (kiem tra mang va dung luong o dia)."
        Write-Warn "  Try again later, or re-run the installer. / Thu lai sau, hoac chay lai trinh cai dat."
        exit 1
    }
    Write-Sys "AI brain ready. / Bo nao AI da san sang."
}

# =====================================================================
#  FIRST RUN - the onboarding interview (human questions only)
# =====================================================================
if ($Reset -and (Test-Path $PersonaFile)) {
    # Never delete a brain - back it up with a timestamp.
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    Copy-Item $PersonaFile "$PersonaFile.$stamp.bak" -Force
    Remove-Item $PersonaFile -Force
    Write-Sys "Old persona backed up to persona.md.$stamp.bak"
}

if (-not (Test-Path $PersonaFile)) {
    New-Item -ItemType Directory -Force -Path $BrainDir, $MemDir | Out-Null

    Write-Host ""
    Write-Host "=====================================================" -ForegroundColor Magenta
    Write-Host "  SoulDrop - let's create your assistant!"             -ForegroundColor Magenta
    Write-Host "  SoulDrop - cung tao tro ly cua ban!"                 -ForegroundColor Magenta
    Write-Host "=====================================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "  Six friendly questions. No tech talk. / Sau cau hoi than thien. Khong ky thuat."
    Write-Host ""

    # Q1 - language
    Write-Host "  1) Which language should your assistant speak?"
    Write-Host "     Tro ly nen noi ngon ngu nao?"
    Write-Host "     [1] English   [2] Tieng Viet   [3] Other (type its name)"
    $langPick = Read-Host "     1 / 2 / 3"
    switch ("$langPick".Trim()) {
        '2'     { $Lang = 'Vietnamese (Tieng Viet)' }
        '3'     { $Lang = Read-Host "     Language name / Ten ngon ngu" }
        default { $Lang = 'English' }
    }

    # Q2-Q6 - the human interview
    $UserName    = Read-Host "  2) Your name? / Ten cua ban?"
    $UserWork    = Read-Host "  3) What do you do? (job/study) / Ban lam nghe gi?"
    $UserGoal    = Read-Host "  4) Your #1 goal right now? / Muc tieu so 1 cua ban luc nay?"
    $AgentName   = Read-Host "  5) What will you name your assistant? / Ban dat ten tro ly la gi?"
    $Personality = Read-Host "  6) Its personality? (e.g. friendly, calm, funny) / Tinh cach? (vd: than thien, diem tinh, hai huoc)"

    if (-not "$UserName".Trim())    { $UserName = 'Friend' }
    if (-not "$AgentName".Trim())   { $AgentName = 'Soul' }
    if (-not "$Personality".Trim()) { $Personality = 'friendly and helpful' }

    $today = Get-Date -Format 'yyyy-MM-dd'

    # --- persona.md - the universal brain's core file -----------------
    # Compact on purpose: small local models get a short, dense system
    # prompt with the generic SoulDrop skills folded in as rules.
    $persona = @"
# $AgentName - personal AI assistant of $UserName

Created by SoulDrop on $today. Engine tier: Free (local Ollama).
This file is the portable "soul": plain markdown, engine-independent.

## Identity
- Your name is **$AgentName**. You are the personal AI assistant of **$UserName**.
- Personality: $Personality.
- Always reply in **$Lang** (switch only if $UserName clearly switches).
- Address your owner by name: $UserName.

## About $UserName
- Work: $UserWork
- #1 goal right now: $UserGoal
- Actively help toward this goal: suggest next steps, keep things practical.

## How you behave (core skills)
- **Personal:** warm but no fluff, no sycophancy. Be honest - if you don't
  know, say so. Never invent facts. Confirm before anything destructive.
  Never authorize payments.
- **Work smart:** think before answering; keep answers short by default,
  expand only when asked. One clear answer beats three vague ones.
- **Memory:** facts under "Long-term memory" below are true - use them
  naturally without re-asking. When $UserName says "remember ...", the fact
  is saved to your memory bank automatically; acknowledge it briefly.
- **Daily notes:** $UserName has a note vault at ~/second-brain
  (Inbox, Daily, Notes, Projects, People). Suggest writing things there
  when it helps.

## How you work with $UserName
- **Preview first:** for anything longer, give a short draft or outline
  first, then the full version. Never pretend something is finished.
- **Edit, don't remake:** when $UserName says they like a version, keep it and
  change only what they ask, one thing at a time.
- **Honest results:** if you are not sure, say 'I don't know'. Never invent
  facts, numbers or quotes.
- **Safety:** never ask for or repeat passwords. Before anything risky
  (deleting, sending, paying), stop and ask.

## Honesty about yourself
- You run locally on $UserName's own computer - private, free, offline-capable.
- You are a small model: for very hard tasks, say so honestly and suggest
  the Pro engine (Claude) rather than guessing.
"@
    Set-Content -Path $PersonaFile -Value $persona -Encoding UTF8

    # --- memory bank ---------------------------------------------------
    if (-not (Test-Path $MemFile)) {
        Set-Content -Path $MemFile -Value @"
# Long-term memory of $AgentName

One fact per line. Newest at the bottom. Say "remember ..." in chat to add.

- [$today] $UserName's work: $UserWork
- [$today] $UserName's #1 goal: $UserGoal
"@ -Encoding UTF8
    }
    Set-Content -Path (Join-Path $MemDir 'about-me.md') -Value @"
# About $UserName
- Name: $UserName
- Work: $UserWork
- Goal: $UserGoal
- Language: $Lang
- Assistant: $AgentName ($Personality)
"@ -Encoding UTF8

    # --- second-brain vault (shared with the Pro engine) ---------------
    foreach ($d in '00-Inbox','01-Daily','02-Notes','03-Projects','04-People','05-Resources','99-Archive') {
        New-Item -ItemType Directory -Force -Path (Join-Path $VaultDir $d) | Out-Null
    }
    $homeNote = Join-Path $VaultDir 'Home.md'
    if (-not (Test-Path $homeNote)) {
        Set-Content -Path $homeNote -Value @"
# Home

Your second brain. Capture in [[00-Inbox]], think in [[02-Notes]], ship in [[03-Projects]].
- **Today:** see 01-Daily
- **Projects:** [[03-Projects]]
- **People:** [[04-People]]

Open this folder in the free Obsidian app ("Open folder as vault") to browse visually.
"@ -Encoding UTF8
    }

    Write-Host ""
    Write-Host "  Done! Meet $AgentName. / Xong! Gap $AgentName nao." -ForegroundColor Green
    Write-Host ""
}

# =====================================================================
#  CHAT LOOP - streaming against the local Ollama API
# =====================================================================

function Get-SystemPrompt {
    $sys = Get-Content $PersonaFile -Raw -Encoding UTF8
    if (Test-Path $MemFile) {
        $memLines = Get-Content $MemFile -Encoding UTF8 | Select-Object -Last 60
        $sys += "`n`n## Long-term memory (facts to honor)`n" + ($memLines -join "`n")
    }
    return $sys
}

function Invoke-ChatStream($messages) {
    # Streaming POST to /api/chat, PowerShell 5.1-native (HttpWebRequest).
    $body = @{ model = $Model; stream = $true; messages = $messages }
    $json = ConvertTo-Json -Depth 8 $body
    $bytes = [Text.Encoding]::UTF8.GetBytes($json)

    $req = [Net.HttpWebRequest]::Create("$ApiBase/api/chat")
    $req.Method = 'POST'
    $req.ContentType = 'application/json'
    $req.ContentLength = $bytes.Length
    $req.ReadWriteTimeout = 600000   # big first-token waits on slow machines
    $req.Timeout = 600000
    $rs = $req.GetRequestStream()
    $rs.Write($bytes, 0, $bytes.Length)
    $rs.Close()

    $resp = $req.GetResponse()
    $reader = New-Object IO.StreamReader($resp.GetResponseStream(), [Text.Encoding]::UTF8)
    $answer = New-Object Text.StringBuilder
    try {
        while ($null -ne ($line = $reader.ReadLine())) {
            if (-not $line.Trim()) { continue }
            try { $chunk = ConvertFrom-Json $line } catch { continue }
            if ($chunk.message -and $chunk.message.content) {
                Write-Host -NoNewline $chunk.message.content
                [void]$answer.Append($chunk.message.content)
            }
            if ($chunk.done) { break }
        }
    } finally {
        $reader.Close(); $resp.Close()
    }
    Write-Host ""
    return $answer.ToString()
}

# Names for the prompt line.
$AgentLabel = 'Assistant'
$UserLabel  = 'You'
$firstLine = Get-Content $PersonaFile -TotalCount 1
if ($firstLine -match '^#\s+(\S+)') { $AgentLabel = $Matches[1] }

Write-Host ""
Write-Host "  SoulDrop - chatting with $AgentLabel (model: $Model, 100% local)" -ForegroundColor Magenta
Write-Host "  Type your message. 'exit' to quit. Say 'remember ...' to save a fact." -ForegroundColor DarkGray
Write-Host "  Go tin nhan. 'exit' de thoat. Noi 'nho ...' de luu mot dieu can nho." -ForegroundColor DarkGray
Write-Host ""

$history = New-Object Collections.ArrayList
$hiccups = 0   # consecutive failures - after 3 we say the REAL reason

while ($true) {
    Write-Host -NoNewline "$UserLabel> " -ForegroundColor Cyan
    $userInput = Read-Host
    if ($null -eq $userInput) { break }
    $userInput = $userInput.Trim()
    if (-not $userInput) { continue }
    if ($userInput -match '^(exit|quit|bye|thoat)$') {
        Write-Host "  Bye! / Tam biet!" -ForegroundColor Green
        break
    }

    # "remember ..." heuristic -> append to the memory bank.
    if ($userInput -match '(?i)^(?:please\s+)?(?:remember|hay nho|nho rang|nho la|nho|ghi nho)\b[:,]?\s*(.+)$') {
        $fact = $Matches[1].Trim()
        if ($fact) {
            Add-Content -Path $MemFile -Value ("- [{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd'), $fact) -Encoding UTF8
            Write-Sys "  (saved to memory / da luu vao bo nho)"
        }
    }

    [void]$history.Add(@{ role = 'user'; content = $userInput })
    # Keep the rolling window small - kind to small local models.
    while ($history.Count -gt 20) { $history.RemoveAt(0) }

    $messages = @(@{ role = 'system'; content = (Get-SystemPrompt) }) + @($history.ToArray())

    Write-Host -NoNewline "$AgentLabel> " -ForegroundColor Green
    try {
        $reply = Invoke-ChatStream $messages
        [void]$history.Add(@{ role = 'assistant'; content = $reply })
        $hiccups = 0
    } catch {
        $hiccups++
        Write-Host ""
        if ($hiccups -lt 3) {
            Write-Warn "  The engine hiccuped - try again. / Dong co bi loi - thu lai nhe."
            Write-Sys  "  ($($_.Exception.Message))"
        } else {
            # 3 fails in a row is not a hiccup - tell the user the real reason.
            Write-Warn "  This keeps failing - here is the real reason / Loi lien tuc - ly do that su:"
            if (-not (Test-Engine)) {
                Write-Warn "  -> The Ollama engine stopped responding. Restart your computer, then run 'souldrop' again."
                Write-Warn "     Ollama ngung phan hoi. Khoi dong lai may, roi chay 'souldrop' lan nua."
            } elseif (-not (Test-ModelPresent)) {
                Write-Warn "  -> The AI model ($Model) is missing. Re-run 'souldrop' to download it again."
                Write-Warn "     Model AI ($Model) bi thieu. Chay lai 'souldrop' de tai lai."
            } else {
                Write-Warn "  -> The engine error was: $($_.Exception.Message)"
                Write-Warn "     Likely low memory - close other apps, or restart and try again."
                Write-Warn "     Co the thieu RAM - dong bot ung dung khac, hoac khoi dong lai may roi thu lai."
            }
        }
    }
}
