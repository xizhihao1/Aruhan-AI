# Aruhan China mainland edition / 国内版

Version: **v2.1.29**

Aruhan is a local-first AI engineering workspace: CLI, terminal UI, desktop
app, VS Code extension, and the Factory control plane share one runtime and
one configuration directory.

This repository is a **release-only channel** for the China mainland edition.
It contains compiled artifacts, install scripts, licenses, checksums, and
release notes — not source code.

## Core features

- **No server.** There is no Aruhan-hosted backend: configuration, API keys,
  sessions, memory, and artifacts stay on the user's machine, and code is never
  uploaded to the publisher.
- **Bring your own API key.** Model requests go only to the provider endpoint
  the user configures.
- **Free in the current version.** No license purchase or activation is
  required.

## Run

- CLI / REPL: `aruhan --plain`
- One-shot: `aruhan query "..."`
- TUI: `aruhan chat` (or just `aruhan` on an interactive terminal)
- Desktop: `aruhan-desktop` (on Linux/macOS this is headless and opens the
  browser UI)
- Factory: `factory serve`, then open `http://127.0.0.1:8787/console/`

`aruhan-tui-installer-*` is an installer for the CLI/TUI, not a separate
runtime. After it finishes, start Aruhan with the commands above.

## Platform and testing status

- Windows packages have been tested.
- Linux CLI/Factory binaries have been smoke-tested under WSL; macOS packages
  are published but have not been exercised on real hardware. Please report
  issues.
- Desktop is a native window on Windows. On Linux and macOS it is headless:
  `aruhan-desktop` serves the same UI at `http://127.0.0.1:9091/` (loopback
  only) and opens the default browser. Set `ARUHAN_WAILS_PORT` before launch to
  use another port; visit the URL manually if the browser does not open.
- Windows installers are not code-signed. If Windows Security / SmartScreen
  warns, choose **More info → Run anyway**. The warning reflects the missing
  signature, not malware; verify `SHA256SUMS` if in doubt.

## Edition

| Item | Value |
|---|---|
| Edition | `cn` (China mainland edition) |
| Release channel | https://gitee.com/guleng2005/Aruhan-AI/releases |
| Update checks | Gitee Releases only |
| Language / text models | DeepSeek, Doubao (Volcengine Ark), Qwen / Tongyi, Zhipu GLM, Moonshot Kimi, SenseTime, MiniMax, StepFun |
| Image / video | Doubao Seedream/Seedance, Kling, Tongyi Wanxiang, Zhipu CogView |
| Speech | FishSpeech TTS; whisper.cpp local STT |

This build only allows models and media providers operated in mainland China.
Foreign model providers are filtered from the catalog, settings, and every
outbound request; there is no cross-edition fallback.
Updates are checked against Gitee Releases only.

## Assets in this release

- `darwin/aruhan-darwin-amd64-2.1.29-cn.tar.gz`
- `darwin/aruhan-darwin-arm64-2.1.29-cn.tar.gz`
- `darwin/factory-darwin-amd64-2.1.29-cn.tar.gz`
- `darwin/factory-darwin-arm64-2.1.29-cn.tar.gz`
- `linux/aruhan-linux-amd64-2.1.29-cn.tar.gz`
- `linux/aruhan-linux-arm64-2.1.29-cn.tar.gz`
- `linux/factory-linux-amd64-2.1.29-cn.tar.gz`
- `linux/factory-linux-arm64-2.1.29-cn.tar.gz`
- `vscode/aruhan-vscode-cn.vsix`
- `windows/Aruhan-CLI-Setup-2.1.29-cn.exe`
- `windows/aruhan-cn.exe`
- `windows/aruhan-desktop-arm64-cn.exe`
- `windows/aruhan-desktop-cn.exe`
- `windows/Aruhan-Desktop-Setup-2.1.29-cn.exe`
- `windows/aruhan-desktop-windows-amd64-2.1.29-cn.zip`
- `windows/aruhan-desktop-windows-arm64-2.1.29-cn.zip`
- `windows/Aruhan-Setup-2.1.29-cn.exe`
- `windows/aruhan-tui-installer-windows-amd64-cn.exe`
- `windows/aruhan-tui-installer-windows-arm64-cn.exe`
- `windows/aruhan-windows-amd64-2.1.29-cn.zip`
- `windows/aruhan-windows-amd64-cn.exe`
- `windows/aruhan-windows-arm64-2.1.29-cn.zip`
- `windows/aruhan-windows-arm64-cn.exe`
- `windows/factory-cn.exe`
- `windows/Factory-Setup-2.1.29-cn.exe`
- `windows/factory-windows-amd64-cn.exe`
- `windows/factory-windows-arm64-cn.exe`

Verify downloads:

```bash
sha256sum -c SHA256SUMS
```

```powershell
Get-FileHash -Algorithm SHA256 <file>
# compare with the matching line in SHA256SUMS
```

## Install

See [INSTALL.md](INSTALL.md). License terms are in [LICENSE](LICENSE) and
[LICENSE.zh-CN.md](LICENSE.zh-CN.md).

## 中文

# Aruhan 国内版

版本：**v2.1.29**

Aruhan 是本地优先的 AI 工程工作台：CLI、终端 TUI、桌面端、VS Code 插件与
Factory 控制面共享同一套运行时和同一个配置目录。

本仓库是**国内版的发布专用仓库**，只存放编译产物、安装脚本、许可证、
校验和与发布说明，不存放源码。

## 核心特点

- **无服务端**：没有 Aruhan 托管的后端，配置、API Key、会话、记忆和产物都保存在
  用户本机，代码不会上传给发布者。
- **自备 API Key**：模型请求只发往用户配置的供应商端点。
- **当前版本免费开放**：无需购买授权或激活。

## 运行

- CLI / REPL：`aruhan --plain`
- 一次性查询：`aruhan query "..."`
- TUI：`aruhan chat`（交互终端也可直接运行 `aruhan`）
- 桌面端：`aruhan-desktop`（Linux/macOS 为 headless，会打开浏览器 UI）
- Factory：`factory serve` 后打开 `http://127.0.0.1:8787/console/`

`aruhan-tui-installer-*` 是 CLI/TUI 的安装器，不是独立运行程序；安装完成后
用上面的命令启动。

## 平台与测试状态

- Windows 安装包已测试。
- Linux 的 CLI/Factory 二进制已在 WSL 冒烟通过；macOS 安装包已发布但尚未在
  真机验证，试用后欢迎反馈问题。
- Windows 上是原生窗口；Linux 与 macOS 为 headless：启动 `aruhan-desktop` 后在
  `http://127.0.0.1:9091/` 提供同一套 UI（只监听本机回环），并用默认浏览器打开。
  启动前设置 `ARUHAN_WAILS_PORT` 可换端口；浏览器未弹出时手动访问该地址。
- Windows 安装包未做代码签名。Windows 安全中心 / SmartScreen 拦截时选择
  **【更多信息】→【仍要运行】**；该提示仅因缺少签名，并非病毒；如有疑虑请核对
  `SHA256SUMS`。

## 发行版信息

| 项目 | 内容 |
|---|---|
| 发行版 | `cn`（国内版） |
| 发布通道 | https://gitee.com/guleng2005/Aruhan-AI/releases |
| 更新检查 | Gitee Releases only |
| 语言/文本模型 | DeepSeek、Doubao (Volcengine Ark)、Qwen / Tongyi、Zhipu GLM、Moonshot Kimi、SenseTime、MiniMax、StepFun |
| 图片/视频 | Doubao Seedream/Seedance, Kling, Tongyi Wanxiang, Zhipu CogView |
| 语音 | FishSpeech TTS; whisper.cpp local STT |

本构建仅允许中国境内运营的模型与媒体供应商。
国外模型供应商会从目录、设置和所有对外请求中过滤，不存在跨发行版回退。
更新仅检查 Gitee Releases。

## 安装

见 [INSTALL.md](INSTALL.md)。许可证见 [LICENSE](LICENSE) 与
[LICENSE.zh-CN.md](LICENSE.zh-CN.md)。
