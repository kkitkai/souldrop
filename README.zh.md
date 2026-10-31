<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
  <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
  <img src="assets/logo.svg" alt="SoulDrop — 内含火花的水滴" width="110">
</picture>

# SoulDrop

**把一个灵魂放进任何一台机器 — 你的个人 AI 助手，全自动。**
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

[English](README.md) · [Tiếng Việt](README.vi.md) · [ไทย](README.th.md) · [한국어](README.ko.md) · **中文**

<br>

<img src="assets/demo.svg" alt="动画演示 — 一条命令安装 SoulDrop，/onboard 访谈运行，一个拥有 4 个专属技能的个人助手就绪" width="780">

</div>

一条命令。一场友好的访谈(绝无技术问题)。你将得到一个有自己名字、性格、长期记忆和"第二大脑"的助手 — 运行在适合你的引擎上，**付费或 100% 免费**。

> 英语和越南语是主要支持语言。泰语、韩语、中文获完整支持；其他语言可通过"其他"选项使用。

---

## 🚀 安装

安装器会搞定**一切** — 包括它需要的辅助工具(git、Node...)。你不需要提前自己安装任何东西。

### 🖱️ 最简单的方式 (Windows) — 下载 1 个文件，双击

1. **[点这里下载安装文件](https://raw.githubusercontent.com/kkitkai/souldrop/main/SoulDrop-Installer.bat)** — **右键**点击链接 → **"链接另存为..."** → 保存到桌面。
2. **双击**下载好的 `SoulDrop-Installer.bat`。就这样 — 安装器自己运行。
3. 如果 Windows 弹出蓝色 SmartScreen 警告: 点 **"更多信息"** → **"仍要运行"**。坦白说: 这个警告对*任何*从网上下载的未签名文件都会出现 — 这个文件只是调用下面的官方安装脚本，你可以用记事本打开亲自读一读。

*用 Mac? 上面的文件只适用于 Windows — 对你来说最简单的方式是下面的一条命令: 复制，粘贴一次，搞定。*

### ⌨️ 一条命令方式 (熟悉 PowerShell / 终端的人)

**Windows** — 打开 **PowerShell**(不会开? [看下面的图解教程](#-完全新手的分步教程))，粘贴:

```powershell
irm https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.ps1 | iex
```

**macOS / Linux** — 打开**终端**(不会开? [看下面的图解教程](#-完全新手的分步教程))，粘贴:

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

### 然后

**Pro 引擎 (Claude):**
1. 输入 `claude` 回车，浏览器打开后登录(需要付费订阅)。
2. 输入 `/onboard`，选择语言，认识你的新助手 — 它甚至会在打招呼前为你的职业锻造 3–5 个专属技能。
3. 马上试试: **扔给它一个 PDF 或合同 — 它直接就能读**，或者说*"给我做个 Excel 文件"* — 安装器已添加文档包，它能做出真正的 Word/Excel/PowerPoint/PDF 文件(如果你装了 Chrome，它还能陪你上网浏览)。

**免费引擎 (本地):**
1. 双击桌面上的 **SoulDrop**(Windows)，或在新终端输入 `souldrop`。
2. 回答六个友好的问题(你的名字、工作、目标、助手的名字...) — 完成。一切都在你的机器上运行，什么都不会外传。

## ✨ 它能做什么?

日常的事，用平常的聊天说出来就行。下面的卡片是真实对话的简化插画(越南语) — 不是截图:

<table>
<tr>
<td><img src="assets/gallery/read-pdf.svg" alt="扔给它一个 PDF 或合同 — 它直接就能读" width="390"></td>
<td><img src="assets/gallery/make-excel.svg" alt="一句话 — 得到带公式的真 Excel 文件" width="390"></td>
</tr>
<tr>
<td><img src="assets/gallery/remember.svg" alt="说一句'记住' — 它永远记得，一周后还会提起" width="390"></td>
<td><img src="assets/gallery/custom-skill.svg" alt="它为你的职业自造专属技能 — 例如: 摄影师的报价单生成" width="390"></td>
</tr>
<tr>
<td><img src="assets/gallery/daily-note.svg" alt="每天一行，攒成第二大脑里的全年日记" width="390"></td>
<td><img src="assets/gallery/free-local.svg" alt="免费档 100% 在你自己电脑上运行 — 无账号，零费用" width="390"></td>
</tr>
</table>

<!-- Maintainers: replace these illustration cards with real captured session
     screenshots/recordings once the demo sessions are recorded. -->

## 🧭 完全新手的分步教程

> 从没用过"命令行"? 没关系 — 这一节手把手带你走每一步，配图解。慢慢来。选择你的系统: 🪟 Windows · 🍎 macOS · 🐧 Linux。

### 🪟 怎么打开 PowerShell (Windows)

<img src="assets/guide/open-powershell-1.svg" alt="第 1 步 — 按 Windows 键 (键盘左下角，四个方块的那个键)" width="740">
<img src="assets/guide/open-powershell-2.svg" alt="第 2 步 — 输入 PowerShell，搜索框会自动打开" width="740">
<img src="assets/guide/open-powershell-3.svg" alt="第 3 步 — 按回车，深蓝色窗口打开: 那就是 PowerShell" width="740">
<img src="assets/guide/open-powershell-4.svg" alt="第 4 步 — 粘贴安装命令 (右键 = 粘贴) 然后按回车" width="740">

小技巧: 在 PowerShell 里，**右键 = 粘贴**。用 📋 按钮复制上面的安装命令，右键点蓝色窗口，按回车 — 完成。

### 🍎 在 Mac 上打开终端

<img src="assets/guide/open-terminal-mac-1.svg" alt="第 1 步 — 同时按 Cmd ⌘ + Space 打开聚焦搜索 (Spotlight)" width="740">
<img src="assets/guide/open-terminal-mac-2.svg" alt="第 2 步 — 在 Spotlight 搜索框输入 Terminal" width="740">
<img src="assets/guide/open-terminal-mac-3.svg" alt="第 3 步 — 按回车，终端窗口打开" width="740">
<img src="assets/guide/open-terminal-mac-4.svg" alt="第 4 步 — 用 Cmd + V 粘贴安装命令，然后按回车" width="740">

Mac 上要粘贴的命令 (用代码块右上角的 📋 按钮复制):

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

小技巧: 在 Mac 上**粘贴 = Cmd ⌘ + V** (不是 Ctrl+V)。如果 Mac 弹窗询问是否安装 **"command line developer tools"**，直接点 **Install** — 那是安装程序需要的 Apple 官方工具，装好后再运行一次上面的命令即可。

### 🐧 在 Linux 上打开终端

<img src="assets/guide/open-terminal-linux-1.svg" alt="第 1 步 — 按 Ctrl + Alt + T 打开终端" width="740">
<img src="assets/guide/open-terminal-linux-2.svg" alt="第 2 步 — 用 Ctrl + Shift + V 粘贴安装命令，然后按回车" width="740">

按 **Ctrl + Alt + T** (大多数发行版: Ubuntu、Mint...) — 或在应用菜单里找 "Terminal"。粘贴这条命令然后按回车 (**终端里粘贴 = Ctrl + Shift + V**，不是 Ctrl+V):

```bash
curl -fsSL https://raw.githubusercontent.com/kkitkai/souldrop/main/install/go.sh | bash
```

实话实说: 安装程序**绝不会自动运行 sudo**。如果缺少 git，它只会打印出 `sudo apt-get install -y git` 这条命令让**你自己运行**，然后你再重新运行上面的命令 — 透明，绝不擅自动用系统权限。

### 用 Claude 的两种方式 — 选适合你的

已经**在 Claude Desktop 应用里和 Claude 聊天**了? 那你可以**直接在应用里**用 SoulDrop — 完全不碰终端。

| | 🖥️ Claude Desktop — *最简单* | ⚡ Claude CLI — *强力版* |
|---|---|---|
| 适合 | 已经在用 Claude 聊天的新手 | 想要全部威力的人 |
| 需要终端? | **不需要** | 需要 (PowerShell / 终端) |
| 怎么打开 | 打开 Claude 应用 → 点 **Code** 标签页 | 在终端输入 `claude` |
| 能力 | SoulDrop 全部技能 | 全部 + 更深的自动化 |

**方式 A — Claude Desktop (不需要终端):**
1. 在 [claude.com/download](https://claude.com/download) 下载应用并登录 (需要 Pro 或更高 订阅)。
2. 点应用顶栏的 **Code** 标签页，选 **Local**。
3. 在输入框里依次输入这两条命令 (逐行复制、粘贴、回车):
   ```
   /plugin marketplace add kkitkai/souldrop
   /plugin install souldrop@souldrop
   ```
4. 输入 `/onboard` — 选择语言，认识你自己的助手。搞定!

**方式 B — Claude CLI (长任务更强):** 按上面的安装章节操作 → 打开终端 → 输入 `claude` → 输入 `/onboard`。

### 手动安装 Ollama (免费引擎 — 可选)

SoulDrop 安装器**已经自动帮你装好 Ollama** — 这一节只给想自己动手的人:

1. 去 [ollama.com/download](https://ollama.com/download) → 下载 Windows / Mac 版 → 像普通应用一样安装。
2. 打开 PowerShell / 终端，按你的内存拉取合适的模型:

   | 你的内存 | 输入这条命令 | 下载量 |
   |---|---|---|
   | 16 GB 及以上 | `ollama pull llama3.1:8b` | ~4.9 GB |
   | 8–16 GB | `ollama pull llama3.2:3b` | ~2 GB |
   | 8 GB 以下 | `ollama pull llama3.2:1b` | ~1.3 GB |

3. 重新运行上面的 SoulDrop 安装器 — 它会检测到 Ollama 并继续剩下的步骤。

### 🎬 视频教程

<!-- Maintainers: drag the final .mp4 files into the GitHub web editor and paste
     the generated user-attachments URLs below — the only form GitHub renders inline. -->

*视频教程(越南语配音)正在路上 — 会出现在这里。在那之前，上面的图解步骤足够你从头装到尾。*

## 🧠 选择你的引擎

<p align="center">
  <img src="assets/engines.svg" alt="一个大脑连接多个引擎 — Claude Code (Pro)、Ollama (免费、本地)，更多在计划中" width="780">
</p>

SoulDrop 把**大脑**(你的助手是谁 — 属于你的纯 markdown 文件)与**引擎**(运行它的东西)分开。同一个灵魂，任何引擎:

| 引擎 | 费用 | 你得到什么 |
|---|---|---|
| **Pro — [Claude Code](https://code.claude.com)** | 付费 Claude 订阅 (Pro 或更高) | 最聪明的档位: 完整技能、**自动锻造技能**(为你的职业自动生成专属能力)、生成真正的 Word/Excel/PowerPoint/PDF 文件、用你的 Chrome 上网浏览、子代理 |
| **免费 — [Ollama](https://ollama.com) (本地)** | **0 元，无需账号** | 100% 在你自己电脑上运行的真助手: 人设、记忆、"记住..."、第二大脑。默认私密 |
| Codex · Antigravity · OpenClaw | — | 🔜 计划中 |

你不需要做任何技术选择 — 安装程序会**自动检测 Claude Code**，否则只问一个问题: *免费还是 Pro?*

## 📦 要求

- Windows 10 1809+ / macOS 13+ / Ubuntu 20.04+，安装时需联网
- **免费引擎:** 无其他要求。AI 模型约占 2–5 GB 磁盘(自动按内存大小挑选)
- **Pro 引擎:** 付费 Claude 订阅 (Pro 或更高) — [claude.ai](https://claude.ai)
- **还没有 Claude?** 从 7 天免费 Pro 试用开始 → [claude.ai/referral/QbA1I722cA](https://claude.ai/referral/QbA1I722cA) *(推荐链接 — 支持本项目)*

## 🔁 一个大脑，多个引擎

大脑是**纯 markdown — 引擎可互换**: 一个人设文件(助手是谁)、一个记忆库(随时说*"记住..."*即可保存)、以及所有引擎共享的 `~/second-brain` 笔记库。每个文件你都可以自己阅读、编辑、备份或搬到新机器。规范: [`brain/`](brain/README.md) · 新引擎的适配器契约: [`adapters/`](adapters/README.md)。

## 🧩 Pro 插件内含什么

| 技能 | 作用 |
|---|---|
| `/onboard` | 创建个性化助手 + 记忆 + 专属技能 + 第二大脑的访谈 — 支持英语、越南语、泰语、韩语、中文或你自己的语言 |
| `forge-skills` | **为你的职业和目标自动构建 3–5 个专属技能** — 在 `/onboard` 结束时自动运行，可随时重跑。网页/应用设计类工作还会安装开源 [taste-skill](https://github.com/Leonxlnx/taste-skill) 设计插件(MIT) |
| `/health` | **健康检查** — 检查引擎、插件、档案、记忆、第二大脑、安全网和扩展功能，能修的悄悄修好，然后打印一份友好的报告 *(v0.7 之前叫 `/doctor` — 现在 `/doctor` 是 Claude Code 自带的命令，只检查 Claude Code 本身)* |
| `/todo` | **一件都不会漏** — 每个请求都会成为任务清单上的一行(进行中 / 等你 / 已完成)，直到交付结果。随时问 *"还剩什么?"* |
| `check-before-install` | 安装任何应用、扩展或工具之前: 确认是不是正版、谁做的、许可证、最近更新、有没有问题报告 — 用大白话说明，你同意后才安装 |
| `/uninstall` | 干净地卸载 SoulDrop 及其扩展 — 你的档案、记忆和笔记**始终保留** |
| `create-skill` | 描述一个新能力，助手自己编写并安装该技能(与锻造同一质量门槛) |
| `remember` | 把事实/偏好存入助手的长期记忆 |
| `recall` | 找回你以前告诉它的事 |
| `learn-from-mistakes` | 把你的纠正变成永久规则 |
| `daily-note` | 简单的每日日记 |
| `work-smart` | 让助手先规划再行动，避免浪费步骤 |
| `personal` | 个人助理基线: 一致的人设、记忆习惯、诚实、安全边界 |
| `leader` | 面向大任务: 规划、拆解、委派、验证、汇报一个干净的答案 |
| `/setup-vault` | (重新)创建 `~/second-brain` 第二大脑笔记库 — 兼容 Obsidian |
| `obsidian-markdown` · `obsidian-cli` | 正确书写和整理笔记(双链、标签、安全文件操作) |

> **v0.7:** 每个助手都按同样的方式工作 — 先给你看草稿，在你认可的版本上修改而不是重做(保留所有版本)，确认真实结果后才说"完成"，改文件前先备份，删除/发送/付款/安装前先问你。详情: [英文 README](README.md#-how-your-assistant-works-with-you)

安装器还会添加一个**日常工具包** — 全部可选，装不上就静默跳过: Anthropic 官方**文档包**(助手能生成真正的 Word/Excel/PowerPoint/PDF 文件)、通过 [chrome-devtools](https://github.com/ChromeDevTools/chrome-devtools-mcp) 获得的**上网能力**(仅当机器上已装 Chrome — 无需账号、无需密钥)、创意图形技能，以及智能记忆。至于**读** PDF，什么都不用装 — 内置功能: 直接把 PDF 扔给助手就行。

## 🆓 免费引擎给你什么

`souldrop` 聊天启动器(桌面快捷方式 / 终端命令): 加载助手的灵魂，从按你电脑配置挑选的本地模型流式回复(内存 16 GB+ → 8B 模型，8–16 GB → 3B，低于 8 GB → 1B 并诚实注明"较基础")，你说*"记住..."*时保存事实，并写入与 Pro 档相同的第二大脑。此档位没有技能锻造 — 小型本地模型编写技能不够可靠，因此 SoulDrop 核心技能的内容被直接折叠进人设。随时重跑安装程序即可升级到 Pro；你的大脑会跟着走。

## 📔 你的第二大脑

初始化会在 `~/second-brain` 创建笔记库 — 助手读写的纯 markdown 文件(每日笔记、项目、人物、想法)。用免费的 [Obsidian](https://obsidian.md) 应用打开该文件夹("Open folder as vault")即可可视化浏览 — Pro 安装程序甚至会尝试帮你安装 Obsidian，装不上一切也照常以纯文件工作。Pro 安装程序还会尝试可选的"智能记忆"升级(开源 [agentmemory](https://github.com/rohitg00/agentmemory) 插件)；如果不行，助手依然通过文件记住一切。

## 🧹 卸载

最简单的方式: 在助手里输入 **`/uninstall`** — 确认一次后卸载 SoulDrop 和它安装的扩展，绝不动你的大脑文件。手动一行命令(PowerShell 和终端都能用):

```
claude plugin uninstall souldrop ; claude plugin marketplace remove souldrop
```

**特意保留的东西:** 你的大脑。`~/.claude/CLAUDE.md`(档案)、`~/.claude/memory/`(记忆)和 `~/second-brain`(笔记)是属于你的纯文件 — SoulDrop 绝不自动删除它们。想彻底清空就自己删除那几个文件夹。免费档: 删除用户目录里的 `souldrop` 文件夹和桌面快捷方式；不再需要 Ollama 就像普通应用一样卸载。

## ❓ 常见问题

**这是 Anthropic 或 Ollama 的官方软件吗?**
不是。SoulDrop 是独立的入门套件。它只通过 Claude Code 和 Ollama 各自的官方安装程序安装它们，然后在其上添加 SoulDrop 大脑。见 [NOTICE](NOTICE)。

**免费版真的免费吗?**
真的。本地引擎(Ollama)和模型都是开源的，完全在你的电脑上运行。没有账号、没有订阅、没有隐藏费用 — 只占用磁盘空间和你自己的硬件。

**安装脚本安全吗?**
安全 — 而且你不必凭空相信我们: 自己阅读 [`install/go.ps1`](install/go.ps1) 和 [`install/go.sh`](install/go.sh)。它们只调用官方安装程序、把本仓库注册为插件市场、安装启动器。Windows SmartScreen 或杀毒软件可能对任何来自互联网的脚本发出警告 — 对这种安装方式来说很正常。

**不小心运行了两次。**
完全没问题 — 脚本可以安全重跑，已安装的部分会自动跳过。

**以后能更换助手吗?**
能。随时重跑 `/onboard`(Pro)或 `souldrop -Reset` / `souldrop --reset`(免费)。旧档案总是先备份，绝不删除。

**它收集我的数据吗?**
不。一切都留在你自己的机器上 — Pro 在 `~/.claude/`，免费版在 `~/souldrop-brain/`。免费档位连 AI 都不会离开你的电脑。

**旧链接写着 `claude-easy-install`?**
同一个项目 — SoulDrop 是 v0.4.0 起的新名字。旧 GitHub 链接会自动重定向。

## 📄 许可证

MIT — 见 [LICENSE](LICENSE)。Claude Code 属于 Anthropic，Ollama 属于 Ollama，均通过各自官方安装程序安装；见 [NOTICE](NOTICE)。

---

<div align="center">

<img src="assets/logo.svg" alt="" width="44">

**SoulDrop** — 一个大脑，任何引擎。

<sub>MIT © SK Production · <a href="LICENSE">LICENSE</a> · <a href="NOTICE">NOTICE</a></sub>

</div>
