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
| Aruhan-Desktop-Setup-1.0.0.exe | PE x86 | 775ACB16D536D588AE37371F6EDE6536E88B696A3D46D6018A16B0153ECA1982 |
| Aruhan-CLI-Setup-1.0.0.exe | PE x86 | B4D8825A601855BF8026E44C88E8ECC28513659E603E53B5DAEC3E015643ABCA |
| aruhan-tui-installer-windows-amd64.exe | PE x86_64 | 891D482B61878EB9000AE7894D11C2881B5302BAE42D3BF871D0426ADC7A7078 |
| aruhan-tui-installer-windows-arm64.exe | PE ARM64 | 4D328EB6AE7CDE2405B3931E1205076F1F4FE688A1D35238AD0DF99C5450AB44 |
| aruhan-linux-amd64-1.0.0.tar.gz | tar.gz | C9F46823CEBFF7A13D0C7D28CF75500377D4018D94ABDBA4FF0941437B66F597 |
| aruhan-linux-arm64-1.0.0.tar.gz | tar.gz | 820E4B8CD6501748BA4B52FA1A44B922E9BA068B3BF4DB63E02C959BEC5922D9 |
| aruhan-darwin-amd64-1.0.0.tar.gz | tar.gz | AE58AA02358CF96298631CF61E94D024D46115739982FFE6280AB8538DAAE288 |
| aruhan-darwin-arm64-1.0.0.tar.gz | tar.gz | 632922D175691EF7EA149253FE45150E81A8CF9AF574E4B24EF4DC0FB281FF85 |
| aruhan-tui-installer-linux-amd64 | ELF x86_64 | 4C14724E713B991BF5188189D5ED4D91262411E3BD798BBE9E678DF327B93E27 |
| aruhan-tui-installer-linux-arm64 | ELF ARM64 | 6EEEB5B63D935B86A5460D542E74F9C49900402AA8DE5A04B311BFA834D1C40F |
| aruhan-tui-installer-darwin-amd64 | Mach-O x86_64 | E6C3D7315EA7EA7303B7A8B79CF053D90D33B77E7BD0C91FC152F005986B79A2 |
| aruhan-tui-installer-darwin-arm64 | Mach-O ARM64 | 03EE47FCB9336C5C13B448797DDEAABE9640A225C3864168A3012A7D53CC7628 |
| aruhan-vscode.vsix | ZIP (VSIX) | 185D618A4D6AA386EA33849EF5B1FCAE7A75E4904EA5218ECFC157ED11D2DFEC |

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
