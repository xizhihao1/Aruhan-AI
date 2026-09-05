# 🚀 Aruhan AI Assistant

> **A free all-in-one AI assistant — one-click install.**
> **Terminal (TUI/Non-TUI) · Desktop · VS Code Extension** — one config, every frontend.

- 🗣️ **Three-party Debate Engine**: Pro/Con/Judge adversarial review for complex tasks
- 🤖 **Multi-platform Bot Gateway**: Feishu / WeCom / DingTalk / Telegram / Slack
- 🧠 **Context Auto-Compaction**: long sessions never overflow
- 🛡️ **Permission Sandbox**: read-only / workspace / full-access file fence
- 🌐 **All mainstream models**: DeepSeek / OpenAI / Claude / Qwen / Zhipu / local Ollama

**⬇️ Official download hub → [Releases page](https://gitee.com/guleng2005/Aruhan-AI/releases)**
(compiled installers only, no source code)

---

## ✨ Features

| Capability | Description |
| --- | --- |
| 🗣️ Three-party Debate Engine | Pro / Con / Judge multi-round adversarial review with 5-dimension scoring + confidence check; auto-converges at ≥9.8 before execution |
| 💻 Code Agent | Read / write / search codebase, run commands, debug & fix, multi-file refactoring, Git operations — full coding-assistant workflow |
| 🤖 Bot Gateway | Feishu / WeCom / DingTalk / Telegram / Slack with OAuth QR login and in-IM commands |
| 📝 CodeMirror Editor | Multi-language code editor built into Desktop (Go/JS/Python/Rust/SQL/…) |
| 📄 Document Processing | Office / PDF / Markdown / CSV read & write, summarization, translation, format conversion, spreadsheet formulas & charts |
| 🖼️ Image Processing | AI image generation & understanding, image analysis, format / size conversion (implemented, not fully tested) |
| 🎬 Video Processing | AI video generation & understanding, video content analysis (implemented, not fully tested) |
| 🧠 Context Auto-Compaction | auto-compact + Vault exact restore, long sessions never overflow |
| 🛡️ Permission Controls | permission modes + sandbox execution + file access fence (read-only / workspace / full access) + tool approval |
| 🌐 Multi-provider | DeepSeek / Anthropic / OpenAI / Qwen / Zhipu / Ollama… with cache & effort-level adaptation |
| 🖥️ One codebase, three frontends | Terminal (TUI/REPL), Desktop (Wails), IDE (VSCode) share config & sessions |

---

## 🧩 Capability Overview (Coding & Non-coding)

### 💻 Coding Capabilities (Primary Testing Focus)

| Capability | Description |
| --- | --- |
| Code Generation | Generate functions, modules, or full project scaffolds on demand, multi-language |
| Code Explanation | Explain complex code, algorithms, and dependencies step by step |
| Code Review | Static review, defect detection, security & performance suggestions |
| Debug & Fix | Locate errors, analyze, auto-fix with regression verification |
| Multi-file Refactoring | Cross-file rename, extract, split, and structural adjustments |
| Test Authoring | Generate unit / integration tests and run verification |
| Git Operations | Commit, branching, history analysis, conflict resolution |
| Command Execution | Run builds, compilations, scripts, and automation tasks in sandbox |
| Technical Docs | Generate README, API docs, comments, and changelogs |

### 🎯 Non-coding Capabilities

| Capability | Description |
| --- | --- |
| Document Processing | Office / PDF / Markdown / CSV read & write, summarization, translation, format conversion |
| Spreadsheet Processing | Formula calculation, data cleaning, pivots & chart generation |
| Slides | PPT creation, editing, and polishing |
| Image Processing | AI image generation & understanding, image analysis, format / size conversion (implemented, not fully tested) |
| Video Processing | AI video generation & understanding, video content analysis (implemented, not fully tested) |
| Information Retrieval | Web search, page fetching & content distillation |
| Writing & Polishing | Copywriting, multi-language translation, grammar checking |
| Debate Engine | Multi-round adversarial reasoning for complex decisions / plan review |
| Bot Automation | Send / receive messages and in-chat commands via Feishu / WeCom / DingTalk / Telegram / Slack |
| Task Assistant | Todo management, meeting notes, scheduling |

### 🧪 Testing Status

- **Primary testing**: Coding capabilities are the main validation focus, end-to-end tested with **DeepSeek**;
- **Implemented, not fully tested**: Image and video processing are implemented but not yet fully tested;
- **Self-test welcome**: Other models (OpenAI / Claude / Qwen / Zhipu / Ollama, etc.) and non-coding capabilities — developers and users are welcome to test and report issues.

---

## 📥 Download

Get the latest packages from the **[Releases page](https://gitee.com/guleng2005/Aruhan-AI/releases)**:

| Platform | Package | Description |
| --- | --- | --- |
| Windows | `Aruhan-Desktop-Setup-*.exe` | NSIS graphical installer (Desktop + CLI) |
| Windows | `Aruhan-CLI-Setup-*.exe` | NSIS CLI installer (auto-configures PATH) |
| Linux | `aruhan-linux-{amd64,arm64}-*.tar.gz` | Universal tarball (CLI + Desktop + install.sh) |
| macOS | `aruhan-darwin-{amd64,arm64}-*.tar.gz` | Universal tarball (CLI + Desktop + install.sh) |
| All | `aruhan-tui-installer-*` | Interactive TUI installer |
| VSCode | `aruhan-vscode.vsix` | IDE extension (bundled CLI engine, cross-platform) |

### Supported Systems

| Platform | Arch | Minimum |
| --- | --- | --- |
| Windows | x86_64 / ARM64 | Windows 10 / 11 |
| Linux | x86_64 / ARM64 | Mainstream distros (glibc / musl) |
| macOS | Intel / Apple Silicon | macOS 11+ |
| VS Code | Win / macOS / Linux | 1.85+ |

> ⚠️ **Version & Risk Notice**: v1.0.0 is a public **experience / beta release** — defects may exist and features may change. Only download installers from the official Releases page and verify integrity with the SHA256 checksums published there. Windows binaries are not code-signed yet; on first run SmartScreen may show "Windows protected your PC" or ask you to click "More info → Run anyway" — cross-check the SHA256 checksum before allowing (normal for unsigned software). Aruhan can autonomously execute tools — use permission modes and the file-access fence (read-only / workspace / full access) wisely. Full checksum table: [Releases page](https://gitee.com/guleng2005/Aruhan-AI/releases).

---

## 🚀 Usage Guide

### 1. Terminal CLI (TUI / Non-TUI)

The terminal is Aruhan's full-featured workbench with **two interface modes that share the same config and session** — switch anytime.

#### 1.1 Install

**Windows**: double-click `Aruhan-Desktop-Setup-*.exe` or `Aruhan-CLI-Setup-*.exe` and follow the wizard (PATH is configured automatically).

**Windows portable zip (extract-and-run, required for ARM64)**: download `aruhan-windows-{amd64,arm64}-1.1.0.zip` (CLI) or `aruhan-desktop-windows-{amd64,arm64}-1.1.0.zip` (Desktop), extract and run — no install needed. Windows ARM64 users must use the zip packages (NSIS installers only support x86_64).

**Windows one-line install (PowerShell, recommended)**:

```powershell
irm https://gitee.com/guleng2005/Aruhan-AI/raw/master/install-online.ps1 | iex
```

Auto-detects the architecture (amd64/arm64), downloads the matching zip from Release, installs `aruhan.exe`, and configures user-level PATH and `ARUHAN_BINARY` (no admin rights needed; installs to `%LOCALAPPDATA%\Aruhan\bin` by default). The Gitee direct link works best in mainland China; the GitHub mirror is also available: `irm https://raw.githubusercontent.com/xizhihao1/Aruhan-AI/main/install-online.ps1 | iex`.

**Linux / macOS one-line install (recommended)**:

```bash
curl -fsSL https://gitee.com/guleng2005/Aruhan-AI/raw/master/install-online.sh | bash
```

Auto-detects platform/arch, downloads the binary from Release, and configures PATH and `ARUHAN_BINARY` (no sudo required, installs to `~/.local/bin` by default).

**Linux / macOS manual install**:

```bash
tar -xzf aruhan-linux-amd64-1.1.0.tar.gz
cd aruhan-linux-amd64
./install.sh
```

**Cross-platform TUI installer**: download the `aruhan-tui-installer-*` for your platform, chmod +x, run it, and pick the install directory.

#### 1.2 First-run Configuration

Run `aruhan` in your terminal, then in the REPL:

```
/provider   pick a provider and enter your API key (env vars ARUHAN_API_KEY / <PROVIDER>_API_KEY also work)
/model      switch models
```

Config is stored locally and shared across all three frontends — configure once.

#### 1.3 Launch Modes

| Command | Mode | Description |
| --- | --- | --- |
| `aruhan` | **Non-TUI (REPL)** | Lightweight ANSI interface with `@file` / `#task` completion and slash-command suggestions |
| `aruhan -t` or `aruhan --tui` | **TUI** | Bubble Tea full-screen interface: status bar, tool cards, split layout |
| `aruhan --accessible` | Accessibility mode | Plain-text output (no color/emoji/box-drawing) for screen readers |

- **Non-TUI (REPL)**: classic line-by-line interaction, lightweight and low-overhead — great for SSH and constrained environments. Type `@file/path` to auto-read a file into context, `#task` to reference a task, and slash-command suggestions pop up as you type (`Tab` to complete).
- **TUI**: full-screen professional interface with a top status bar (model / permission / workspace / session state), live tool cards, and a split layout (chat and tool output side by side). Press `F1` or `?` inside TUI for all shortcuts.

TUI and REPL share the same config file and session history — resume the same conversation in either mode at any time.

#### 1.4 Common Operations

- **Tasks**: `/task-create <name> [desc]` to create, `/task-show` to list, `/task-done <id>` to complete, `/task-cancel <id>` to cancel. Tasks are bound to a workspace; tool results are archived per task.
- **Workspaces**: `/workspace` creates / switches the working directory. File reads and writes are confined to the workspace by default.
- **Debate engine**: `/debate on 3` enables N-round adversarial review, `/debate off` disables it, `/debate on 0` runs unlimited rounds.
- **Context management**: `/compact` to compact manually, `/rewind` to roll back to a previous conversation node.
- **Permission modes**: `/perm` cycles auto / ask / read-only / bypass; combined with the file access scope (read-only / workspace / full access) it controls which tools the AI may run.
- **Skills & memory**: `/skill` to use skills, `/remember` to write a memory, `/memories` to view memories.
- **Exit**: `/quit` (non-TUI); press `Ctrl+C` twice or `Ctrl+D` in TUI.

#### 1.5 TUI Shortcuts

| Key | Action |
| --- | --- |
| `F1` / `?` | Toggle help panel |
| `Ctrl+R` | Reverse history search |
| `Ctrl+G` | Toggle reasoning display |
| `Ctrl+E` | Multi-line paste mode |
| `Ctrl+Insert` | Copy selection |
| `Ctrl+C ×2` | Quit TUI |
| `Ctrl+D` | Force quit |

---

### 2. Desktop App

A complete graphical experience that opens on the **chat view** by default.

#### 2.1 Install & Launch

Windows: run `Aruhan-Desktop-Setup-*.exe` and launch after install. Linux / macOS: extract the `tar.gz` and run the desktop binary or `install.sh`.

#### 2.2 Navigation (left sidebar)

| Entry | Description |
| --- | --- |
| Chat | Default home — chat with AI, start tasks, view tool cards and streaming output |
| Tasks | Task list and progress management |
| Skills | Skill marketplace and installed skills |
| Sessions | Browse / resume history sessions |
| Memory | View and edit long-term memory |
| Terminal | Built-in terminal panel (`Ctrl+\``), with split / toggle / fullscreen; the chat window stays resident |
| Settings | Provider / model / API key / effort / generation params / media keys / theme / language |

#### 2.3 Chat & Workflows

- Above the input box are the **permission mode** and **file access scope** selectors (read-only / workspace / full access), saved per task and applied instantly.
- The chat view renders the three-party debate process in real time, tool-call cards, and task-approval dialogs.
- **Sound alerts** fire on task completion, errors, and pending approvals (toggle in Settings).

#### 2.4 Files & Terminal

- Built-in file explorer: browse workspace files, preview and edit with CodeMirror multi-language highlighting, and view change diffs.
- Terminal panel works side by side with chat: conversation on the left, commands on the right. `Ctrl+\`` toggles it, with fullscreen support.

#### 2.5 Keyboard Shortcuts

| Shortcut | Action |
| --- | --- |
| `Ctrl+\`` | Toggle terminal panel |
| `Ctrl+B` | Toggle sidebar |
| `Ctrl+Shift+B` | Toggle browser view |
| `Ctrl+Shift+T` | Cycle theme (light / dark) |
| `Ctrl+Shift+L` | Toggle UI language (CN / EN) |

---

### 3. VSCode Extension

Use Aruhan right inside your editor — no window switching.

#### 3.1 Install

1. Download `aruhan-vscode.vsix`;
2. VSCode Extensions view → `...` → **Install from VSIX…** and select the file;
3. Restart VSCode — the Aruhan icon appears in the sidebar (the CLI engine is bundled; no separate Aruhan install needed).

#### 3.2 Usage

- Click the Aruhan icon in the sidebar to open the chat panel and start chatting or creating tasks.
- **Workspace integration**: the extension workspace is managed by the IDE — open a folder in VSCode and it auto-binds to an Aruhan workspace, letting the AI read and write your project files directly.
- The input box has a **file access scope** selector (read-only / workspace / full access) that fences where AI tools can reach; out-of-scope access is denied.
- All slash commands, `@file` references, code diff viewing, session and skill management are supported, sharing config and sessions with Terminal / Desktop.

#### 3.3 Common Operations

- Select code and reference it in chat, or have the AI answer / modify files directly in the workspace.
- Approval: when the AI requests a write operation or a risky command, confirm or reject it in the panel.
- Scheduled tasks, model switching, media generation, etc. behave the same as Terminal / Desktop.

---

## ⌨️ Command Reference

### CLI / TUI Slash Commands

| Command | Description |
| --- | --- |
| `/provider` | Switch AI provider, configure API key |
| `/model` | Switch model |
| `/effort` | Set reasoning effort (auto/none/low/medium/high) |
| `/debate [on N|off|0]` | Toggle three-party debate (N = rounds, 0 = unlimited) |
| `/compact` | Manually compact session context |
| `/rewind` | Roll back to a previous conversation node |
| `/task-create <name> [desc]` | Create a task |
| `/task-show [id]` | Show tasks |
| `/task-done <id>` / `/task-cancel <id>` | Complete / cancel a task |
| `/session` | Session management (list / switch / resume) |
| `/workspace` | Workspace management (create / switch) |
| `/perm` | Switch permission mode (auto/ask/read-only/bypass) |
| `/media` | Media capabilities (image/video generation) |
| `/skill` / `/skills` | Skill management & usage |
| `/memories` / `/remember` | View / write memory |
| `/theme [dark|light|…]` | Switch theme |
| `/diff` | Show changes |
| `/stats` | Session statistics |
| `/help` | Help (or press `F1` / `?` in TUI) |
| `/quit` | Exit |

### Input Completion

- Type `@file/path` to reference a local file (auto-read into context);
- Type `#task` to reference a task;
- Slash-command suggestions pop up as you type; press `Tab` to complete.

### Bot (IM) Commands

In a DM or group chat (Feishu / WeCom / DingTalk / Telegram / Slack) with the bot mentioned:

| Command | Description |
| --- | --- |
| `/projects [keyword]` | List indexed workspaces |
| `/use project <id>` | Switch the session workspace |
| `/approve` / `/deny` | Approve / reject tool execution requests |
| `/answer` | Trigger a reply |

---

## ❓ FAQ

**Q: Where are API keys stored? Are they safe?**
API keys are stored only in local config files (`aruhan.json` / per-frontend configs). Nothing is uploaded to any server.

**Q: How do I use a local model?**
Pick the Ollama provider and set your local endpoint (e.g. `http://localhost:11434`). No internet needed.

**Q: Will long conversations error out?**
No. Built-in auto-compact + Vault restore compress context automatically before overflow.

**Q: Are the three frontends in sync?**
Yes. Terminal / Desktop / IDE share the same config and daemon session — configure once, use everywhere.

**Q: What's the difference between TUI and REPL?**
The functionality is identical; only the interface differs: REPL is a lightweight line-by-line interaction, TUI is a full-screen interface with status bar, tool cards and split layout. Enter with the other mode anytime — the session continues.

**Q: What is the ARUHAN_BINARY environment variable?**
It stores the full path of the most recently installed Aruhan binary so clients like the VS Code extension and dsh can locate the engine. When multiple versions coexist it points to the last installer run; uninstalling cleans it up only when it still points to the current install directory, never overwriting custom values. The terminal CLI resolves via PATH first and is unaffected.

---

## 📮 Contact

Questions, suggestions, or partnership inquiries are welcome:

- 📧 Email: **37735973@qq.com**

---

## 📄 License & Open Source Notice

- This repo distributes **compiled binaries only** (installer packages); no source code is included.
- By using this software you agree it is provided "as is"; the author is not liable for any loss caused by its use.
- Ensure you are entitled to use the AI provider services you select and comply with their terms.
- This software does not require or enforce any AI provider's terms; users must ensure their own compliance.

---

## 🔐 Commercial License

| Use case | Authorization |
| --- | --- |
| Personal non-commercial use | **Free trial**, no separate authorization required |
| Enterprise / team commercial use | Commercial license required prior to use |
| Private deployment | Commercial license required, deployed within the licensed scope |
| Secondary customization | Commercial license required prior to any customization |
| Resale / redistribution | **Prohibited** — no resale, redistribution, or sale as a product in any form |
| Reverse engineering | **Prohibited** — no decompilation, disassembly, or other reverse engineering of compiled artifacts |
| Removing copyright notices | **Prohibited** — do not remove or alter any copyright, trademark, or identity information in the software |

For commercial licensing, private deployment, or custom development, contact **37735973@qq.com**.

---

## ⚠️ Disclaimer

- This software (including installers, documentation, and all related materials) is provided "as is", **without any express or implied warranties**, including but not limited to warranties of **merchantability, fitness for a particular purpose, or non-infringement**.
- Users bear **all risks** of using this software; the author is not liable for any **direct or indirect damages** (including data loss, business interruption, loss of profit, etc.) arising from using or being unable to use this software.
- **Not for high-risk production environments**: including but not limited to medical, aviation, nuclear facilities, autonomous driving, core financial trading systems, industrial control systems, or any scenario that could materially affect personal safety or major property. Use in such environments requires written authorization and a separate liability agreement.
- AI-generated content may contain errors, biases, or inappropriate information; users must verify and bear the consequences of use. Do not use AI output directly for legal, medical, investment, or other high-risk decisions.
- Users must comply with the laws and regulations of their country / region and must not use this software for any illegal purpose.

---

## ⭐ Star Support

If this project helps you, please tap **Star ⭐** at the top right of the GitHub / Gitee repository — your support is the biggest motivation for continuous iteration, bug fixes, and feature improvements.

- GitHub: [xizhihao1/Aruhan-AI](https://github.com/xizhihao1/Aruhan-AI)
- Issues and suggestions are welcome for feedback or discussion.

---

## 🙏 Acknowledgements

- Thanks to all contributors of open-source dependencies (full list bundled in each installer).
- Thanks to DeepSeek / Anthropic / OpenAI / Qwen / Zhipu / Ollama and other AI providers for their model capabilities.
