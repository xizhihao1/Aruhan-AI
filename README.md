# Aruhan — China mainland edition / 国内版

**Version v2.1.30** · **China mainland edition** · [Download](https://gitee.com/guleng2005/Aruhan-AI/releases) · [Install](INSTALL.md) · [License](LICENSE) · [Disclaimer](DISCLAIMER.md)


**Your codebase. Your machine. Your models. An AI engineer that actually runs
the loop.**

Aruhan is a local-first AI engineering workspace. It reads your repository,
plans the change, edits files, runs commands and tests, reviews the diff, and
carries the work through a gated delivery pipeline. The same engine powers a
CLI, a terminal UI, a desktop app, a VS Code extension, and the Factory control
plane — so you can start in one surface and continue in another without losing
context.

There is no Aruhan-hosted backend, no mandatory account, and no telemetry by
default. Bring your own API key, point Aruhan at the provider you already
trust, and keep prompts, keys, sessions, memory, and artifacts on your machine.

## Why Aruhan

Most AI coding tools stop at a suggestion. Aruhan closes the engineering loop:

1. **Understand.** Explore the repository, read the relevant files, and inspect
   tests, history, and project rules.
2. **Plan.** Break the task into steps and choose the tools and files involved.
3. **Execute.** Edit code, run commands, apply patches, and work in isolated git
   worktrees when a task should not touch your main checkout.
4. **Verify.** Run tests, linters, and builds; inspect the diff; react to
   failures instead of declaring success.
5. **Deliver.** Record artifacts and evidence, pass quality gates, and hand off
   a result that a teammate or customer can audit.

You stay in control at every step: permission modes decide what may run, and
approval prompts show the exact command or file change before it happens.

## What you can do with it

- **Fix a failing test without babysitting it.** Point Aruhan at the failure,
  let it read the trace, patch the code, run the suite, and show you the diff.
- **Ship a feature across a real repository.** The agent follows project rules,
  reuses existing patterns, updates tests and docs, and keeps changes reviewable.
- **Standardize delivery with Factory.** Turn a repeatable process into a YAML
  pipeline of stations with prompts, inputs, outputs, models, timeouts, and
  quality gates. Every run leaves artifacts, evidence, and a retrospective.
- **Keep sensitive work local.** Use a provider endpoint inside your own network, including a local or private deployment. Nothing is sent to the publisher.
- **Use the model you already pay for.** Switch providers and models without
  changing your workflow; the catalog stays current with official provider
  lists, and credentials are encrypted at rest.
- **Work from the surface you prefer.** Start in the terminal, open the desktop
  app for long sessions, or stay inside VS Code — it is one runtime and one
  configuration directory.

## One engine, five surfaces

| Surface | Best for | Entry point |
|---|---|---|
| **CLI / REPL** | Scripts, automation, quick one-shot tasks | `aruhan`, `aruhan query "..."` |
| **Terminal UI** | Long interactive sessions without leaving the shell | `aruhan chat` |
| **Desktop** | Visual review, settings, sessions, and Factory console | `aruhan-desktop` |
| **VS Code extension** | Keeping the agent beside the code you are editing | the `.vsix` in this release |
| **Factory** | Repeatable, auditable delivery pipelines | `factory serve` |

On Windows the desktop is a native window. On Linux and macOS it is headless:
it serves the same UI on loopback and opens your default browser.

## Factory: from one-off chats to repeatable delivery

Factory is the control plane for work that must be repeatable. A pack defines
the delivery process; a pipeline is a sequence of stations. Each station
declares its prompt, inputs, outputs, timeout, model, and gates, so the same
process can run again next week with a different repository and the same
quality bar.

- **Machine checks block; advisory checks warn; human gates park the run** until
  someone with authority approves it.
- **Evidence is recorded per run** — artifacts, ledger entries, retrospectives,
  and worktree isolation — instead of being scattered across chat logs.
- **The control plane stays separate from execution.** `factory serve` accepts
  and tracks runs; a detached worker executes the stations, so an HTTP request
  never becomes the runtime.
- **The console is local** at `http://127.0.0.1:8787/console/`, with SQLite by
  default and PostgreSQL for larger deployments.

## Built for real engineering

- **Permissioned tools.** Read and write files, run shell commands, use git and
  worktrees, run tests, call MCP servers, automate browsers, and — where enabled
  — control the desktop. Every capability is subject to permission rules.
- **Sessions, memory, and skills.** Resume work later, keep durable project
  memory, and package repeatable know-how as skills.
- **Subagents and peer collaboration.** Split work across focused agents, or let
  two local Aruhan processes collaborate over the local peer mesh.
- **Model and media coverage.** Text models plus image, video, and speech
  generation, filtered to the providers allowed in this edition.
- **Extensible by configuration.** MCP servers, skills, packs, pipelines, and
  model catalogs are configuration, not forks of the engine.
- **Cross-platform.** Windows, Linux, and macOS on amd64 and arm64.

## Editions and models

This download is the **China mainland edition** (`cn`).

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

## Quick start

### 1. Install

| You want | Download |
|---|---|
| Windows, everything (recommended) | **Aruhan-Setup-2.1.30-cn.exe** |
| Windows CLI only | **Aruhan-CLI-Setup-2.1.30-cn.exe** |
| Windows desktop only | **Aruhan-Desktop-Setup-2.1.30-cn.exe** |
| Windows Factory | **Factory-Setup-2.1.30-cn.exe** |
| Windows portable | the matching **aruhan-windows-*-2.1.30-cn.zip** |
| Linux CLI / Factory | **aruhan-linux-*.tar.gz**, **factory-linux-*.tar.gz** |
| macOS CLI / Factory | **aruhan-darwin-*.tar.gz**, **factory-darwin-*.tar.gz** |
| Linux / macOS desktop | the matching **aruhan-desktop-*--cn** binary |
| VS Code | **aruhan-vscode-cn.vsix** |

See [INSTALL.md](INSTALL.md) for step-by-step instructions, including PATH,
Gatekeeper, and SmartScreen notes.

### 2. Configure a model

The simplest path is an environment variable:

~~~bash
export ARUHAN_PROVIDER="your-provider"
export ARUHAN_MODEL="your-model"
export ARUHAN_API_KEY="your-key"
~~~

Provider-specific variables such as `DEEPSEEK_API_KEY` also
work. The desktop app, VS Code extension, CLI, and TUI all show the environment
configuration as active, and you can save the same settings in the app.

### 3. Run

~~~bash
aruhan --plain                 # CLI / REPL
aruhan query "fix the failing test in ./internal/foo"
aruhan chat                    # full-screen TUI
aruhan-desktop                 # desktop (headless on Linux/macOS)
factory serve                  # Factory console at 127.0.0.1:8787/console/
~~~

### 4. Verify the download

~~~bash
sha256sum -c SHA256SUMS
~~~

~~~powershell
Get-FileHash -Algorithm SHA256 <file>
# compare with the matching line in SHA256SUMS
~~~

Every China mainland edition build reports its edition:

~~~bash
aruhan --version
~~~

## Platform status

| Platform | Status |
|---|---|
| Windows | Tested, including the native desktop and installers. |
| Linux | CLI and Factory smoke-tested under WSL; desktop is headless and uses the browser UI. |
| macOS | Published for Intel and Apple Silicon; not yet exercised on every macOS version. Please report issues. |

Windows installers are **not code-signed**. If SmartScreen warns, choose
**More info → Run anyway** after verifying `SHA256SUMS`. The warning reflects
the missing signature, not malware.

## Licensing and commercial use

Aruhan is **free for personal, non-commercial use**. Commercial use — including
use by a company or team, production deployment, private or on-premises
deployment, embedding Aruhan in a product or service, custom development, or a
source-code / perpetual buyout — requires a separate written commercial license.

We keep those terms practical:

- **Team and commercial licenses** sized to the number of users and deployments.
- **Private / on-premises deployment**, including offline and internal-network
  installation, with a written scope and support terms.
- **Custom development and integration** for your delivery process, providers,
  or internal systems.
- **Source-code or perpetual buyout** under a signed agreement. Ownership
  transfer is effective only when the agreement says so explicitly.

Contact **37735973@qq.com** with your organization, deployment scale, and
intended use. For a faster reply, use the subject
`Aruhan commercial license` or `Aruhan private deployment`.

The release repository contains compiled artifacts only; source code is not
published here. See [LICENSE](LICENSE) and [LICENSE.zh-CN.md](LICENSE.zh-CN.md)
for the binding terms.

## Security, acceptable use, and disclaimer

Aruhan executes model-requested tools and can change files, run commands, and
call external services. Read this before enabling unattended modes.

- **No warranty.** The software is provided **AS IS**, without express or
  implied warranties, including merchantability, fitness for a particular
  purpose, and non-infringement.
- **No liability for outcomes.** To the maximum extent permitted by law, the
  authors and copyright holders are not liable for any direct, indirect,
  incidental, special, consequential, or punitive damages, including lost
  profits, data, or business, arising from the software, AI output, tool
  execution, provider behavior, configuration, or data loss.
- **You are responsible for review and compliance.** Review every diff and
  command, keep backups, use least-privilege permissions, test outside
  production, and comply with the law and every model provider's terms. AI
  output is not legal, medical, financial, or other professional advice.
- **High-risk use is prohibited** without independent validation and all
  required approvals: life support, medical diagnosis, aviation, rail,
  automotive safety, industrial control, nuclear, chemical, biological,
  weapons, emergency response, law enforcement, judicial decisions, and
  critical infrastructure.
- **Prohibited conduct** includes unlawful use, malware, unauthorized access,
  evading security or licensing controls, and the restrictions below.

**Reverse engineering and resale.** Except where applicable law expressly
permits, you may not decompile, disassemble, or reverse engineer the official
binaries; bypass licensing, authentication, tenant isolation, or credential
protection; remove proprietary or attribution notices; or resell, rent, lease,
sublicense, distribute, or redistribute the software or modified binaries
without written permission. Modified binaries must never be presented as
official builds.

The full notice is in [DISCLAIMER.md](DISCLAIMER.md). It is a project notice,
not legal advice; obtain local counsel for your jurisdiction.

## Support and contact

- **Installation and usage:** see [INSTALL.md](INSTALL.md) and the issue tracker
  at https://gitee.com/guleng2005/Aruhan-AI/issues.
- **Security reports:** email **37735973@qq.com** privately. Do not open a public
  issue containing credentials, customer data, or exploit details.
- **Commercial, private deployment, and buyout:** **37735973@qq.com**.

## Assets in this release

<details>
<summary><strong>Show all 27 assets</strong></summary>

- **darwin/aruhan-darwin-amd64-2.1.30-cn.tar.gz** — 43,021,479 bytes
- **darwin/aruhan-darwin-arm64-2.1.30-cn.tar.gz** — 40,717,329 bytes
- **darwin/factory-darwin-amd64-2.1.30-cn.tar.gz** — 44,846,172 bytes
- **darwin/factory-darwin-arm64-2.1.30-cn.tar.gz** — 42,274,216 bytes
- **linux/aruhan-linux-amd64-2.1.30-cn.tar.gz** — 42,354,791 bytes
- **linux/aruhan-linux-arm64-2.1.30-cn.tar.gz** — 39,242,551 bytes
- **linux/factory-linux-amd64-2.1.30-cn.tar.gz** — 44,156,480 bytes
- **linux/factory-linux-arm64-2.1.30-cn.tar.gz** — 40,790,134 bytes
- **vscode/aruhan-vscode-cn.vsix** — 87,785,977 bytes
- **windows/Aruhan-CLI-Setup-2.1.30-cn.exe** — 21,786,757 bytes
- **windows/aruhan-cn.exe** — 72,486,400 bytes
- **windows/aruhan-desktop-arm64-cn.exe** — 38,200,832 bytes
- **windows/aruhan-desktop-cn.exe** — 43,929,088 bytes
- **windows/Aruhan-Desktop-Setup-2.1.30-cn.exe** — 33,371,707 bytes
- **windows/aruhan-desktop-windows-amd64-2.1.30-cn.zip** — 15,500,355 bytes
- **windows/aruhan-desktop-windows-arm64-2.1.30-cn.zip** — 13,026,635 bytes
- **windows/Aruhan-Setup-2.1.30-cn.exe** — 33,377,724 bytes
- **windows/aruhan-tui-installer-windows-amd64-cn.exe** — 76,065,792 bytes
- **windows/aruhan-tui-installer-windows-arm64-cn.exe** — 71,153,664 bytes
- **windows/aruhan-windows-amd64-2.1.30-cn.zip** — 28,893,170 bytes
- **windows/aruhan-windows-amd64-cn.exe** — 72,486,400 bytes
- **windows/aruhan-windows-arm64-2.1.30-cn.zip** — 26,637,415 bytes
- **windows/aruhan-windows-arm64-cn.exe** — 67,772,416 bytes
- **windows/factory-cn.exe** — 40,718,336 bytes
- **windows/Factory-Setup-2.1.30-cn.exe** — 33,903,279 bytes
- **windows/factory-windows-amd64-cn.exe** — 40,718,336 bytes
- **windows/factory-windows-arm64-cn.exe** — 37,515,264 bytes

</details>

## Documentation

| Document | Purpose |
|---|---|
| [INSTALL.md](INSTALL.md) | Install, upgrade, PATH, Gatekeeper, and SmartScreen |
| [LICENSE](LICENSE) / [LICENSE.zh-CN.md](LICENSE.zh-CN.md) | Binding license terms |
| [DISCLAIMER.md](DISCLAIMER.md) | Warranty, liability, acceptable use, and high-risk limits |
| [RELEASE_NOTES.md](RELEASE_NOTES.md) | What changed in this version |
| **SHA256SUMS** | Checksums for every distributed file |

---

## 中文

# Aruhan — 国内版

**版本 v2.1.30** · **国内版** · [下载](https://gitee.com/guleng2005/Aruhan-AI/releases) · [安装](INSTALL.md) · [许可证](LICENSE.zh-CN.md) · [免责声明](DISCLAIMER.md)


**你的代码库，你的机器，你的模型；一个真正把工程闭环跑完的 AI 工程师。**

Aruhan 是本地优先的 AI 工程工作台。它会阅读你的仓库、规划改动、编辑文件、
执行命令与测试、审查差异，并让工作经过带质量门禁的交付流水线。同一套引擎
同时驱动 CLI、终端 TUI、桌面端、VS Code 插件和 Factory 控制面——你可以在一个
界面开始，在另一个界面继续，上下文不会丢。

没有 Aruhan 托管的后端，没有强制账号，默认不上报遥测。自备 API Key，指向你
已经信任的模型供应商；提示词、密钥、会话、记忆和产物都留在你的机器上。

## 为什么选择 Aruhan

多数 AI 编程工具停在"给建议"。Aruhan 把工程闭环跑完：

1. **理解。** 浏览仓库，阅读相关文件，检查测试、历史和项目规则。
2. **规划。** 拆解任务，选择需要的工具和文件。
3. **执行。** 修改代码、运行命令、应用补丁；需要时在隔离的 git worktree 中
   工作，不碰你的主工作区。
4. **验证。** 运行测试、Lint 和构建，检查差异，遇到失败继续修，而不是宣布成功。
5. **交付。** 记录产物与证据，通过质量门禁，把可审计的结果交给同事或客户。

每一步都由你掌控：权限模式决定哪些操作可以执行，审批提示会在命令或文件改动
真正发生前展示细节。

## 你可以用它做什么

- **不用盯着也能修好失败的测试。** 把失败交给 Aruhan，让它读堆栈、改代码、
  跑测试，最后把差异给你看。
- **在真实仓库里交付功能。** 智能体会遵循项目规则、复用既有模式、同步更新测试
  和文档，并保持改动可审查。
- **用 Factory 标准化交付。** 把可重复的流程写成 YAML 流水线：每个工位声明
  提示词、输入输出、模型、超时和质量门禁；每次运行都留下产物、证据和复盘。
- **让敏感工作留在本地。** 接入你自己网络内的供应商端点，包括本地或私有化部署。没有任何内容发送给发布者。
- **继续用你已经在付费的模型。** 切换供应商和模型不需要改变工作方式；目录跟随
  供应商官网更新，凭据加密保存。
- **在你喜欢的界面工作。** 终端里开始，长会话转到桌面端，或者留在 VS Code——
  都是同一套运行时和同一个配置目录。

## 一套引擎，五个界面

| 界面 | 适合场景 | 入口 |
|---|---|---|
| **CLI / REPL** | 脚本、自动化、一次性任务 | `aruhan`、`aruhan query "..."` |
| **终端 TUI** | 不离开 Shell 的长交互会话 | `aruhan chat` |
| **桌面端** | 可视化审查、设置、会话和 Factory 控制台 | `aruhan-desktop` |
| **VS Code 插件** | 在正在编辑的代码旁使用智能体 | 本发布中的 `.vsix` |
| **Factory** | 可重复、可审计的交付流水线 | `factory serve` |

Windows 上是原生窗口；Linux 与 macOS 为 headless：在本机回环端口提供同一套
UI，并用默认浏览器打开。

## Factory：从一次性对话到可重复交付

Factory 是面向"必须可重复"的工作的控制面。Pack 定义交付过程，Pipeline 是
一串工位（station）。每个工位声明提示词、输入、输出、超时、模型和门禁，所以
下周换一个仓库，仍能用同一套流程和同一个质量标尺再跑一遍。

- **机器检查阻塞，建议性检查告警，人工门禁挂起运行**，直到有权限的人批准。
- **每次运行都记录证据**：产物、账本、复盘和 worktree 隔离，而不是散落在聊天记录里。
- **控制面与执行面分离。** `factory serve` 接收并跟踪运行；独立 worker 执行工位，
  HTTP 请求不会变成运行时。
- **控制台在本地**：`http://127.0.0.1:8787/console/`，默认 SQLite，较大部署可用 PostgreSQL。

## 为真实工程而做

- **受权限约束的工具。** 读写文件、执行 Shell、使用 git 和 worktree、跑测试、
  调用 MCP 服务、自动化浏览器，并在启用时控制桌面；每项能力都受权限规则约束。
- **会话、记忆与技能。** 随时恢复工作，保存项目级长期记忆，把可复用的经验
  沉淀为技能。
- **子代理与本地协同。** 把工作拆给多个专注的智能体，或让两个本地 Aruhan 进程
  通过本地 peer mesh 协同。
- **文本与媒体模型。** 文本模型，加上图片、视频和语音生成；按发行版过滤可用供应商。
- **配置化扩展。** MCP 服务、技能、Pack、Pipeline 和模型目录都是配置，不需要改引擎。
- **跨平台。** Windows、Linux、macOS，支持 amd64 与 arm64。

## 发行版与模型

本次下载是**国内版**（`cn`）。

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

## 快速开始

### 1. 安装

| 你需要 | 下载 |
|---|---|
| Windows 全量安装（推荐） | **Aruhan-Setup-2.1.30-cn.exe** |
| 仅 Windows CLI | **Aruhan-CLI-Setup-2.1.30-cn.exe** |
| 仅 Windows 桌面端 | **Aruhan-Desktop-Setup-2.1.30-cn.exe** |
| Windows Factory | **Factory-Setup-2.1.30-cn.exe** |
| Windows 便携版 | 对应的 **aruhan-windows-*-2.1.30-cn.zip** |
| Linux CLI / Factory | **aruhan-linux-*.tar.gz**、**factory-linux-*.tar.gz** |
| macOS CLI / Factory | **aruhan-darwin-*.tar.gz**、**factory-darwin-*.tar.gz** |
| Linux / macOS 桌面端 | 对应的 **aruhan-desktop-*--cn** 二进制 |
| VS Code | **aruhan-vscode-cn.vsix** |

逐步说明（PATH、Gatekeeper、SmartScreen）见 [INSTALL.md](INSTALL.md)。

### 2. 配置模型

最简单的方式是环境变量：

~~~bash
export ARUHAN_PROVIDER="你的供应商"
export ARUHAN_MODEL="你的模型"
export ARUHAN_API_KEY="你的密钥"
~~~

供应商专属变量（如 `DEEPSEEK_API_KEY`）同样有效。桌面端、
VS Code 插件、CLI 和 TUI 都会把环境变量配置显示为已启用，也可以在应用内保存
同样的设置。

### 3. 运行

~~~bash
aruhan --plain                 # CLI / REPL
aruhan query "修一下 ./internal/foo 里失败的测试"
aruhan chat                    # 全屏 TUI
aruhan-desktop                 # 桌面端（Linux/macOS 为 headless）
factory serve                  # Factory 控制台：127.0.0.1:8787/console/
~~~

### 4. 校验下载

~~~bash
sha256sum -c SHA256SUMS
~~~

~~~powershell
Get-FileHash -Algorithm SHA256 <文件>
# 与 SHA256SUMS 中对应行比对
~~~

国内版构建可通过版本号确认发行版：

~~~bash
aruhan --version
~~~

## 平台与测试状态

| 平台 | 状态 |
|---|---|
| Windows | 已测试，包括原生桌面端和安装器。 |
| Linux | CLI 与 Factory 已在 WSL 冒烟通过；桌面端为 headless，使用浏览器 UI。 |
| macOS | 已发布 Intel 与 Apple Silicon 构建，尚未覆盖所有 macOS 版本；欢迎反馈问题。 |

Windows 安装包**未做代码签名**。SmartScreen 拦截时，先核对 `SHA256SUMS`，再选择
**【更多信息】→【仍要运行】**。该提示仅因缺少签名，并非病毒。

## 授权与商业使用

Aruhan **个人非商业使用免费**。商业使用——包括公司或团队使用、生产部署、
私有化/本地部署、把 Aruhan 嵌入产品或服务、定制开发，以及源码/永久买断——
需要另行签署书面商业授权。

我们的条款尽量务实：

- **团队与商业授权**，按用户数和部署规模确定。
- **私有化/本地部署**，包括离线与内网安装，明确范围与支持条款。
- **定制开发与集成**，对接你的交付流程、供应商或内部系统。
- **源码或永久买断**，以签署的协议为准；所有权转让只有在协议明确写明时才生效。

请联系 **37735973@qq.com**，说明你的组织、部署规模和用途。邮件标题使用
`Aruhan 商业授权` 或 `Aruhan 私有化部署` 可以更快得到回复。

发布仓库只包含编译产物，不发布源代码。具有约束力的条款见 [LICENSE](LICENSE)
与 [LICENSE.zh-CN.md](LICENSE.zh-CN.md)。

## 安全、可接受使用与免责声明

Aruhan 会执行模型请求的工具，可能修改文件、运行命令、调用外部服务。开启无人值守
模式前请先阅读本节。

- **不提供担保。** 软件按**“现状”**提供，不附带任何明示或默示担保，包括适销性、
  特定用途适用性和不侵权担保。
- **不对使用后果负责。** 在适用法律允许的最大范围内，作者与版权持有人不对因本软件、
  AI 输出、工具执行、供应商行为、配置错误或数据丢失产生的任何直接、间接、附带、
  特殊、后果性或惩罚性损害承担责任，包括利润、数据或商业机会损失。
- **审查与合规由你负责。** 审查每一处差异和命令，保留备份，使用最小权限，先在
  非生产环境验证，并遵守法律及每个模型供应商的条款。AI 输出不构成法律、医疗、
  金融或其他专业建议。
- **未经独立验证和必要批准，禁止用于高风险场景**：生命维持、医疗诊断、航空、铁路、
  汽车安全、工业控制、核、化学、生物、武器、应急响应、执法、司法决策和关键基础设施。
- **禁止行为**包括违法使用、恶意软件、未授权访问、绕过安全或授权控制，以及下述限制。

**逆向工程与转售。** 除适用法律明确允许外，你不得反编译、反汇编或逆向工程官方
二进制；不得绕过授权、认证、租户隔离或凭据保护；不得移除专有或归属声明；未经
书面许可，不得转售、出租、出借、再许可、分发或再分发本软件或修改后的二进制。
修改过的二进制不得冒充官方构建。

完整声明见 [DISCLAIMER.md](DISCLAIMER.md)。它是项目声明，不构成法律意见；请按
你所在司法辖区咨询律师。

## 支持与联系

- **安装与使用：** 见 [INSTALL.md](INSTALL.md) 与问题跟踪器 https://gitee.com/guleng2005/Aruhan-AI/issues。
- **安全问题：** 请私下发送邮件至 **37735973@qq.com**，不要在公开 Issue 中附带
  凭据、客户数据或漏洞细节。
- **商业授权、私有化部署与买断：** **37735973@qq.com**。

## 本发布包含的资产

<details>
<summary><strong>展开全部 27 个资产</strong></summary>

- **darwin/aruhan-darwin-amd64-2.1.30-cn.tar.gz** — 43,021,479 bytes
- **darwin/aruhan-darwin-arm64-2.1.30-cn.tar.gz** — 40,717,329 bytes
- **darwin/factory-darwin-amd64-2.1.30-cn.tar.gz** — 44,846,172 bytes
- **darwin/factory-darwin-arm64-2.1.30-cn.tar.gz** — 42,274,216 bytes
- **linux/aruhan-linux-amd64-2.1.30-cn.tar.gz** — 42,354,791 bytes
- **linux/aruhan-linux-arm64-2.1.30-cn.tar.gz** — 39,242,551 bytes
- **linux/factory-linux-amd64-2.1.30-cn.tar.gz** — 44,156,480 bytes
- **linux/factory-linux-arm64-2.1.30-cn.tar.gz** — 40,790,134 bytes
- **vscode/aruhan-vscode-cn.vsix** — 87,785,977 bytes
- **windows/Aruhan-CLI-Setup-2.1.30-cn.exe** — 21,786,757 bytes
- **windows/aruhan-cn.exe** — 72,486,400 bytes
- **windows/aruhan-desktop-arm64-cn.exe** — 38,200,832 bytes
- **windows/aruhan-desktop-cn.exe** — 43,929,088 bytes
- **windows/Aruhan-Desktop-Setup-2.1.30-cn.exe** — 33,371,707 bytes
- **windows/aruhan-desktop-windows-amd64-2.1.30-cn.zip** — 15,500,355 bytes
- **windows/aruhan-desktop-windows-arm64-2.1.30-cn.zip** — 13,026,635 bytes
- **windows/Aruhan-Setup-2.1.30-cn.exe** — 33,377,724 bytes
- **windows/aruhan-tui-installer-windows-amd64-cn.exe** — 76,065,792 bytes
- **windows/aruhan-tui-installer-windows-arm64-cn.exe** — 71,153,664 bytes
- **windows/aruhan-windows-amd64-2.1.30-cn.zip** — 28,893,170 bytes
- **windows/aruhan-windows-amd64-cn.exe** — 72,486,400 bytes
- **windows/aruhan-windows-arm64-2.1.30-cn.zip** — 26,637,415 bytes
- **windows/aruhan-windows-arm64-cn.exe** — 67,772,416 bytes
- **windows/factory-cn.exe** — 40,718,336 bytes
- **windows/Factory-Setup-2.1.30-cn.exe** — 33,903,279 bytes
- **windows/factory-windows-amd64-cn.exe** — 40,718,336 bytes
- **windows/factory-windows-arm64-cn.exe** — 37,515,264 bytes

</details>

## 文档

| 文档 | 用途 |
|---|---|
| [INSTALL.md](INSTALL.md) | 安装、升级、PATH、Gatekeeper 与 SmartScreen |
| [LICENSE](LICENSE) / [LICENSE.zh-CN.md](LICENSE.zh-CN.md) | 具有约束力的许可条款 |
| [DISCLAIMER.md](DISCLAIMER.md) | 担保、责任、可接受使用与高风险限制 |
| [RELEASE_NOTES.md](RELEASE_NOTES.md) | 本版本变更 |
| **SHA256SUMS** | 所有分发文件的校验和 |
