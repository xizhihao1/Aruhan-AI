# Aruhan AI Assistant

> Aruhan — your all-in-one AI assistant across **Terminal CLI · Desktop App · IDE Extension**.

Aruhan connects to mainstream LLM providers (DeepSeek / Anthropic / OpenAI / Qwen / Zhipu / local Ollama, etc.) and ships with a **three-party debate engine**, multi-platform **Bot Gateway**, intelligent **context compaction**, and **permission controls**.

This repository is the **release distribution repo** (binaries & docs only, no source code).

---

## ✨ Features

| Capability | Description |
| --- | --- |
| 🗣️ Three-party Debate Engine | Pro / Con / Judge multi-round adversarial review with 5-dimension scoring + confidence check; auto-converges at ≥9.8 before execution |
| 🤖 Bot Gateway | Feishu / WeCom / DingTalk / Telegram / Slack with OAuth QR login and in-IM commands |
| 📝 CodeMirror Editor | Multi-language code editor built into Desktop (Go/JS/Python/Rust/SQL/…) |
| 🧠 Context Auto-Compaction | auto-compact + Vault exact restore, long sessions never overflow |
| 🛡️ Permission Controls | permission modes + sandbox execution + file access fence + tool approval |
| 🌐 Multi-provider | DeepSeek / Anthropic / OpenAI / Qwen / Zhipu / Ollama… with cache & effort-level adaptation |
| 🖥️ One codebase, three frontends | Terminal (TUI/REPL), Desktop (Wails), IDE (VSCode) share config & sessions |

---

## 📥 Download

Get the latest packages from the **[Releases page](https://gitee.com/guleng2005/aruhan-releases/releases)**:

| Platform | Package | Description |
| --- | --- | --- |
| Windows | `Aruhan-Desktop-Setup-*.exe` | NSIS graphical installer (Desktop + CLI) |
| Windows | `Aruhan-CLI-Setup-*.exe` | NSIS CLI installer (auto-configures PATH) |
| Linux | `aruhan-linux-{amd64,arm64}-*.tar.gz` | Universal tarball (CLI + Desktop + install.sh) |
| macOS | `aruhan-darwin-{amd64,arm64}-*.tar.gz` | Universal tarball (CLI + Desktop + install.sh) |
| All | `aruhan-tui-installer-*` | Interactive TUI installer |
| VSCode | `aruhan-vscode.vsix` | IDE extension (bundled CLI engine, cross-platform) |

---

## 🚀 Quick Start

### 1. Terminal CLI

**Windows NSIS**: double-click `Aruhan-Desktop-Setup-*.exe` or `Aruhan-CLI-Setup-*.exe` and follow the wizard.

**Linux / macOS**:

```bash
tar -xzf aruhan-linux-amd64-1.0.0.tar.gz
cd aruhan-linux-amd64
./install.sh
```

**Launch**: type `aruhan` in your terminal to enter the interactive REPL.

> On first use, run `/provider` to pick a provider and set your API key, then `/model` to switch models.

### 2. Desktop App

- Windows: install from the NSIS package, or run the portable binary.
- The Desktop opens on the **chat view**; the side buttons toggle the terminal panel, file preview, and settings.
- Configure provider / model / API key in Settings — changes apply immediately across all three frontends.

### 3. VSCode Extension

1. Download `aruhan-vscode.vsix`;
2. VSCode Extensions view → `...` → **Install from VSIX…** and select the file;
3. Restart VSCode — the Aruhan icon appears in the sidebar. Chat right away (the CLI engine is bundled, no separate install needed).

---

## ⌨️ Commands

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

### TUI Shortcuts

| Key | Action |
| --- | --- |
| `F1` / `?` | Toggle help panel |
| `Ctrl+R` | Reverse history search |
| `Ctrl+G` | Toggle reasoning display |
| `Ctrl+E` | Multi-line paste mode |
| `Ctrl+Insert` | Copy selection |
| `Ctrl+C ×2` | Quit TUI |
| `Ctrl+D` | Force quit |

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

---

## 📄 License & Disclaimer

- This repo distributes **compiled binaries only** (installer packages); no source code is included.
- By using this software you agree it is provided "as is"; the author is not liable for any loss caused by its use.
- Ensure you are entitled to use the AI provider services you select and comply with their terms.
