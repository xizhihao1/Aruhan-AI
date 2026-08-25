# Aruhan v1.0.0

**中文** | [English](#english)

Aruhan AI 智能助手首个正式版本，覆盖三端：终端 CLI · 桌面版 · IDE 插件。

## ✨ 核心能力
- 🗣️ 三方辩论引擎 V5：五维评分 + 置信度复核 + 多轮对抗评审
- 💻 Code Agent：代码生成 / 解释 / 审查 / 调试修复 / 重构 / 测试 / Git / 命令执行
- 🤖 Bot 网关：飞书 / 企业微信 / 钉钉 / Telegram / Slack，OAuth 扫码登录
- 📝 CodeMirror 多语言编辑器（桌面版文件预览编辑）
- 📄 文档处理：Office / PDF / Markdown / CSV 读写、总结、翻译、转换
- 🖼️ 图像处理：AI 图像生成与理解、图像分析（已实现，未充分测试）
- 🎬 视频处理：AI 视频生成与理解、视频内容分析（已实现，未充分测试）
- 🧠 上下文智能压缩（auto-compact + Vault 精确恢复）
- 🛡️ 权限模式管控 + 沙箱执行 + 文件访问围栏
- 🖥️ 三端一体：配置与会话互通（终端 / 桌面 / IDE）

## 🧪 测试状态
- **重点测试**：编程功能为主，已使用 **DeepSeek** 完成端到端测试；
- **已实现未充分测试**：图像处理、视频处理功能已实现但尚未充分测试；
- **可自主测试**：其他模型（OpenAI / Claude / 通义 / 智谱 / Ollama 等）及非编程功能，欢迎自主测试反馈。
- 完整能力清单见仓库 README.md「🧩 能力总览（编程 & 非编程）」章节。

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
| Aruhan-Desktop-Setup-1.0.0.exe | PE x86 | FD6AAE8581585A0CA9D2DDBC803052C0FC0B5A015A883FD3921296C8301B8A86 |
| Aruhan-CLI-Setup-1.0.0.exe | PE x86 | E520110523DD64E7ACB9C348747F742E662A95821223778CD67DF38D18A61666 |
| aruhan-tui-installer-windows-amd64.exe | PE x86_64 | 2752808FEF23DCA7C0A8C10CB8CE02DB92DF4A4F238C38767DC5BFC8928EFE3B |
| aruhan-tui-installer-windows-arm64.exe | PE ARM64 | A0DEEAD17D6CEB1F74CBE852915829F1F0E7222BC4F37AF85039B981250935AD |
| aruhan-linux-amd64-1.0.0.tar.gz | tar.gz | 81784BF7E6999AA19A4888283359E203439CA7E6F9C3387A27E0A48F0FA48CC7 |
| aruhan-linux-arm64-1.0.0.tar.gz | tar.gz | B0D3816C2AFCB462AB2153B8FEEC5A646FEA7591BAF5DC20F1A5897091E40194 |
| aruhan-darwin-amd64-1.0.0.tar.gz | tar.gz | DD088C5558D3626AB56740E9F4CCA1A51DA17A23BCB49E5AFBE941EDAF525171 |
| aruhan-darwin-arm64-1.0.0.tar.gz | tar.gz | 7D32C3F90583445AC5C9F8021447A50301B22F16A3D0AD6D0C2CB58767C031DB |
| aruhan-tui-installer-linux-amd64 | ELF x86_64 | E6C896213AB9403664AACF319C31B5F966515FD3581D2BC305DD1D7FAF2B369E |
| aruhan-tui-installer-linux-arm64 | ELF ARM64 | 4BFBF46B50BF2C64BD3067C1EECE71ABCB69CC0C5F7C5F40BF30B57D4E86999B |
| aruhan-tui-installer-darwin-amd64 | Mach-O x86_64 | 5A0FC14FF6BD2DC08FA3D0EF957DF699CD74E4A2F7164C9727308AFE40C4D467 |
| aruhan-tui-installer-darwin-arm64 | Mach-O ARM64 | 6D2B0864CCF281FEFB5082B907D0BAABE0F1F413BF79BA5BD6CCDA0F948ED566 |
| aruhan-vscode.vsix | ZIP (VSIX) | A5D08B6A6EAC65F2B81613AF1348D451DF121119DBD9E424F71447E8DF3CD712 |

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

## 🔐 商业授权
- **个人非商业用途**：免费试用，无需另行授权。
- **企业 / 团队商业使用 / 私有化部署 / 二次定制改造**：须取得商业授权后方可进行。
- **禁止**：任何形式的转售、再分发、商品化销售，以及对编译产物的反编译、反汇编等逆向工程行为；禁止移除或篡改软件内版权与身份标识。
- 商业授权 / 私有化部署 / 定制开发联系：**37735973@qq.com**。
- 完整授权条款见仓库 README.md「🔐 商业授权」章节。

## ⭐ Star 支持
如果本项目对你有帮助，欢迎在 GitHub / Gitee 仓库右上角点一个 Star ⭐ —— 你的支持是项目持续迭代的动力。

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
- 💻 Code Agent: code generation / explanation / review / debug & fix / refactor / tests / Git / command execution
- 🤖 Bot Gateway: Feishu / WeCom / DingTalk / Telegram / Slack with OAuth login
- 📝 CodeMirror multi-language editor
- 📄 Document Processing: Office / PDF / Markdown / CSV read & write, summary, translation, conversion
- 🖼️ Image Processing: AI image generation & understanding, image analysis (implemented, not fully tested)
- 🎬 Video Processing: AI video generation & understanding, video content analysis (implemented, not fully tested)
- 🧠 Context auto-compaction (auto-compact + Vault restore)
- 🛡️ Permission modes + sandbox + file access fence
- 🖥️ One config, three frontends

## 🧪 Testing Status
- **Primary testing**: coding capabilities, end-to-end tested with **DeepSeek**;
- **Implemented, not fully tested**: image and video processing;
- **Self-test welcome**: other models (OpenAI / Claude / Qwen / Zhipu / Ollama, etc.) and non-coding capabilities.
- Full capability list: see "🧩 Capability Overview (Coding & Non-coding)" in README.md.

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

## 🔐 Commercial License
- **Personal non-commercial use**: free trial, no separate authorization required.
- **Enterprise / team commercial use / private deployment / secondary customization**: commercial license required prior to use.
- **Prohibited**: any form of resale, redistribution, or sale as a product; decompilation, disassembly, or other reverse engineering of compiled artifacts; removing or altering any copyright or identity notices in the software.
- For commercial licensing / private deployment / custom development: **37735973@qq.com**.
- Full license terms: see the "🔐 Commercial License" section in README.md.

## ⭐ Star Support
If this project helps you, please tap Star ⭐ at the top right of the GitHub / Gitee repository — your support keeps the project iterating.

Docs: README.md / README.en.md in this repo.
