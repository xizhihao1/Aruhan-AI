# Aruhan v1.0.0

**中文** | [English](#english)

Aruhan AI 智能助手首个正式版本，覆盖三端：终端 CLI · 桌面版 · IDE 插件。

## ✨ 核心能力
- 🗣️ 三方辩论引擎 V5：五维评分 + 置信度复核 + 多轮对抗评审
- 🤖 Bot 网关：飞书 / 企业微信 / 钉钉 / Telegram / Slack，OAuth 扫码登录
- 📝 CodeMirror 多语言编辑器（桌面版文件预览编辑）
- 🧠 上下文智能压缩（auto-compact + Vault 精确恢复）
- 🛡️ 权限模式管控 + 沙箱执行 + 文件访问围栏
- 🖥️ 三端一体：配置与会话互通（终端 / 桌面 / IDE）

## 📦 安装包
- Windows：`Aruhan-Desktop-Setup`（NSIS 图形安装）/ `Aruhan-CLI-Setup` / TUI 安装器
- Linux / macOS：`aruhan-*-*.tar.gz` 通用安装包 / TUI 安装器
- VSCode：`aruhan-vscode.vsix`（内置 CLI 引擎，三平台通用）

## 🖥️ 支持系统
| 平台 | 架构 | 安装包 |
| --- | --- | --- |
| Windows 10/11 | x86_64 | `Aruhan-Desktop-Setup-1.0.0.exe` / `Aruhan-CLI-Setup-1.0.0.exe` / `aruhan-tui-installer-windows-amd64.exe` |
| Windows 10/11 | ARM64 | `aruhan-tui-installer-windows-arm64.exe` |
| Linux | x86_64 | `aruhan-linux-amd64-1.0.0.tar.gz` / `aruhan-tui-installer-linux-amd64` |
| Linux | ARM64 | `aruhan-linux-arm64-1.0.0.tar.gz` / `aruhan-tui-installer-linux-arm64` |
| macOS 11+ | Intel (x86_64) | `aruhan-darwin-amd64-1.0.0.tar.gz` / `aruhan-tui-installer-darwin-amd64` |
| macOS 11+ | Apple Silicon | `aruhan-darwin-arm64-1.0.0.tar.gz` / `aruhan-tui-installer-darwin-arm64` |
| VS Code 1.85+ | Win / macOS / Linux | `aruhan-vscode.vsix` |

## ✅ 安装包校验（v1.0.0 重新编译版）
全部 13 个安装包已通过基础校验：PE / ELF / Mach-O 格式与架构正确、tar.gz 与 VSIX 压缩包完整。SHA256 校验和如下：

| 文件 | 格式/架构 | SHA256 |
| --- | --- | --- |
| Aruhan-Desktop-Setup-1.0.0.exe | PE x86 | 0E2E2CD97A2D96FB180C331D5C83301D1CBA3123E4404154238E2509AEDD0751 |
| Aruhan-CLI-Setup-1.0.0.exe | PE x86 | E70E43BB2A4F87C20689E312396DA9861A2278CC9BC8513C21E2BEA7B5B0D527 |
| aruhan-tui-installer-windows-amd64.exe | PE x86_64 | A2F7F94DA0296ADF0DB7C6AB4F565C88B8BCA365A693BF5FE6FFCA0483462B57 |
| aruhan-tui-installer-windows-arm64.exe | PE ARM64 | 136BEBD87FD310CFE78D052D396C35E3FB22D6F050F9EB64CE35FE66812BA56A |
| aruhan-linux-amd64-1.0.0.tar.gz | tar.gz | C979F65C88CA59D443B758450CF29BAAC5902B78B4E8207737B1518295EA822C |
| aruhan-linux-arm64-1.0.0.tar.gz | tar.gz | 92B7912429C71B8A4341EEADE07ACC148E66372F88B657CD3C1E8C1D658943F6 |
| aruhan-darwin-amd64-1.0.0.tar.gz | tar.gz | D66E5E7F8F20B8ABA7A8CF88BABC6088D3F9B36210F587EF331651839B40D53A |
| aruhan-darwin-arm64-1.0.0.tar.gz | tar.gz | 2A66B06F4E9B66E55B4D756DB7875C8D352FE9E521E2896511BCE16512504938 |
| aruhan-tui-installer-linux-amd64 | ELF x86_64 | 3C2F936C8B93C14A5BC8B9BE2543D701AC94354D83188506B13A48EA0E454627 |
| aruhan-tui-installer-linux-arm64 | ELF ARM64 | E17DCBD1AE1C94E69C051C1C3B1754B0AA04C63751C37EEAC1CF3EEEB0715EFD |
| aruhan-tui-installer-darwin-amd64 | Mach-O x86_64 | AF2E6DEED63DE7CFC3953750B00FD490A11EFE7E65BC6A0A08B632616F2DF17F |
| aruhan-tui-installer-darwin-arm64 | Mach-O ARM64 | 6B2306630CB4CC2840514FF648DA0826542EA229B99C04CCEFA37EC323AB6B5E |
| aruhan-vscode.vsix | ZIP (VSIX) | 350557A2B522B620E3FF79F6B034F3BB17635576FF9E8322DD02A121E8DBBE75 |

校验方法：Windows PowerShell 执行 `Get-FileHash <文件> -Algorithm SHA256`；Linux/macOS 执行 `sha256sum <文件>`。

## 🧪 版本状态（体验 / 测试版）
- 当前 v1.0.0 为公开**体验 / 测试版本**：可能存在尚未发现的缺陷，界面与功能可能随版本迭代调整，不保证与未来正式版完全兼容。
- **Windows 首次运行说明**：本版本安装包暂未进行代码签名（Authenticode）。在全新电脑上首次运行下载的安装包时，Windows SmartScreen 可能提示「Windows 已保护你的电脑」，或要求点击「更多信息 → 仍要运行」。请先确认下载来源为官方 Releases 页并核对上方 SHA256 校验和一致后，再放行运行。
- 若被杀毒软件误报：请先核对 SHA256 校验和；确认一致后可将文件加入信任区，或将样本上报给杀毒厂商（Windows Defender 的「从以下位置下载的文件」提示属正常现象）。

## ⚠️ 风险提示
- 请仅从官方 Releases 页面下载安装包；第三方渠道转发的安装包无法保证完整性，请务必使用上方 SHA256 校验和核对。
- Windows 安装包当前未做代码签名（Authenticode），SmartScreen / 杀毒软件可能出现警告或误报；请先确认 SHA256 一致后再信任放行。
- Aruhan 具备 AI 自主工具执行能力（文件读写 / 命令执行 / 网络访问），请善用权限模式与文件访问围栏（只读 / 工作区 / 全电脑），避免在敏感环境盲目放行高危操作。
- 本软件按「现状」提供，作者不对因使用本软件造成的任何直接或间接损失承担责任；使用 AI 服务前请确认你已获得相应供应商的授权并遵守其服务条款。

## 🚀 终端启动（TUI / 非TUI）
- `aruhan` — 非 TUI（REPL）：轻量 ANSI 界面，支持 `@文件` / `#任务` 补全
- `aruhan -t` 或 `aruhan --tui` — TUI：Bubble Tea 全屏专业界面
- `aruhan --accessible` — 无障碍纯文本模式

完整使用说明见仓库 README.md（中文）/ README.en.md（English）。

---

## 📮 联系方式

如有问题、建议或合作意向，欢迎通过以下方式联系：

- 📧 邮箱：**37735973@qq.com**

---

# English

Aruhan AI Assistant v1.0.0 — first official release (Terminal · Desktop · IDE).

## ✨ Highlights
- 🗣️ Debate Engine V5: 5-dim scoring + confidence check + multi-round review
- 🤖 Bot Gateway: Feishu / WeCom / DingTalk / Telegram / Slack with OAuth login
- 📝 CodeMirror multi-language editor
- 🧠 Context auto-compaction (auto-compact + Vault restore)
- 🛡️ Permission modes + sandbox + file access fence
- 🖥️ One config, three frontends

## 📦 Packages
- Windows: NSIS installers (Desktop / CLI) / TUI installer
- Linux / macOS: tar.gz universal packages / TUI installer
- VSCode: aruhan-vscode.vsix (bundled CLI, cross-platform)

## 🖥️ Supported Systems
| Platform | Arch | Packages |
| --- | --- | --- |
| Windows 10/11 | x86_64 | `Aruhan-Desktop-Setup-1.0.0.exe` / `Aruhan-CLI-Setup-1.0.0.exe` / `aruhan-tui-installer-windows-amd64.exe` |
| Windows 10/11 | ARM64 | `aruhan-tui-installer-windows-arm64.exe` |
| Linux | x86_64 | `aruhan-linux-amd64-1.0.0.tar.gz` / `aruhan-tui-installer-linux-amd64` |
| Linux | ARM64 | `aruhan-linux-arm64-1.0.0.tar.gz` / `aruhan-tui-installer-linux-arm64` |
| macOS 11+ | Intel (x86_64) | `aruhan-darwin-amd64-1.0.0.tar.gz` / `aruhan-tui-installer-darwin-amd64` |
| macOS 11+ | Apple Silicon | `aruhan-darwin-arm64-1.0.0.tar.gz` / `aruhan-tui-installer-darwin-arm64` |
| VS Code 1.85+ | Win / macOS / Linux | `aruhan-vscode.vsix` |

## 🧪 Release Status (Experience / Beta)
- v1.0.0 is a public **experience / beta release**: defects may exist, and UI/features may change between releases without full backward-compatibility guarantees.
- **First run on Windows**: these installers are not code-signed (Authenticode) yet. On a clean machine, Windows SmartScreen may show "Windows protected your PC" or ask you to click "More info → Run anyway". Confirm the download source is the official Releases page and the SHA256 checksum matches, then allow it.
- If flagged by antivirus: verify the SHA256 checksum first; if it matches, allow/trust the file or submit the sample to your AV vendor.

## ⚠️ Risk Notice
- Only download installers from the official Releases page. Third-party copies cannot be trusted — verify integrity with the SHA256 checksums above.
- Windows binaries are not code-signed yet; SmartScreen/antivirus may warn. Cross-check the SHA256 checksum before allowing.
- Aruhan can autonomously execute tools (file I/O, shell, network). Use permission modes and the file-access fence (read-only / workspace / full access) wisely.
- Provided "as is" without warranty. Ensure you are entitled to use the AI services you select and comply with their terms.

## 🚀 Terminal Launch (TUI / Non-TUI)
- `aruhan` — Non-TUI (REPL): lightweight ANSI with `@file` / `#task` completion
- `aruhan -t` or `aruhan --tui` — TUI: Bubble Tea full-screen interface
- `aruhan --accessible` — plain-text accessibility mode

Docs: README.md / README.en.md in this repo.
