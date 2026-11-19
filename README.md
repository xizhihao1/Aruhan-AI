# Aruhan

> A local-first AI engineering workspace: terminal assistant, desktop client, IDE extension, and an AI software factory.

**Version:** 2.1.24 · **Platforms:** Windows, Linux, macOS (amd64 / arm64) · **VS Code:** 1.85+

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

### What's new in 2.1.24

- **Turn result:** every work turn now ends with a model-written conclusion. A new WrapUp tool records the summary, changes, verification, remaining work and next actions; Desktop, VS Code, CLI and TUI render it as one result block. Machine-checked status and remaining items are the fallback.
- **Stop/timeout:** cancelled or timed-out turns also carry a result, so the UI tells you where it stopped and what remains instead of only saying “cancelled”.
- **Desktop:** the result card is compact (details fold away), and tool-result diffs are read-only — per-hunk Accept/Reject was a second partial write, not an approval. Use checkpoint/undo to revert.
- **IDE:** the extension host now forwards the result to the webview, so the same result block appears. The transcript is flat and compact, completed tools collapse into one process row, and the composer no longer shrinks Chinese input to one character per line.
- No configuration or data migration is required.

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

## 中文

> 本地优先的 AI 工程工作台：终端助手、桌面端、IDE 插件与 AI 软件工厂。

**版本：** 2.1.24 · **平台：** Windows、Linux、macOS（amd64 / arm64） · **VS Code：** 1.85+

[English](#english) · [中文](#中文) · [下载](#下载) · [发布页](https://gitee.com/guleng2005/Aruhan-AI/releases)

### Aruhan 是什么

Aruhan 是一套共享同一套本地运行时的多端产品：

| 客户端 | 用途 | 入口 |
|---|---|---|
| **CLI / REPL** | 面向 Shell、CI、远程机器的行式助手，可脚本化 | `aruhan`、`aruhan --plain` |
| **TUI** | 全屏终端工作台，带面板、模式与快捷键 | `aruhan chat` |
| **桌面端** | 原生窗口，集成聊天、终端、文件、Git、会话、记忆、技能、MCP、机器人与设置 | `aruhan-desktop` / 开始菜单 |
| **VS Code 插件** | 编辑器内聊天、选区操作、代码审查、会话、记忆与 Git/Worktree 命令 | VSIX |
| **Factory（软件工厂）** | 流水线化软件生产：本机 Web 控制台、运行、卡点、工件、备份与多租户能力 | `factory` / `factory serve` |

所有客户端共用同一个配置目录。配置一次供应商，各端都能使用。

> **你的 `models.json` 和 `aruhan.json` 才是运行时权威。**
> 内置供应商和模型只在文件缺失或损坏时作为种子生成。
> 在任意一端新增、修改或删除，都会改变其他端看到的内容。

### 下载

请从官方发布页下载最新安装包：

- **GitHub：** <https://github.com/xizhihao1/Aruhan-AI/releases>
- **Gitee：** <https://gitee.com/guleng2005/Aruhan-AI/releases>

| 平台 | 安装包 | 说明 |
|---|---|---|
| Windows | `Aruhan-Setup-<版本>.exe` | CLI + TUI + 桌面端（NSIS 安装向导） |
| Windows | `Aruhan-CLI-Setup-<版本>.exe` | 仅 CLI/TUI |
| Windows | `Aruhan-Desktop-Setup-<版本>.exe` | 仅桌面端 |
| Windows | `Factory-Setup-<版本>.exe` | 软件工厂 |
| Windows | `aruhan-windows-{amd64,arm64}-<版本>.zip` | 便携版 CLI/TUI |
| Windows | `aruhan-desktop-windows-{amd64,arm64}-<版本>.zip` | 便携版桌面端 |
| Linux | `aruhan-linux-{amd64,arm64}-<版本>.tar.gz` | CLI + 桌面端 + `install.sh` |
| Linux | `factory-linux-{amd64,arm64}-<版本>.tar.gz` | 软件工厂 + `install.sh` |
| macOS | `aruhan-darwin-{amd64,arm64}-<版本>.tar.gz` | CLI + 桌面端 + `install.sh` |
| macOS | `factory-darwin-{amd64,arm64}-<版本>.tar.gz` | 软件工厂 + `install.sh` |
| 全平台 | `aruhan-tui-installer-*` | TUI 交互式安装器 |
| VS Code | `aruhan-vscode.vsix` | 内置 CLI 引擎的 IDE 插件 |

| 平台 | 架构 | 最低要求 |
|---|---|---|
| Windows | x86_64 / ARM64 | Windows 10 / 11 |
| Linux | x86_64 / ARM64 | 主流 glibc/musl 发行版 |
| macOS | Intel / Apple Silicon | macOS 11+ |
| VS Code | 三平台 | 1.85+ |

> 本仓库仅分发**编译产物**，不含源代码。
> 请只从官方 Releases 页下载，并在运行前核对 `SHA256SUMS`。
> Windows 二进制目前**未代码签名**，首次运行可能出现 SmartScreen 提示。

### 2.1.24 更新内容

- **辩论开关**：关闭后不再“卡在开启”。发送时记录的显示快照会让任务继续按辩论结构渲染，失效的活跃任务 id 又会让任务级更新变成空操作；现在切换会同步更新两者，无有效任务时写全局默认并持久化。
- **已删任务不再复活**：3.4MB 的本地 WAL 占满 5MB localStorage，任务列表、回收站快照和删除标记都写不进去，归档于是在每次启动时重建已删任务。现在超限本地 WAL 会被丢弃（Go journal 仍是权威恢复源），软删除同时持久化删除 id 与归档空墓碑，恢复逻辑跳过它们。
- 任务行按钮文案由“删除工作”改为“删除任务”。
- 无需迁移配置或数据。

### 快速开始

#### Windows

1. 从发布页下载安装包。
2. 运行安装包。默认安装目录：`%LOCALAPPDATA%\Aruhan`。
3. 打开 **Aruhan Desktop**，或在新终端运行 `aruhan setup`。
4. 添加供应商和 API Key，选择默认模型。
5. 打开一个文件夹/工作区，开始对话。

ZIP 便携版不安装服务、不修改 `PATH`，解压后直接运行可执行文件。Windows ARM64 用户
建议使用 ZIP 包。

#### Linux / macOS

```bash
# CLI + 桌面端
tar -xzf aruhan-linux-amd64-<版本>.tar.gz
cd aruhan-linux-amd64
./install.sh --user          # 安装到 ~/.local/share/aruhan
# 或：sudo ./install.sh      # 安装到 /usr/local/aruhan

# Factory
tar -xzf factory-linux-amd64-<版本>.tar.gz
cd factory-linux-amd64
./install.sh --autostart     # 可选：注册用户登录自启
```

验证安装：

```bash
aruhan --version
aruhan doctor
```

#### VS Code

通过 **扩展 → … → 从 VSIX 安装…** 安装 `aruhan-vscode.vsix`，然后打开 Aruhan 面板。
插件内置 CLI 引擎，并使用同一套共享配置。

### 首次配置

交互式：

```bash
aruhan setup
```

非交互式（明文密钥来自供应商控制台，Aruhan 无法找回）：

```bash
export MY_API_KEY="..."
aruhan setup --provider <目录中的供应商 key> --model <模型 ID> --api-key-env MY_API_KEY --yes
```

也可以在桌面端 **设置 / 模型**、VS Code 聊天设置面板，或 Factory 控制台的
**系统设置 → 执行模型** 中完成同样的配置。

媒体模型（图片/视频）单独保存在 `media.json`，支持默认项、启停、合并与恢复。

### 共享文件

| 文件 | 用途 |
|---|---|
| `models.json` | 文本模型目录：供应商、Base URL、协议、模型、上下文上限 |
| `media.json` | 媒体目录：图片/视频模型、默认项、启停状态 |
| `aruhan.json` | 共享密钥与当前选择；密钥加密保存 |
| `terminal.json`、`desktop.json`、`vscode.json` | 各端偏好（主题、权限模式、工作模式、沙箱） |
| `sessions/`、`memory/`、`logs/`、`history.json` | 本地运行数据 |

默认位置：

- Windows：`%APPDATA%\Aruhan`
- Linux：`${XDG_CONFIG_HOME:-~/.config}/Aruhan`
- macOS：`~/Library/Application Support/Aruhan`

可用 `ARUHAN_HOME`（最高优先级）或 `ARUHAN_DATA_DIR` 覆盖。

### 主要能力

- **一套共享模型目录**：CLI、TUI、桌面端、VS Code、Factory 完全共用。
- **供应商/模型完整增删改查**：内置条目也可删除；删除会写入墓碑，升级不会静默复活。
- **独立媒体模型目录**（`media.json`）：文生图/文生视频的默认、启停、合并、恢复。
- **加密凭据**：密钥保存在 `aruhan.json`，不保存明文供应商 Key。
- **本地优先**：文件、会话、记忆和凭据留在本机；模型请求只发往你配置的供应商。
- **权限与沙箱分层**：权限模式、工作模式、文件访问范围是三个独立控制项。
- **Code Agent**：读写/搜索工作区、执行命令、调试修复、多文件重构、Git 操作。
- **长任务能力**：自治目标（`aruhan goal`）与 Factory 流水线，支持暂停、恢复、回滚。
- **运维工具**：诊断（`aruhan doctor`）、审计哈希链、SBOM、许可证清单、备份与校验和。
- **Bot 与集成**：飞书、企业微信、钉钉、Telegram、Slack 网关。
- **内容处理**：Office/PDF/Markdown/CSV，以及图片/视频分析与生成（已实现；图片/视频
  功能尚未充分测试）。

### 文档

每个版本都会随 Release 提供双语文档 `Aruhan-Manuals-<版本>.zip`，按客户端组织，
英文在上、中文在下：

- 安装与安装包选择
- CLI / REPL
- TUI
- 桌面端
- VS Code 插件
- Factory
- 模型与凭据
- 故障排查
- 安全与法律

### 校验与安全

- 下载后请用发布页的 `SHA256SUMS` 核对完整性。
- Windows 构建目前未签名，未签名程序出现 SmartScreen 提示属正常现象。
- Aruhan 会执行模型请求的工具。开启 `auto` 或 `yolo` 前请确认权限模式与沙箱范围。
- 不要提交 `aruhan.json`、含密钥的 `models.json`、会话数据库或日志。
- 禁止逆向工程、反编译、反汇编，禁止绕过授权、租户隔离或凭据保护；这可能违反法律
  或第三方条款。

### 联系方式

如有问题、建议、缺陷反馈或合作意向，欢迎联系：

- **邮箱：** <37735973@qq.com>

### 许可证与商业授权

本仓库仅分发编译产物。使用本软件即表示同意以下条款：

| 使用场景 | 授权 |
|---|---|
| 个人非商业用途 | 免费试用，无需另行授权 |
| 企业 / 团队商业使用 | 须取得商业授权 |
| 私有化部署 | 须取得商业授权 |
| 二次定制改造 | 须取得商业授权 |
| 转售 / 再分发 | **禁止** |
| 逆向工程 | **禁止**（不得反编译、反汇编或以其他方式逆向） |
| 移除版权信息 | **禁止** |

如需商业授权、私有化部署或定制开发，请联系 <37735973@qq.com>。

### 免责声明

- 本软件（含安装包、文档及一切相关材料）按**“现状”**提供，不提供任何明示或暗示的
  担保，包括但不限于对适销性、特定用途适用性、不侵权的担保。
- 使用者**自行承担**使用本软件的全部风险；作者不对因使用或无法使用本软件造成的
  **任何直接或间接损失**（含数据丢失、业务中断、利润损失等）负责。
- **不得用于高危生产环境**：包括但不限于医疗、航空、核设施、自动驾驶、金融交易
  核心系统、工业控制系统等；如需在此类环境使用，须取得书面授权并另行签订责任
  界定协议。
- AI 生成内容可能存在错误、偏见或不当信息，使用者应自行核实；不得将 AI 输出直接
  用于法律、医疗、投资等高风险决策。
- 使用者须遵守所在国家/地区法律法规，不得将本软件用于任何违法用途。
- 使用者须自行确保所选模型服务的服务条款得到遵守。
