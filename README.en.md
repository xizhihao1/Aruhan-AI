# 🚀 Aruhan AI Assistant

> **A free all-in-one AI assistant — one-click install.**
> **Terminal (TUI/Non-TUI) · Desktop · VS Code Extension** — one config, every frontend.

- 🗣️ **Three-party Debate Engine**: Pro/Con/Judge adversarial review for complex tasks
- 🤖 **Multi-platform Bot Gateway**: Feishu / WeCom / DingTalk / Telegram / Slack
- 🧠 **Context Auto-Compaction**: long sessions never overflow
- 🛡️ **Permission Sandbox**: read-only / workspace / full-access file fence
- 🌐 **All mainstream models**: DeepSeek / OpenAI / Claude / Qwen / Zhipu / local Ollama

**⬇️ Official download hub → [Releases page](https://github.com/xizhihao1/Aruhan-AI/releases)**
(compiled installers only, no source code)

---

## ✨ Features

| Capability | Description |
| --- | --- |
| 🗣️ Three-party Debate Engine | Pro / Con / Judge multi-round adversarial review with 5-dimension scoring + confidence check; auto-converges at ≥9.8 before execution |
| 🤖 Bot Gateway | Feishu / WeCom / DingTalk / Telegram / Slack with OAuth QR login and in-IM commands |
| 📝 CodeMirror Editor | Multi-language code editor built into Desktop (Go/JS/Python/Rust/SQL/…) |
| 🧠 Context Auto-Compaction | auto-compact + Vault exact restore, long sessions never overflow |
| 🛡️ Permission Controls | permission modes + sandbox execution + file access fence (read-only / workspace / full access) + tool approval |
| 🌐 Multi-provider | DeepSeek / Anthropic / OpenAI / Qwen / Zhipu / Ollama… with cache & effort-level adaptation |
| 🖥️ One codebase, three frontends | Terminal (TUI/REPL), Desktop (Wails), IDE (VSCode) share config & sessions |

---

## 📥 Download

Get the latest packages from the **[Releases page](https://github.com/xizhihao1/Aruhan-AI/releases)**:

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

> ⚠️ **Version & Risk Notice**: v1.0.0 is a public **experience / beta release** — defects may exist and features may change. Only download installers from the official Releases page and verify integrity with the SHA256 checksums published there. Windows binaries are not code-signed yet; on first run SmartScreen may show "Windows protected your PC" or ask you to click "More info → Run anyway" — cross-check the SHA256 checksum before allowing (normal for unsigned software). Aruhan can autonomously execute tools — use permission modes and the file-access fence (read-only / workspace / full access) wisely. Full checksum table: [Releases page](https://github.com/xizhihao1/Aruhan-AI/releases).

---

## 🚀 Usage Guide

### 1. Terminal CLI (TUI / Non-TUI)

The terminal is Aruhan's full-featured workbench with **two interface modes that share the same config and session** — switch anytime.

#### 1.1 Install

**Windows**: double-click `Aruhan-Desktop-Setup-*.exe` or `Aruhan-CLI-Setup-*.exe` and follow the wizard (PATH is configured automatically).

**Linux / macOS**:

```bash
tar -xzf aruhan-linux-amd64-1.0.0.tar.gz
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

## 📄 License & Disclaimer

- This repo distributes **compiled binaries only** (installer packages); no source code is included.
- By using this software you agree it is provided "as is"; the author is not liable for any loss caused by its use.
- Ensure you are entitled to use the AI provider services you select and comply with their terms.
