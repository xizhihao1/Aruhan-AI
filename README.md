# Aruhan AI 智能助手

> Aruhan — 你的全场景 AI 智能助手：**终端 CLI · 桌面版 · IDE 插件** 三端一体。

Aruhan AI 智能助手面向开发与日常办公场景，提供与主流大模型（DeepSeek / Anthropic / OpenAI / 通义 / 智谱 / Ollama 本地等）的无缝接入，内置**三方辩论引擎**、多平台 **Bot 网关**、智能**上下文压缩**与**权限管控**。

本仓库为**安装包发布仓库**（仅含二进制安装包与说明文档，不含源代码）。

---

## ✨ 功能特性

| 能力 | 说明 |
| --- | --- |
| 🗣️ 三方辩论引擎 | 正方 / 反方 / 判官 多轮对抗评审，五维评分 + 置信度复核，自动收敛至 ≥9.8 分后落地 |
| 🤖 Bot 网关 | 飞书 / 企业微信 / 钉钉 / Telegram / Slack，支持 OAuth 扫码登录与 IM 内指令 |
| 📝 CodeMirror 编辑器 | 桌面版内置多语言代码编辑器（Go/JS/Python/Rust/SQL/…） |
| 🧠 上下文智能压缩 | auto-compact + Vault 精确恢复，长会话不超窗 |
| 🛡️ 权限管控 | 权限模式 + 沙箱执行 + 文件访问围栏 + 工具审批 |
| 🌐 多供应商 | DeepSeek / Anthropic / OpenAI / 通义 / 智谱 / Ollama… 缓存与思考档位全适配 |
| 🖥️ 三端一体 | 终端（TUI/REPL）、桌面（Wails）、IDE（VSCode 插件）配置与会话互通 |

---

## 📥 下载

前往 **[Releases 发布页](https://gitee.com/guleng2005/aruhan-releases/releases)** 下载最新安装包：

| 平台 | 安装包 | 说明 |
| --- | --- | --- |
| Windows | `Aruhan-Desktop-Setup-*.exe` | NSIS 图形安装向导（桌面版 + CLI） |
| Windows | `Aruhan-CLI-Setup-*.exe` | NSIS CLI 安装向导（自动配置 PATH） |
| Linux | `aruhan-linux-{amd64,arm64}-*.tar.gz` | 通用安装包（CLI + 桌面 + install.sh） |
| macOS | `aruhan-darwin-{amd64,arm64}-*.tar.gz` | 通用安装包（CLI + 桌面 + install.sh） |
| 全平台 | `aruhan-tui-installer-*` | TUI 交互式安装器 |
| VSCode | `aruhan-vscode.vsix` | IDE 插件（内置 CLI 引擎，三平台通用） |

---

## 🚀 快速开始

### 一、终端 CLI

**Windows NSIS 安装**：双击 `Aruhan-Desktop-Setup-*.exe` 或 `Aruhan-CLI-Setup-*.exe` 按向导完成安装。

**Linux / macOS**：

```bash
tar -xzf aruhan-linux-amd64-1.0.0.tar.gz
cd aruhan-linux-amd64
./install.sh
```

**启动**：终端输入 `aruhan` 直接进入交互式 REPL。

> 首次使用输入 `/provider` 选择供应商并填写 API Key，`/model` 切换模型。

### 二、桌面版

- Windows：从安装包安装后启动，或直接运行便携版。
- 桌面版默认进入**聊天界面**，右侧按钮可切换终端面板、文件预览与设置。
- 在设置页配置供应商 / 模型 / API Key，保存后立即生效（三端同步）。

### 三、VSCode 插件

1. 下载 `aruhan-vscode.vsix`；
2. VSCode 扩展视图 → `...` → **从 VSIX 安装…** 选择该文件；
3. 重启 VSCode，侧边栏出现 Aruhan 图标，打开后即可对话（插件自动内置 CLI 引擎，无需单独安装）。

---

## ⌨️ 使用指令

### CLI / TUI 斜杠指令

| 指令 | 说明 |
| --- | --- |
| `/provider` | 切换 AI 供应商，配置 API Key |
| `/model` | 切换当前模型 |
| `/effort` | 设置推理思考档位（auto/none/low/medium/high） |
| `/debate [on N|off|0]` | 开关三方辩论（N 为轮次，0 表示无限轮） |
| `/compact` | 手动压缩当前会话上下文 |
| `/rewind` | 回退到之前的对话节点 |
| `/task-create <名> [描述]` | 创建任务 |
| `/task-show [id]` | 查看任务 |
| `/task-done <id>` / `/task-cancel <id>` | 完成任务 / 取消任务 |
| `/session` | 会话管理（列表 / 切换 / 恢复） |
| `/workspace` | 工作区管理（创建 / 切换） |
| `/perm` | 权限模式切换（自动/询问/只读/绕过） |
| `/media` | 媒体能力查询（图像/视频生成） |
| `/skill` / `/skills` | 技能管理与使用 |
| `/memories` / `/remember` | 记忆查看 / 写入 |
| `/theme [dark|light|…]` | 切换主题 |
| `/diff` | 查看变更 |
| `/stats` | 会话统计 |
| `/help` | 帮助（TUI 内按 `F1` 或 `?`） |
| `/quit` | 退出 |

### 输入补全

- 输入 `@文件路径` 引用本地文件（自动读入上下文）；
- 输入 `#任务` 引用任务内容；
- 指令输入时自动弹出斜杠命令联想，`Tab` 补全。

### TUI 快捷键

| 按键 | 功能 |
| --- | --- |
| `F1` / `?` | 开关帮助面板 |
| `Ctrl+R` | 历史反向搜索 |
| `Ctrl+G` | 推理过程显示开关 |
| `Ctrl+E` | 多行粘贴模式 |
| `Ctrl+Insert` | 复制选中内容 |
| `Ctrl+C ×2` | 退出 TUI |
| `Ctrl+D` | 强制退出 |

### Bot（IM）指令

在飞书 / 企业微信 / 钉钉 / Telegram / Slack 私聊或群聊中@机器人：

| 指令 | 说明 |
| --- | --- |
| `/projects [关键词]` | 列出已索引工作区 |
| `/use project <id>` | 切换当前会话工作区 |
| `/approve` / `/deny` | 审批工具执行请求 |
| `/answer` | 触发回复 |

---

## ❓ 常见问题

**Q：API Key 存在哪里？安全吗？**
API Key 仅保存在本地配置文件（`aruhan.json` / 各端配置文件），不上传任何服务器。

**Q：如何接入本地模型？**
选择 Ollama 供应商并填写本地地址（如 `http://localhost:11434`），无需联网。

**Q：长对话会报错吗？**
不会。系统内置 auto-compact 上下文压缩 + Vault 恢复，超窗前自动压缩。

**Q：三端配置会同步吗？**
会。终端 / 桌面 / IDE 共用同一套配置与 daemon 会话，一处配置全端生效。

---

## 📄 许可证与声明

- 本仓库仅分发**编译产物**（二进制安装包），不包含源代码。
- 使用即表示同意：本软件按「现状」提供，作者不对因使用本软件造成的任何损失负责。
- 请确保你有权使用所选 AI 供应商的服务，并遵守其服务条款。
