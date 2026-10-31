<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
  <img src="assets/logo.svg" alt="SoulDrop — 안에 불꽃을 품은 물방울" width="110">
</picture>

# SoulDrop

**어떤 컴퓨터에든 영혼을 떨어뜨리세요 — 당신만의 개인 AI 어시스턴트, 완전 자동.**
<br>
<sub><i>Drop a soul into any machine — your personal AI assistant, fully automatic.</i></sub>

<br>
<br>

[![CI](https://img.shields.io/github/actions/workflow/status/kkitkai/souldrop/validate.yml?branch=main&style=flat-square&label=CI&labelColor=20242C)](https://github.com/kkitkai/souldrop/actions/workflows/validate.yml)
[![Version](https://img.shields.io/badge/version-0.7.0-E8B04B?style=flat-square&labelColor=20242C)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/license-MIT-2FD6C3?style=flat-square&labelColor=20242C)](LICENSE)
![Platform](https://img.shields.io/badge/platform-Windows%20%C2%B7%20macOS%20%C2%B7%20Linux-4A5568?style=flat-square&labelColor=20242C)
![Languages](https://img.shields.io/badge/languages-EN%20%C2%B7%20VI%20%C2%B7%20TH%20%C2%B7%20KO%20%C2%B7%20ZH-E8B04B?style=flat-square&labelColor=20242C)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-2FD6C3?style=flat-square&labelColor=20242C)](https://github.com/kkitkai/souldrop/pulls)

<br>

[English](README.md) · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · **한국어** · [中文](README.zh.md)

<br>

<img src="assets/demo.svg" alt="애니메이션 데모 — 명령어 하나로 SoulDrop이 설치되고 /onboard 인터뷰가 실행되어 커스텀 스킬 4개를 가진 개인 어시스턴트가 완성됩니다" width="780">

</div>

명령어 하나. 친근한 인터뷰(기술 질문은 절대 없음). 결과는 자기만의 이름, 성격, 장기 기억, "두 번째 뇌"를 가진 어시스턴트 — 당신에게 맞는 엔진에서 실행됩니다. **유료든, 100% 무료든.**

> 영어와 베트남어가 기본 지원 언어입니다. 태국어·한국어·중국어는 완전히 지원되며, 그 외 언어도 "기타" 옵션으로 사용할 수 있습니다.

---

## 🚀 설치

설치 프로그램이 **모든 것**을 알아서 처리합니다 — 필요한 보조 도구(git, Node...)까지 포함해서요. 미리 직접 설치할 것은 하나도 없습니다.

### 🖱️ 가장 쉬운 방법 (Windows) — 파일 1개 받아서 더블클릭

1. **[여기서 설치 파일 다운로드](https://raw.githubusercontent.com/kkitkai/souldrop/main/SoulDrop-Installer.bat)** — 링크를 **우클릭** → **"다른 이름으로 링크 저장..."** → 바탕화면에 저장하세요.
2. 받은 `SoulDrop-Installer.bat` 파일을 **더블클릭**하세요. 끝 — 설치가 저절로 진행됩니다.
3. Windows가 파란 SmartScreen 경고를 띄우면: **"추가 정보"** → **"실행"**을 누르세요. 솔직히 말씀드리면: 이 경고는 서명되지 않은 *모든* 인터넷 다운로드 파일에 뜹니다 — 이 파일은 아래의 공식 설치 스크립트를 호출할 뿐이고, 메모장으로 열어 직접 읽어볼 수 있습니다.

*Mac을 쓰시나요? 위 파일은 Windows 전용입니다 — 가장 쉬운 방법은 바로 아래의 한 줄 명령어입니다: 복사해서 한 번만 붙여넣으면 끝.*

### ⌨️ 명령어 한 줄 방식 (PowerShell / 터미널이 익숙한 분)

**Windows** — **PowerShell**을 열고(방법을 모르신다면 [아래 그림 가이드](#-왕초보를-위한-단계별-가이드) 참고) 붙여넣기:

```powershell
irm https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.ps1 | iex
```

**macOS / Linux** — **터미널**을 열고(방법을 모르신다면 [아래 그림 가이드](#-왕초보를-위한-단계별-가이드) 참고) 붙여넣기:

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

### 그다음

**Pro 엔진 (Claude):**
1. `claude`를 입력하고 Enter, 브라우저가 열리면 로그인하세요 (유료 요금제 필요).
2. `/onboard`를 입력하고 언어를 선택하면 새 어시스턴트를 만납니다 — 인사하기 전에 직업에 맞는 커스텀 스킬 3–5개까지 만들어 둡니다.
3. 바로 시험해 보세요: **PDF나 계약서를 던져 주면 — 그대로 읽습니다.** 또는 *"엑셀 파일 만들어 줘"*라고 말해 보세요 — 설치 프로그램이 진짜 Word/Excel/PowerPoint/PDF 파일을 만드는 문서 팩을 추가했습니다 (Chrome이 있다면 함께 웹 서핑도 합니다).

**무료 엔진 (로컬):**
1. 바탕화면의 **SoulDrop**을 더블클릭(Windows)하거나 새 터미널에서 `souldrop`을 입력하세요.
2. 친근한 질문 6개(이름, 하는 일, 목표, 어시스턴트 이름...)에 답하면 끝. 모든 것이 당신 컴퓨터에서 실행되고, 아무것도 밖으로 나가지 않습니다.

## ✨ 무엇을 할 수 있나요?

일상적인 일들을 평범한 대화로 시킵니다. 아래 카드는 실제 대화를 단순화한 일러스트(베트남어)이며 — 스크린샷이 아닙니다:

<table>
<tr>
<td><img src="assets/gallery/read-pdf.svg" alt="PDF나 계약서를 던져 주면 — 그대로 읽습니다" width="390"></td>
<td><img src="assets/gallery/make-excel.svg" alt="한 마디면 — 수식이 들어간 진짜 엑셀 파일" width="390"></td>
</tr>
<tr>
<td><img src="assets/gallery/remember.svg" alt="'기억해'라고 말하면 — 일주일 뒤에도 기억합니다" width="390"></td>
<td><img src="assets/gallery/custom-skill.svg" alt="직업에 맞는 커스텀 스킬을 스스로 만듭니다 — 예: 사진작가의 견적서 작성" width="390"></td>
</tr>
<tr>
<td><img src="assets/gallery/daily-note.svg" alt="하루 한 줄이 두 번째 뇌 안의 연간 일기가 됩니다" width="390"></td>
<td><img src="assets/gallery/free-local.svg" alt="무료 티어는 100% 내 컴퓨터에서 — 계정도 비용도 없음" width="390"></td>
</tr>
</table>

<!-- Maintainers: replace these illustration cards with real captured session
     screenshots/recordings once the demo sessions are recorded. -->

## 🧭 왕초보를 위한 단계별 가이드

> "명령줄"을 한 번도 써본 적 없으신가요? 괜찮습니다 — 이 섹션이 그림과 함께 한 단계씩 안내합니다. 천천히 따라오세요. 사용 중인 컴퓨터를 고르세요: 🪟 Windows · 🍎 macOS · 🐧 Linux.

### 🪟 PowerShell 여는 방법 (Windows)

<img src="assets/guide/open-powershell-1.svg" alt="1단계 — Windows 키 누르기 (키보드 왼쪽 아래, 사각형 4개 로고 키)" width="740">
<img src="assets/guide/open-powershell-2.svg" alt="2단계 — PowerShell 입력; 검색창이 저절로 열립니다" width="740">
<img src="assets/guide/open-powershell-3.svg" alt="3단계 — Enter 누르기; 진한 파란색 창이 열리면 그것이 PowerShell입니다" width="740">
<img src="assets/guide/open-powershell-4.svg" alt="4단계 — 설치 명령어 붙여넣기 (우클릭 = 붙여넣기) 후 Enter" width="740">

팁: PowerShell에서는 **우클릭 = 붙여넣기**입니다. 위의 설치 명령어를 📋 버튼으로 복사하고, 파란 창에 우클릭한 뒤 Enter — 끝입니다.

### 🍎 Mac에서 터미널 여는 방법

<img src="assets/guide/open-terminal-mac-1.svg" alt="1단계 — Cmd ⌘ + Space를 동시에 눌러 Spotlight 열기" width="740">
<img src="assets/guide/open-terminal-mac-2.svg" alt="2단계 — Spotlight 검색창에 Terminal 입력" width="740">
<img src="assets/guide/open-terminal-mac-3.svg" alt="3단계 — Enter 누르기; 터미널 창이 열립니다" width="740">
<img src="assets/guide/open-terminal-mac-4.svg" alt="4단계 — Cmd + V로 설치 명령어 붙여넣고 Enter" width="740">

Mac에서 붙여넣을 명령어 (코드 블록 오른쪽 위 📋 버튼으로 복사):

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

팁: Mac에서는 **붙여넣기 = Cmd ⌘ + V**입니다 (Ctrl+V 아님). **"command line developer tools"**를 설치하겠냐는 창이 뜨면 **Install**을 누르세요 — 설치 프로그램에 필요한 Apple 공식 도구입니다. 설치가 끝나면 위 명령어를 다시 실행하세요.

### 🐧 Linux에서 터미널 열기

<img src="assets/guide/open-terminal-linux-1.svg" alt="1단계 — Ctrl + Alt + T를 눌러 터미널 열기" width="740">
<img src="assets/guide/open-terminal-linux-2.svg" alt="2단계 — Ctrl + Shift + V로 설치 명령어 붙여넣고 Enter" width="740">

**Ctrl + Alt + T**를 누르세요 (대부분의 배포판: Ubuntu, Mint...) — 또는 앱 메뉴에서 "Terminal"을 찾으세요. 아래 명령어를 붙여넣고 Enter를 누르세요 (**터미널 안에서 붙여넣기 = Ctrl + Shift + V**, Ctrl+V 아님):

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

솔직한 안내: 설치 프로그램은 **절대 sudo를 스스로 실행하지 않습니다**. git이 없으면 `sudo apt-get install -y git` 명령어를 출력해 **직접 실행하시도록** 안내할 뿐입니다. 실행하신 뒤 위 명령어를 다시 실행하세요 — 투명하게, 시스템 권한은 절대 임의로 건드리지 않습니다.

### Claude를 쓰는 두 가지 방법 — 맞는 쪽을 고르세요

이미 **Claude Desktop 앱에서 Claude와 대화**하고 계신가요? 그럼 SoulDrop을 **앱 안에서 바로** 쓸 수 있습니다 — 터미널이 전혀 필요 없습니다.

| | 🖥️ Claude Desktop — *가장 쉬움* | ⚡ Claude CLI — *파워 버전* |
|---|---|---|
| 추천 대상 | 이미 Claude와 대화하는 초보자 | 최대 성능을 원하는 분 |
| 터미널 필요? | **아니요** | 예 (PowerShell / 터미널) |
| 여는 방법 | Claude 앱 → **Code** 탭 클릭 | 터미널에 `claude` 입력 |
| 성능 | SoulDrop 스킬 전부 | 전부 + 더 깊은 자동화 |

**방법 A — Claude Desktop (터미널 불필요):**
1. [claude.com/download](https://claude.com/download)에서 앱을 받고 로그인하세요 (Pro 이상 요금제 필요).
2. 앱 상단의 **Code** 탭을 클릭하고 **Local**을 선택하세요.
3. 입력창에 이 두 명령을 차례로 입력하세요 (한 줄씩 복사, 붙여넣기, Enter):
   ```
   /plugin marketplace add kkitkai/souldrop
   /plugin install souldrop@souldrop
   ```
4. `/onboard`를 입력하세요 — 언어를 고르고 나만의 어시스턴트를 만나세요. 끝!

**방법 B — Claude CLI (긴 작업에 더 강력):** 위의 설치 섹션을 따라 한 뒤 → 터미널을 열고 → `claude` 입력 → `/onboard` 입력.

### Ollama 수동 설치 (무료 엔진 — 선택)

SoulDrop 설치 프로그램이 **Ollama를 이미 자동으로 설치**합니다 — 직접 하고 싶은 분만 보세요:

1. [ollama.com/download](https://ollama.com/download)에서 Windows / Mac 버전을 받아 일반 앱처럼 설치하세요.
2. PowerShell / 터미널을 열고 RAM에 맞는 모델을 받으세요:

   | 내 RAM | 이 명령 입력 | 다운로드 |
   |---|---|---|
   | 16 GB 이상 | `ollama pull llama3.1:8b` | ~4.9 GB |
   | 8–16 GB | `ollama pull llama3.2:3b` | ~2 GB |
   | 8 GB 미만 | `ollama pull llama3.2:1b` | ~1.3 GB |

3. 위의 SoulDrop 설치 프로그램을 다시 실행하세요 — Ollama를 감지하고 나머지 단계를 이어갑니다.

### 🎬 튜토리얼 영상

<!-- Maintainers: drag the final .mp4 files into the GitHub web editor and paste
     the generated user-attachments URLs below — the only form GitHub renders inline. -->

*튜토리얼 영상(베트남어 보이스오버)이 준비 중입니다 — 곧 여기에 올라옵니다. 그때까지는 위의 그림 단계만으로 설치를 끝까지 마칠 수 있습니다.*

## 🧠 엔진을 선택하세요

<p align="center">
  <img src="assets/engines.svg" alt="하나의 뇌가 여러 엔진에 연결됩니다 — Claude Code (Pro), Ollama (무료, 로컬), 그리고 더 많은 엔진 예정" width="780">
</p>

SoulDrop은 **뇌**(어시스턴트가 누구인지 — 당신 소유의 일반 마크다운 파일)와 **엔진**(그것을 실행하는 것)을 분리합니다. 같은 영혼, 어떤 엔진이든:

| 엔진 | 비용 | 제공 내용 |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | 유료 Claude 요금제 (Pro 이상) | 가장 똑똑한 티어: 전체 스킬, **자동 스킬 단조**(직업에 맞는 커스텀 능력 자동 생성), 진짜 Word/Excel/PowerPoint/PDF 파일 생성, 내 Chrome으로 웹 서핑, 서브에이전트 |
| **무료 — [Ollama](https://ollama.com) (로컬)** | **0원, 계정 불필요** | 당신 컴퓨터에서 100% 실행되는 진짜 어시스턴트: 페르소나, 기억, "기억해...", 두 번째 뇌. 기본적으로 프라이빗 |
| Codex · Antigravity · OpenClaw | — | 🔜 계획 중 |

기술적인 선택은 필요 없습니다 — 설치 프로그램이 **Claude Code를 자동 감지**하고, 없으면 딱 한 가지만 묻습니다: *무료 또는 Pro?*

## 📦 요구 사항

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+, 설치 시 인터넷
- **무료 엔진:** 그 외 아무것도 필요 없음. AI 모델용 디스크 ~2–5 GB (RAM에 맞게 자동 선택)
- **Pro 엔진:** 유료 Claude 구독 (Pro 이상) — [claude.ai](https://claude.ai)
- **아직 Claude가 없나요?** 7일 무료 Pro 체험으로 시작 → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(추천 링크 — 이 프로젝트를 후원합니다)*

## 🔁 하나의 뇌, 여러 엔진

뇌는 **일반 마크다운 — 엔진은 교체 가능**합니다: 페르소나 파일(어시스턴트의 정체), 기억 은행(언제든 *"기억해..."*라고 말하면 저장), 그리고 모든 엔진이 공유하는 `~/second-brain` 노트 볼트. 모든 파일을 직접 읽고, 수정하고, 백업하고, 새 컴퓨터로 옮길 수 있습니다. 명세: [`brain/`](brain/README.md) · 새 엔진용 어댑터 계약: [`adapters/`](adapters/README.md).

## 🧩 Pro 플러그인 구성

| 스킬 | 기능 |
|---|---|
| `/onboard` | 개인화된 어시스턴트 + 기억 + 커스텀 스킬 + 두 번째 뇌를 만드는 인터뷰 — 영어, 베트남어, 태국어, 한국어, 중국어 또는 원하는 언어로 |
| `forge-skills` | **직업과 목표에 맞는 커스텀 스킬 3–5개를 자동 생성** — `/onboard` 끝에 자동 실행, 언제든 재실행 가능. 웹/앱 디자인 작업이라면 오픈소스 [taste-skill](https://github.com/Leonxlnx/taste-skill) 디자인 플러그인(MIT)도 설치합니다 |
| `/health` | **건강 검진** — 엔진, 플러그인, 프로필, 기억, 두 번째 뇌, 안전망, 부가 기능을 점검하고, 고칠 수 있는 것은 조용히 고친 뒤 친근한 보고서 하나를 보여줍니다 *(v0.7 이전 이름은 `/doctor` — 이제 `/doctor`는 Claude Code 자체를 점검하는 내장 명령입니다)* |
| `/todo` | **잊히는 일 없음** — 모든 요청이 결과를 전달할 때까지 할 일 목록의 한 줄(진행 중 / 당신을 기다리는 중 / 완료)로 관리됩니다. 언제든 *"남은 일 뭐야?"* 라고 물어보세요 |
| `check-before-install` | 앱·확장·도구를 설치하기 전에: 진짜인지, 누가 만들었는지, 라이선스, 최근 업데이트, 문제 보고를 확인하고 쉬운 말로 설명한 뒤 동의할 때만 설치합니다 |
| `/uninstall` | SoulDrop과 부가 기능을 깔끔하게 제거 — 프로필, 기억, 노트는 **항상 남습니다** |
| `create-skill` | 설명만 하면 어시스턴트가 새 능력을 직접 작성·설치 (단조와 같은 품질 기준) |
| `remember` | 사실/선호를 장기 기억에 저장 |
| `recall` | 이전에 말한 내용 검색 |
| `learn-from-mistakes` | 당신의 수정 사항을 영구 규칙으로 전환 |
| `daily-note` | 간단한 일일 일기 |
| `work-smart` | 행동 전에 계획하고 낭비 단계를 피하게 함 |
| `personal` | 개인 비서 기본기: 일관된 페르소나, 기억 습관, 정직함, 안전 경계 |
| `leader` | 큰 작업용: 계획, 분해, 위임, 검증, 하나의 깔끔한 답변으로 보고 |
| `/setup-vault` | `~/second-brain`에 두 번째 뇌 노트 볼트 (재)생성 — Obsidian 지원 |
| `obsidian-markdown` · `obsidian-cli` | 볼트 노트를 올바르게 작성·정리 (위키링크, 태그, 안전한 파일 작업) |

> **v0.7:** 모든 어시스턴트가 같은 방식으로 일합니다 — 먼저 초안을 보여 주고, 승인한 버전을 다시 만들지 않고 수정하며(모든 버전 보관), 실제 결과를 확인한 뒤에만 "완료"라고 하고, 파일을 고치기 전에 백업하고, 삭제·전송·결제·설치 전에는 묻습니다. 자세히: [영어 README](README.md#-how-your-assistant-works-with-you)

설치 프로그램은 **일상 도구 팩**도 추가합니다 — 전부 선택 사항이고, 설치가 안 되면 조용히 건너뜁니다: Anthropic 공식 **문서 팩**(어시스턴트가 진짜 Word/Excel/PowerPoint/PDF 파일을 생성), [chrome-devtools](https://github.com/ChromeDevTools/chrome-devtools-mcp)를 통한 **웹 서핑 능력**(Chrome이 이미 설치된 경우에만 — 계정도 키도 불필요), 창의적 그래픽 스킬, 스마트 메모리. 그리고 PDF **읽기**는 아무 설치도 필요 없습니다 — 기본 내장이니 그냥 PDF를 던져 주세요.

## 🆓 무료 엔진이 주는 것

`souldrop` 채팅 런처(바탕화면 바로가기 / 터미널 명령): 어시스턴트의 영혼을 로드하고, 컴퓨터에 맞게 선택된 로컬 모델에서 스트리밍으로 응답하며(RAM 16 GB+ → 8B 모델, 8–16 GB → 3B, 8 GB 미만 → 1B + "기본 수준"이라는 솔직한 안내), *"기억해..."*라고 말하면 사실을 저장하고, Pro 티어와 같은 두 번째 뇌를 씁니다. 이 티어에는 스킬 단조가 없습니다 — 작은 로컬 모델은 스킬 작성을 신뢰하기 어려워, SoulDrop 핵심 스킬의 내용을 페르소나에 직접 접어 넣었습니다. 언제든 설치 프로그램을 다시 실행해 Pro로 업그레이드하세요. 뇌는 함께 갑니다.

## 📔 당신의 두 번째 뇌

온보딩은 `~/second-brain`에 노트 볼트를 만듭니다 — 어시스턴트가 읽고 쓰는 일반 마크다운 파일(일일 노트, 프로젝트, 사람, 아이디어). 무료 [Obsidian](https://obsidian.md) 앱에서 이 폴더를 열면("Open folder as vault") 시각적으로 볼 수 있습니다 — Pro 설치 프로그램은 Obsidian 설치까지 시도하며, 안 되더라도 모든 것이 일반 파일로 작동합니다. Pro 설치 프로그램은 선택적 "스마트 메모리" 업그레이드(오픈소스 [agentmemory](https://github.com/rohitg00/agentmemory) 플러그인)도 시도합니다. 실패해도 어시스턴트는 파일로 모든 것을 기억합니다.

## 🧹 제거

가장 쉬운 방법: 어시스턴트 안에서 **`/uninstall`**을 입력하세요 — 한 번 확인한 뒤 SoulDrop과 설치했던 부가 기능을 제거하며, 뇌 파일은 건드리지 않습니다. 수동 한 줄 (PowerShell과 터미널 모두에서 작동):

```
claude plugin uninstall souldrop ; claude plugin marketplace remove souldrop
```

**남는 것 — 의도적으로:** 당신의 뇌입니다. `~/.claude/CLAUDE.md`(프로필), `~/.claude/memory/`(기억), `~/second-brain`(노트)은 당신 소유의 일반 파일입니다 — SoulDrop은 절대 자동으로 삭제하지 않습니다. 전부 지우고 싶다면 그 폴더들을 직접 삭제하세요. 무료 티어: 홈 폴더의 `souldrop` 폴더와 바탕화면 바로가기를 삭제하고, Ollama가 더 이상 필요 없다면 일반 앱처럼 제거하세요.

## ❓ FAQ

**Anthropic이나 Ollama의 공식 소프트웨어인가요?**
아니요. SoulDrop은 독립 스타터 키트입니다. Claude Code와 Ollama를 각자의 공식 설치 프로그램으로만 설치하고, 그 위에 SoulDrop 뇌를 얹습니다. [NOTICE](NOTICE) 참조.

**무료 버전은 정말 무료인가요?**
네. 로컬 엔진(Ollama)과 모델은 오픈소스이며 전부 당신 컴퓨터에서 실행됩니다. 계정도, 구독도, 숨은 비용도 없습니다 — 디스크 공간과 하드웨어만 쓰면 됩니다.

**설치 스크립트는 안전한가요?**
네 — 그리고 우리를 그냥 믿을 필요도 없습니다: [`install/go.ps1`](install/go.ps1)과 [`install/go.sh`](install/go.sh)를 직접 읽어 보세요. 공식 설치 프로그램 호출, 이 저장소를 플러그인 마켓플레이스로 등록, 런처 설치만 합니다. Windows SmartScreen이나 백신이 인터넷 스크립트에 경고를 띄울 수 있지만 이 설치 방식에서는 정상입니다.

**실수로 두 번 실행했어요.**
괜찮습니다 — 스크립트는 재실행해도 안전하며, 이미 설치된 부분은 건너뜁니다.

**나중에 어시스턴트를 바꿀 수 있나요?**
네. 언제든 `/onboard`(Pro) 또는 `souldrop -Reset` / `souldrop --reset`(무료)을 다시 실행하세요. 이전 프로필은 항상 먼저 백업되며 절대 삭제되지 않습니다.

**내 데이터를 수집하나요?**
아니요. 모든 것이 당신 컴퓨터에만 있습니다 — Pro는 `~/.claude/`, 무료는 `~/souldrop-brain/`. 무료 티어에서는 AI조차 컴퓨터 밖으로 나가지 않습니다.

**예전 링크에 `claude-easy-install`이라고 되어 있어요?**
같은 프로젝트입니다 — v0.4.0부터 SoulDrop이 새 이름입니다. 이전 GitHub URL은 자동으로 리디렉션됩니다.

## 📄 라이선스

MIT — [LICENSE](LICENSE) 참조. Claude Code는 Anthropic의, Ollama는 Ollama의 소프트웨어이며 각자의 공식 설치 프로그램으로 설치됩니다. [NOTICE](NOTICE) 참조.

---

<div align="center">

<img src="assets/logo.svg" alt="" width="44">

**SoulDrop** — 하나의 뇌, 어떤 엔진이든.

<sub>MIT © SK Production · <a href="LICENSE">LICENSE</a> · <a href="NOTICE">NOTICE</a></sub>

</div>
