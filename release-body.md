# Aruhan v2.1.35

**Release date / 发布日期：2026-11-28** · [CN checksums / 国内版校验和](https://gitee.com/guleng2005/Aruhan-AI/releases/download/v2.1.35/SHA256SUMS) · [INTL checksums / 国际版校验和](https://github.com/xizhihao1/Aruhan/releases/download/v2.1.35/SHA256SUMS) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.35)

**⬇ [下载 / Download](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.35)**

<details name="lang">
<summary><strong>中文 / Chinese</strong></summary>

**⬇ [立即下载 Windows 安装包](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Setup-2.1.35-cn.exe)** —
[macOS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-amd64-cn) · [Linux](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-amd64-2.1.35-cn.tar.gz) · 全部平台见下表

## 下载 / Download

| 平台 | 安装包 | 说明 | 下载 |
|---|---|---|---|
| Windows | 合集：CLI + 桌面 | 一次安装 CLI 与桌面端（Factory 使用单独安装包）。 | [Aruhan 安装包](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Setup-2.1.35-cn.exe) |
| Windows | 单独安装包 | 只安装需要的端。 | [CLI](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-CLI-Setup-2.1.35-cn.exe) · [桌面](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Desktop-Setup-2.1.35-cn.exe) · [Factory](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Factory-Setup-2.1.35-cn.exe) |
| Windows | 便携 ZIP | 免安装，解压即用。 | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-windows-amd64-2.1.35-cn.zip) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-windows-arm64-2.1.35-cn.zip) |
| Windows arm64 | TUI 安装器 | Windows ARM 终端界面安装器。 | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-tui-installer-windows-amd64-cn.exe) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-tui-installer-windows-arm64-cn.exe) |
| macOS | 桌面应用 | 原生应用；headless 构建用浏览器打开界面。 | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-amd64-cn) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-arm64-cn) |
| macOS | CLI/TUI 压缩包 | CLI 与 TUI 的 tar.gz 压缩包。 | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-darwin-amd64-2.1.35-cn.tar.gz) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-darwin-arm64-2.1.35-cn.tar.gz) |
| Linux | 桌面应用 | headless 二进制，启动后用浏览器打开界面。 | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-linux-amd64-cn) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-linux-arm64-cn) |
| Linux | CLI/TUI/Factory 压缩包 | CLI、TUI 与 Factory 的 tar.gz 压缩包。 | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-amd64-2.1.35-cn.tar.gz) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-arm64-2.1.35-cn.tar.gz) |
| VS Code | 扩展 | 在 VS Code 扩展视图安装。 | [VSIX](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-vscode-cn.vsix) |
| 全部 | 完整性校验 | 所有分发文件的校验和。 | [SHA256SUMS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/SHA256SUMS) |

安装、升级、PATH、Gatekeeper 与 SmartScreen 说明见 [INSTALL.md](https://github.com/xizhihao1/Aruhan-AI/blob/main/INSTALL.md)；
完整资产列表在页面最下方。

## 中文


v2.1.35 让跨会话协同在每个表面真正执行工作，并修复了验证过程中发现的多个
生产问题。

### 对等消息可以唤醒所有客户端

其他 Aruhan 会话发来的消息现在会在接收方空闲时自动开始一轮，忙碌时排在
当前回合之后：

- TUI 与 CLI/REPL：REPL 输入层无需回车即可被唤醒，已经输入半行的内容不会
  丢失。
- Desktop 与 VS Code：客户端把唤醒文本交给普通查询链路，输出、权限与取消
  行为不变。
- ACP/Factory worker：空闲 worker 把消息注入合成 `session/prompt`；站点
  prompt 始终优先。
- 无前端的 daemon 可用 `ARUHAN_PEER_DAEMON_AUTO=1` 显式开启。

`ack` 回执不会触发回合；`ARUHAN_PEER_AUTO_TURN=0` 可关闭自动回合，仅保留
投递与提示。

### 任务级定向

`SendMessage` 新增可选 `task` 参数（`ListAgents` 展示的任务 ID 或任务名），
信封以 `To.TaskID` 携带；CLI（`aruhan peers send --task`）与 `peer.send`
RPC 同样支持。Desktop 按任务落位，VS Code 按会话落位，ACP worker 按 ACP
会话落位。TUI/REPL 对未知目标明确拒绝，不会静默落到当前会话；消息保留在
信箱，切到目标会话后可人工处理。`peer.set_context` 会把当前活动任务以
`task_id`/`task_name` 登记到 `ListAgents`。

### hold 消息、限流与审批回执

- `hold` 消息可通过 `aruhan peers accept`、daemon `peer.accept` RPC 或桌面
  收件箱的“执行”按钮人工执行；accept 不是授权，工具仍走会话权限。
- hold 消息 5 分钟未确认会过期，并向发送方回 `expired`。
- 同一发送方 5 分钟最多 3 次自动唤醒；第 4 次回 `throttled`，消息留在信箱
  可人工执行。
- 自动回合会回 `needs_approval`，随后回 `approved` / `denied` /
  `timed_out` / `cancelled`。
- 审计事件：`peer.deliver`、`peer.wake`、`peer.throttle`、
  `peer.hold_expired`、`peer.accept`（只含路由元数据与消息 ID）。

### 真实引擎里的 SendMessage

crew 的 `SendMessage` 先于 peer 工具注册，模型一直调用到 crew 版本；在非团队
场景它总是返回 `unavailable`，即使 ListAgents 已经看见对方。现在无 mailbox
时会回退到 peer bridge，工具描述也覆盖本机会话、局域网机器与 crew 邮箱。

### VS Code YOLO

VS Code 选择 YOLO 后仍逐项审批，因为旧的 `autoApproveTools` 被映射成
`auto`。现在 YOLO 原样传给 daemon。

### 跨会话工具直接可见；账本可抗掉电

`ListAgents` 与 `SendMessage` 现在进入每个 agent 的 Tier-0 工具列表，不再
依赖 ToolSearch。此前 TUI 会话能在注册表里看见另一个会话，模型却会得出
“本会话没有跨会话消息工具”的结论。

`TaskLedger` 现在改名落盘前会 fsync，并保留 `ledger.json.bak`。本机多次
非正常关机造成过一个 34,335 字节全 NUL 的账本；旧逻辑只能永久报损坏。
写路径现在会恢复上一版有效备份，或把坏文件隔离为
`ledger.corrupt-<UTC>.json` 后重建空账本。

### 验证

全部使用本地 mock 模型，无付费调用：TUI pty、REPL pty、无前端 daemon、
Desktop 自动回合与收件箱“执行”（真实鼠标审批）、真实 VS Code 窗口 CDP、
ACP worker、daemon `peer.accept`，以及两个 WSL 进程经真实局域网 IP 与 TLS
bridge 通信，均产生了真实文件写入。新增的定向链路也已验证：Desktop 两个
真实任务中消息只落在被寻址的任务、不进入当前任务；真实 VS Code 窗口中
未知目标留在信箱，有效目标执行并被 ack。Go 与扩展重点测试通过；品牌、
i18n、RPC schema 与 plan 检查通过。

**已知缺口：** 未包含公网跨 NAT 中继；未跑真实 Factory 站点全链路，其驱动
的 ACP worker 已验证。

</details>

<details name="lang" open>
<summary><strong>English</strong></summary>

**⬇ [Download Aruhan for Windows](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Setup-2.1.35-cn.exe)** —
[macOS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-amd64-cn) · [Linux](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-amd64-2.1.35-cn.tar.gz) · all platforms below

## Download / 下载

| Platform | Package | What it is | Download |
|---|---|---|---|
| Windows | Bundle: CLI + desktop | Single installer for the CLI and desktop app (Factory has its own installer). | [Aruhan bundle installer](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Setup-2.1.35-cn.exe) |
| Windows | Separate installers | Install only the surface you need. | [CLI](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-CLI-Setup-2.1.35-cn.exe) · [Desktop](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Aruhan-Desktop-Setup-2.1.35-cn.exe) · [Factory](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/Factory-Setup-2.1.35-cn.exe) |
| Windows | Portable ZIP | No-install ZIP; unpack and run. | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-windows-amd64-2.1.35-cn.zip) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-windows-arm64-2.1.35-cn.zip) |
| Windows arm64 | TUI installer | Terminal UI installer for Windows on ARM. | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-tui-installer-windows-amd64-cn.exe) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-tui-installer-windows-arm64-cn.exe) |
| macOS | Desktop app | Native app; headless builds serve the UI in a browser. | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-amd64-cn) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-darwin-arm64-cn) |
| macOS | CLI/TUI tarball | CLI and TUI in a .tar.gz archive. | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-darwin-amd64-2.1.35-cn.tar.gz) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-darwin-arm64-2.1.35-cn.tar.gz) |
| Linux | Desktop app | Headless binary; opens a local browser UI. | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-linux-amd64-cn) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-desktop-linux-arm64-cn) |
| Linux | CLI/TUI/Factory tarball | CLI, TUI and Factory in a .tar.gz archive. | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-amd64-2.1.35-cn.tar.gz) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-linux-arm64-2.1.35-cn.tar.gz) |
| VS Code | Extension | Install from the VS Code Extensions view. | [VSIX](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/aruhan-vscode-cn.vsix) |
| All | Integrity | Checksums for every distributed file. | [SHA256SUMS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.35/SHA256SUMS) |

Installation, upgrade, PATH, Gatekeeper and SmartScreen notes are in
[INSTALL.md](https://github.com/xizhihao1/Aruhan-AI/blob/main/INSTALL.md); the full asset list is at the bottom of this page.

## English


v2.1.35 makes cross-session collaboration actually execute work on every
surface, and fixes several production issues found while verifying it.

### A peer message can wake every client

A message from another Aruhan session now starts a normal turn when the
receiver is idle and queues behind the current turn when it is busy:

- TUI and CLI/REPL. The REPL input layer can be woken without pressing Enter;
  a partially typed line is never discarded.
- Desktop and VS Code. The client sends the wake text through its ordinary
  query path, so output, permissions and cancellation stay unchanged.
- ACP/Factory workers. An idle worker injects the message into a synthetic
  `session/prompt`; station prompts always win.
- Headless daemon deployments can opt in with `ARUHAN_PEER_DAEMON_AUTO=1`.

Acknowledgement envelopes never start a turn. `ARUHAN_PEER_AUTO_TURN=0`
disables automatic turns while keeping delivery and notifications.

### Task-level targeting

`SendMessage` accepts an optional `task` (a task ID or task name shown by
`ListAgents`), and the envelope carries it as `To.TaskID`. The CLI
(`aruhan peers send --task`) and the `peer.send` RPC accept the same field.
Desktop routes the message to that task, VS Code to that session, and ACP
workers to that ACP session. TUI/REPL reject an unknown target instead of
silently running it in the active session, and the message stays in the inbox
so it can be handled after switching sessions. `peer.set_context` keeps the
active task visible in `ListAgents` as `task_id`/`task_name`.

### Held messages, rate limits and approval receipts

- `hold` messages can be executed from `aruhan peers accept`, the daemon
  `peer.accept` RPC, or the desktop inbox's Execute button. Accept is not an
  authorization; tools still use the session permission mode.
- A held message not accepted within five minutes is expired and the sender
  receives an `expired` receipt.
- Automatic wakes are limited to three per sender per five minutes; the fourth
  gets a `throttled` receipt and stays in the inbox for manual acceptance.
- Peer-triggered turns report `needs_approval`, then
  `approved` / `denied` / `timed_out` / `cancelled`.
- Audit events: `peer.deliver`, `peer.wake`, `peer.throttle`,
  `peer.hold_expired`, `peer.accept` (routing metadata and message IDs only).

### SendMessage works in the real engine

The crew `SendMessage` tool is registered before the peer tool, so the model
always reached the crew implementation. Outside a team mailbox it returned
`unavailable`, even though ListAgents could see the other session. It now
falls back to the peer bridge and its description names local sessions, LAN
machines and crew mailboxes.

### VS Code YOLO

Selecting YOLO in VS Code still asked for every write approval because the
legacy `autoApproveTools` flag was mapped to `auto`. YOLO now reaches the
daemon unchanged.

### Cross-session tools are visible; ledgers survive power loss

`ListAgents` and `SendMessage` are now part of the Tier-0 tool list shown to
every agent, instead of requiring ToolSearch. Without this, a TUI session
could see that another session existed in the registry yet still tell the
model it had no cross-session messaging tool.

`TaskLedger` now fsyncs before rename and keeps `ledger.json.bak`. A machine
with repeated unclean shutdowns produced a 34,335-byte all-NUL ledger; the
old code could only report corruption forever. The write path now restores
the last valid backup, or quarantines the bad file as
`ledger.corrupt-<UTC>.json` and starts a fresh ledger.

### Verification

Mock-model harnesses only, no paid calls: TUI pty, REPL pty, daemon headless,
Desktop auto-turn and hold-inbox Execute with real approval clicks, real VS
Code window over CDP, ACP worker, daemon `peer.accept`, and two WSL processes
over a real LAN IP and TLS bridge all produced a real file write. The new
targeting path was verified with two live Desktop tasks (the message ran only
in the addressed task, not the active one) and a real VS Code window (unknown
target stayed in the inbox, valid target ran and was acked). Focused Go and
extension tests pass; brand, i18n, RPC schema and plan checks pass.

**Known gaps:** public-NAT relay is not included. A real Factory station
pipeline was not exercised end to end; the ACP worker it drives is verified.

</details>
