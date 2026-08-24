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
| Aruhan-Desktop-Setup-1.0.0.exe | PE x86 | 770426CAB5356786F3AF7BB13B35080B1DEB4717C0BA6A9DA70C74614DE9BA66 |
| Aruhan-CLI-Setup-1.0.0.exe | PE x86 | 257EDBC559962F7023188BEBF3DC29F8CBC51C5A15573440ECBD856A31C0BDD9 |
| aruhan-tui-installer-windows-amd64.exe | PE x86_64 | 28166AF9310376F5D4D4A825014C421186041EA7353520C3C6B1A4B9C88B65A2 |
| aruhan-tui-installer-windows-arm64.exe | PE ARM64 | B1A5685520C706816EEBE64D4DD1CF9526302B749A71329CA8502F6AC8D186DA |
| aruhan-linux-amd64-1.0.0.tar.gz | tar.gz | 92BB72499D253BCF25C80833066A6E703881E114614CB320428976E7FD236A5A |
| aruhan-linux-arm64-1.0.0.tar.gz | tar.gz | B0CCF0FE7B62974F7645797C1725952D0AE077ABA22DB60F13263FDC1452B5A5 |
| aruhan-darwin-amd64-1.0.0.tar.gz | tar.gz | 86418CC2E7436890DAEEC0A8AB8BEC41643FA26D9B541BAEA666E89C6A1E6DA0 |
| aruhan-darwin-arm64-1.0.0.tar.gz | tar.gz | B5B8CBE29547998B2E030BCDAC7BF78B04FD2F5058282BAE779367AFD2090A41 |
| aruhan-tui-installer-linux-amd64 | ELF x86_64 | F4AB79EE9C4AF66D7C2BA95C9EC6EF175F1B1C08B04FB31A5D7764CC293BB299 |
| aruhan-tui-installer-linux-arm64 | ELF ARM64 | 6E2D6FB2C7173B1148B9DACEFF95C3986C56E81D85B55F2CBFF31B00910E68DC |
| aruhan-tui-installer-darwin-amd64 | Mach-O x86_64 | 08AD0043C2F97EC861AA3F581A21002CC909903492F524A61DFCEE6A9E2CD171 |
| aruhan-tui-installer-darwin-arm64 | Mach-O ARM64 | 4CC87EFDD0DC7E428008F86BEEFD806A9524B09CBF0ADF31DFEC1D9C60BC3ED8 |
| aruhan-vscode.vsix | ZIP (VSIX) | 9E12D558BF039767F22258FB6887FE941AC64D2DA3E59686084251915288B719 |

校验方法：Windows PowerShell 执行 `Get-FileHash <文件> -Algorithm SHA256`；Linux/macOS 执行 `sha256sum <文件>`。

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
