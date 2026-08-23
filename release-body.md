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

## 🚀 终端启动（TUI / 非TUI）
- `aruhan` — 非 TUI（REPL）：轻量 ANSI 界面，支持 `@文件` / `#任务` 补全
- `aruhan -t` 或 `aruhan --tui` — TUI：Bubble Tea 全屏专业界面
- `aruhan --accessible` — 无障碍纯文本模式

完整使用说明见仓库 README.md（中文）/ README.en.md（English）。

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

## 🚀 Terminal Launch (TUI / Non-TUI)
- `aruhan` — Non-TUI (REPL): lightweight ANSI with `@file` / `#task` completion
- `aruhan -t` or `aruhan --tui` — TUI: Bubble Tea full-screen interface
- `aruhan --accessible` — plain-text accessibility mode

Docs: README.md / README.en.md in this repo.
