# Aruhan v2.1.34

**Release date / 发布日期：2026-11-27** · [CN checksums / 国内版校验和](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/SHA256SUMS)

**⬇ [下载 / Download](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.34)**

<details name="lang">
<summary><strong>中文 / Chinese</strong></summary>

**⬇ [立即下载 Windows 安装包](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Setup-2.1.34-cn.exe)** —
[macOS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-amd64-cn) · [Linux](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-amd64-2.1.34-cn.tar.gz) · 全部平台见下表

## 下载 / Download

| 平台 | 安装包 | 说明 | 下载 |
|---|---|---|---|
| Windows | 合集：CLI + 桌面 + Factory | 一次安装 CLI、桌面端和 Factory。 | [Aruhan 安装包](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Setup-2.1.34-cn.exe) |
| Windows | 单独安装包 | 只安装需要的端。 | [CLI](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-CLI-Setup-2.1.34-cn.exe) · [桌面](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Desktop-Setup-2.1.34-cn.exe) · [Factory](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Factory-Setup-2.1.34-cn.exe) |
| Windows | 便携 ZIP | 免安装，解压即用。 | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-windows-amd64-2.1.34-cn.zip) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-windows-arm64-2.1.34-cn.zip) |
| Windows arm64 | TUI 安装器 | Windows ARM 终端界面安装器。 | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-tui-installer-windows-amd64-cn.exe) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-tui-installer-windows-arm64-cn.exe) |
| macOS | 桌面应用 | 原生应用；headless 构建用浏览器打开界面。 | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-amd64-cn) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-arm64-cn) |
| macOS | CLI/TUI 压缩包 | CLI 与 TUI 的 tar.gz 压缩包。 | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-darwin-amd64-2.1.34-cn.tar.gz) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-darwin-arm64-2.1.34-cn.tar.gz) |
| Linux | 桌面应用 | 原生应用；headless 构建用浏览器打开界面。 | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-linux-amd64-cn) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-linux-arm64-cn) |
| Linux | CLI/TUI/Factory 压缩包 | CLI、TUI 与 Factory 的 tar.gz 压缩包。 | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-amd64-2.1.34-cn.tar.gz) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-arm64-2.1.34-cn.tar.gz) |
| VS Code | 扩展 | 在 VS Code 扩展视图安装。 | [VSIX](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-vscode-cn.vsix) |
| 全部 | 完整性校验 | 所有分发文件的校验和。 | [SHA256SUMS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/SHA256SUMS) |

安装、升级、PATH、Gatekeeper 与 SmartScreen 说明见 [INSTALL.md](https://github.com/xizhihao1/Aruhan-AI/blob/main/INSTALL.md)；
完整资产列表在页面最下方。

## 中文


v2.1.34 修复各端首次运行时的模型选择问题。已经通过环境变量或共享
`aruhan.json` 配置好的供应商和模型，现在会直接显示为当前选择，不再要求
用户重新配置一次。

### 统一的选择解析

`internal/provider.ResolveSelection` 现在是唯一的优先级规则：任务固定 >
环境变量 > 客户端版本文件 > 共享 `aruhan.json` > 推断。候选模型必须属于
解析出的供应商；被当前发行版过滤掉的供应商会明确报告为不可用，不会静默
换成另一个供应商。

- 桌面 `config.load` 与 `/api/models` 使用同一解析器。此前桌面忽略
  `ARUHAN_*` 和共享 `provider.model`，而 `/api/models` 会读取它们，两个接口
  可能给出相反结论。
- 聊天下拉会回退到服务端解析结果，设置尚未加载完成时首屏也能显示已配置
  的模型。
- VS Code 使用同一优先级解析当前模型，并识别
  `DEEPSEEK_API_KEY` 这类供应商专属环境变量。

### Factory 纯环境变量凭据

Factory ACP 工位会同时收到 `ARUHAN_ACTIVE_PROVIDER` 和通用
`ARUHAN_API_KEY`。共享配置加载器此前在空 `Providers` map 中找不到该供应商
时会清空 Key，导致每个工位都报 “Local mode: no API key configured”。现在
会在供应商切换之后重新应用显式的环境变量 Key。

### 验证

- 单元测试：解析优先级矩阵、共享文件与纯环境变量 ConfigLoad、供应商切换
  后的环境变量 Key。
- 真实 Key 端到端：CLI、TUI、桌面、VS Code 均实际发送并收到回复；Linux
  headless UI 验证了国内版与国际版的选择。
- Factory 真实执行器在纯环境变量凭据下已能调用模型并产生 agent 活动；
  随后按工位写审批策略停住，这是设计上的人工门禁。

</details>

<details name="lang" open>
<summary><strong>English</strong></summary>

**⬇ [Download Aruhan for Windows](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Setup-2.1.34-cn.exe)** —
[macOS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-amd64-cn) · [Linux](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-amd64-2.1.34-cn.tar.gz) · all platforms below

## Download / 下载

| Platform | Package | What it is | Download |
|---|---|---|---|
| Windows | Bundle: CLI + desktop + Factory | Single installer for CLI, desktop app and Factory. | [Aruhan bundle installer](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Setup-2.1.34-cn.exe) |
| Windows | Separate installers | Install only the surface you need. | [CLI](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-CLI-Setup-2.1.34-cn.exe) · [Desktop](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Aruhan-Desktop-Setup-2.1.34-cn.exe) · [Factory](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/Factory-Setup-2.1.34-cn.exe) |
| Windows | Portable ZIP | No-install ZIP; unpack and run. | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-windows-amd64-2.1.34-cn.zip) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-windows-arm64-2.1.34-cn.zip) |
| Windows arm64 | TUI installer | Terminal UI installer for Windows on ARM. | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-tui-installer-windows-amd64-cn.exe) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-tui-installer-windows-arm64-cn.exe) |
| macOS | Desktop app | Native app; headless builds serve the UI in a browser. | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-amd64-cn) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-darwin-arm64-cn) |
| macOS | CLI/TUI tarball | CLI and TUI in a .tar.gz archive. | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-darwin-amd64-2.1.34-cn.tar.gz) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-darwin-arm64-2.1.34-cn.tar.gz) |
| Linux | Desktop app | Native app; headless builds serve the UI in a browser. | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-linux-amd64-cn) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-desktop-linux-arm64-cn) |
| Linux | CLI/TUI/Factory tarball | CLI, TUI and Factory in a .tar.gz archive. | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-amd64-2.1.34-cn.tar.gz) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-linux-arm64-2.1.34-cn.tar.gz) |
| VS Code | Extension | Install from the VS Code Extensions view. | [VSIX](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/aruhan-vscode-cn.vsix) |
| All | Integrity | Checksums for every distributed file. | [SHA256SUMS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.34/SHA256SUMS) |

Installation, upgrade, PATH, Gatekeeper and SmartScreen notes are in
[INSTALL.md](https://github.com/xizhihao1/Aruhan-AI/blob/main/INSTALL.md); the full asset list is at the bottom of this page.

## English


v2.1.34 fixes first-run model selection across every client. A provider and
model configured in the environment or in the shared `aruhan.json` now appears
as the active selection immediately, instead of asking the user to configure
it again.

### One provider/model resolver for every client

`internal/provider.ResolveSelection` is now the single precedence rule: task
pin > environment > client version file > shared `aruhan.json` > inference.
Every candidate model must belong to the resolved provider; a provider filtered
out by the current edition is reported as unavailable instead of being silently
replaced by another provider.

- Desktop `config.load` and `/api/models` use the same resolver. The desktop
  previously ignored `ARUHAN_*` and the shared `provider.model`, while
  `/api/models` honored them, so the two endpoints could disagree.
- The chat dropdown falls back to the server-resolved selection, so the first
  paint shows the configured model even before settings finish loading.
- VS Code resolves the active model through the same precedence and recognizes
  provider-specific environment keys such as `DEEPSEEK_API_KEY`.

### Factory env-only credentials

Factory ACP workers receive `ARUHAN_ACTIVE_PROVIDER` together with the generic
`ARUHAN_API_KEY`. The shared config loader used to clear the key when the named
provider was absent from an empty `Providers` map, so every station reported
"Local mode: no API key configured". The loader now re-applies the explicit
environment key after the provider switch.

### Verification

- Unit tests: resolver precedence matrix, shared-file and env-only ConfigLoad,
  env-key ConfigLoad after an active-provider switch.
- Real-key end-to-end: CLI, TUI, desktop and VS Code each sent a prompt and
  received a reply; Linux headless UI verified CN and INTL selection.
- Factory real executor with env-only credentials reached the model and
  produced agent activity; the run then parked on the station's write-approval
  policy, which is the designed gate.

</details>
