# Aruhan

> A local-first AI engineering workspace: terminal assistant, desktop client, IDE extension, and an AI software factory.

**Version:** 2.1.22 · **Platforms:** Windows, Linux, macOS (amd64 / arm64) · **VS Code:** 1.85+

[English](#english) · [中文](#中文) · [Download](#download) · [Releases](https://github.com/xizhihao1/Aruhan-AI/releases)

---

## English

### What Aruhan is

Aruhan is a family of clients built on one shared local runtime:

| Client | What it is for | Entry point |
|---|---|---|
| **CLI / REPL** | Scriptable, line-oriented assistant for shells, CI, and remote machines | `aruhan`, `aruhan --plain` |
| **TUI** | Full-screen terminal workspace with panels, modes, and key bindings | `aruhan chat` |
| **Desktop** | Native window with chat, terminal, files, Git, sessions, memory, skills, MCP, bots, and settings | `aruhan-desktop` / Start Menu |
| **VS Code extension** | In-editor chat, selection actions, review, sessions, memory, and Git/worktree commands | VSIX |
| **Factory** | Pipeline-driven software production with a local web console, runs, gates, artifacts, backups, and multi-tenant controls | `factory` / `factory serve` |

All clients share the same configuration directory. Configure a provider once and every client sees it.

> **Your `models.json` and `aruhan.json` are the runtime authority.**
> Built-in providers and models are only a seed used when those files are missing or corrupt.
> Adding, editing, or deleting entries in any client changes what every client sees.

### Download

Download the latest packages from the official Releases pages:

- **GitHub:** <https://github.com/xizhihao1/Aruhan-AI/releases>
- **Gitee:** <https://gitee.com/guleng2005/Aruhan-AI/releases>

| Platform | Package | Notes |
|---|---|---|
| Windows | `Aruhan-Setup-<version>.exe` | CLI + TUI + Desktop (NSIS installer) |
| Windows | `Aruhan-CLI-Setup-<version>.exe` | CLI/TUI only |
| Windows | `Aruhan-Desktop-Setup-<version>.exe` | Desktop only |
| Windows | `Factory-Setup-<version>.exe` | Factory |
| Windows | `aruhan-windows-{amd64,arm64}-<version>.zip` | Portable CLI/TUI |
| Windows | `aruhan-desktop-windows-{amd64,arm64}-<version>.zip` | Portable Desktop |
| Linux | `aruhan-linux-{amd64,arm64}-<version>.tar.gz` | CLI + Desktop + `install.sh` |
| Linux | `factory-linux-{amd64,arm64}-<version>.tar.gz` | Factory + `install.sh` |
| macOS | `aruhan-darwin-{amd64,arm64}-<version>.tar.gz` | CLI + Desktop + `install.sh` |
| macOS | `factory-darwin-{amd64,arm64}-<version>.tar.gz` | Factory + `install.sh` |
| Cross-platform | `aruhan-tui-installer-*` | Interactive TUI installer |
| VS Code | `aruhan-vscode.vsix` | Extension with a bundled CLI engine |

| Platform | Architectures | Minimum |
|---|---|---|
| Windows | x86_64 / ARM64 | Windows 10 / 11 |
| Linux | x86_64 / ARM64 | Common glibc/musl distributions |
| macOS | Intel / Apple Silicon | macOS 11+ |
| VS Code | All three platforms | 1.85+ |

> This repository distributes **compiled artifacts only**. It does not contain source code.
> Always download from the official Releases pages and verify `SHA256SUMS` before running.
> Windows binaries are currently **not code-signed**; SmartScreen may warn on first launch.

### What's new in 2.1.22

- **Turn result:** every work turn ends with a model-written conclusion. A new WrapUp tool records the summary, changes, verification, remaining work and next actions; Desktop, VS Code, CLI and TUI render it as one result block. Machine-checked status and remaining items are the fallback.
- **Stop/timeout:** cancelled or timed-out turns also carry a result, so the UI explains where it stopped and what remains.
- **Desktop:** compact result card with folded details; tool-result diffs are read-only (use checkpoint/undo to revert).
- **IDE:** the result now reaches the webview, the transcript is flat and compact, and the composer no longer renders Chinese input vertically.
- No configuration or data migration is required.

See the [release notes](https://github.com/xizhihao1/Aruhan-AI/releases) for the complete list.

### Quick start

#### Windows

1. Download an installer from the Releases page.
2. Run it. The default install root is `%LOCALAPPDATA%\Aruhan`.
3. Open **Aruhan Desktop**, or run `aruhan setup` in a new terminal.
4. Add a provider and API key, then choose a default model.
5. Open a folder/workspace and start chatting.

Portable ZIP builds do not install services or modify `PATH`; run the executable directly.
Windows ARM64 users should prefer the ZIP packages.

#### Linux / macOS

```bash
# CLI + Desktop
tar -xzf aruhan-linux-amd64-<version>.tar.gz
cd aruhan-linux-amd64
./install.sh --user          # installs under ~/.local/share/aruhan
# or: sudo ./install.sh      # installs under /usr/local/aruhan

# Factory
tar -xzf factory-linux-amd64-<version>.tar.gz
cd factory-linux-amd64
./install.sh --autostart     # optional user-level login autostart
```

Verify the installation:

```bash
aruhan --version
aruhan doctor
```

#### VS Code

Install `aruhan-vscode.vsix` from **Extensions → … → Install from VSIX…**, then open the
Aruhan panel. The extension bundles its own CLI engine and uses the same shared configuration.

### First configuration

Interactive:

```bash
aruhan setup
```

Non-interactive (the plaintext key comes from the provider's console; Aruhan cannot recover it):

```bash
export MY_API_KEY="..."
aruhan setup --provider <catalog-key> --model <model-id> --api-key-env MY_API_KEY --yes
```

The same settings can be managed in Desktop → **Settings / Models**, in the VS Code chat
settings panel, or in the Factory console under **Settings → Execution models**.

Media models (image/video) are managed separately in `media.json`, with their own defaults,
enable/disable state, sync, and reset actions.

### Shared files

| File | Purpose |
|---|---|
| `models.json` | Text model catalog: providers, base URLs, protocols, models, context limits |
| `media.json` | Media catalog: image/video models, defaults, enabled/disabled state |
| `aruhan.json` | Shared secrets and active selections; keys are encrypted at rest |
| `terminal.json`, `desktop.json`, `vscode.json` | Per-client preferences (theme, permission mode, work mode, sandbox) |
| `sessions/`, `memory/`, `logs/`, `history.json` | Local runtime data |

Default locations:

- Windows: `%APPDATA%\Aruhan`
- Linux: `${XDG_CONFIG_HOME:-~/.config}/Aruhan`
- macOS: `~/Library/Application Support/Aruhan`

Override with `ARUHAN_HOME` (highest priority) or `ARUHAN_DATA_DIR`.

### Capabilities

- **One shared model catalog** for CLI, TUI, Desktop, VS Code, and Factory.
- **Full provider/model CRUD**, including built-in entries; deletions are protected by
  tombstones so upgrades do not silently resurrect them.
- **Separate media catalog** (`media.json`) for text-to-image and text-to-video.
- **Encrypted credentials** in `aruhan.json`; plaintext provider keys are never stored.
- **Local-first:** files, sessions, memory, and credentials stay on your machine; model
  requests go only to the provider you configure.
- **Permission and sandbox layers:** permission mode, work mode, and file-access scope are
  independent controls.
- **Code agent:** read/write/search the workspace, run commands, debug, refactor, and use Git.
- **Long-running work:** autonomous goals (`aruhan goal`) and Factory pipelines with
  pause/resume/rollback.
- **Operations:** diagnostics (`aruhan doctor`), audit hash chain, SBOM, license inventory,
  backups, and checksums.
- **Bots and integrations:** Feishu, WeCom, DingTalk, Telegram, and Slack gateways.
- **Content tools:** Office/PDF/Markdown/CSV processing, image and video analysis/generation
  (implemented; image/video features are not yet fully tested).

### Documentation

The bilingual manuals are published with every release as `Aruhan-Manuals-<version>.zip`.
They are organized by client, with English first and Chinese below:

- Installation and package selection
- CLI / REPL
- TUI
- Desktop
- VS Code extension
- Factory
- Models and credentials
- Troubleshooting
- Security and legal

### Verification and security

- Verify every download against `SHA256SUMS` published on the Releases page.
- Windows builds are currently unsigned; SmartScreen warnings are expected for unsigned binaries.
- Aruhan executes model-requested tools. Review permission mode and sandbox scope before
  enabling `auto` or `yolo`.
- Do not commit `aruhan.json`, `models.json` with embedded secrets, session databases, or logs.
- Reverse engineering, decompilation, disassembly, or attempts to bypass licensing, tenant
  isolation, or credential protection are prohibited by project policy and may violate law
  or third-party terms.

### Contact

For questions, suggestions, bug reports, or partnership inquiries:

- **Email:** <37735973@qq.com>

### License and commercial use

This repository distributes compiled binaries only. Use of the software is subject to the
following terms:

| Scenario | Authorization |
|---|---|
| Personal, non-commercial use | Free to try; no separate authorization required |
| Enterprise / team commercial use | Commercial authorization required |
| Private deployment | Commercial authorization required |
| Custom modification | Commercial authorization required |
| Resale / redistribution | **Prohibited** |
| Reverse engineering | **Prohibited** (no decompilation, disassembly, or other reverse engineering) |
| Removing copyright notices | **Prohibited** |

For commercial licensing, private deployment, or custom development, contact
<37735973@qq.com>.

### Disclaimer

- The software, installers, documentation, and all related materials are provided **“as is”**,
  without any express or implied warranty, including merchantability, fitness for a
  particular purpose, and non-infringement.
- You use the software **at your own risk**. The author is not liable for any direct or
  indirect loss, including data loss, business interruption, or lost profits.
- **Do not use in high-risk production environments**, including medical, aviation, nuclear,
  autonomous driving, core financial trading, or industrial control systems, without written
  authorization and a separate liability agreement.
- AI-generated content may be incorrect, biased, or inappropriate. Verify it independently;
  do not use it as the sole basis for legal, medical, or investment decisions.
- You must comply with the laws and regulations of your jurisdiction and may not use the
  software for unlawful purposes.
- You are responsible for complying with the terms of any model service you configure.

---

