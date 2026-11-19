# Aruhan v2.1.22

**Release date / 发布日期：2026-11-19** · [Checksums / 校验和](v2.1.22-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.22) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.22) · [English](#english) · [中文](#中文)

---

## English

v2.1.22 makes the end of a turn explicit. Until now the UI showed whatever
sentence the model happened to write last; on tool-heavy turns that sentence
was often a progress line written before the final tool ran, or no sentence at
all. Users could not tell whether the task was complete, partially complete,
stopped, or waiting for them. This release adds a model-written turn
conclusion, carries it through the shared protocol, and renders it consistently
in Desktop, the VS Code extension, the CLI and the TUI. Configuration and data
formats are unchanged.

### Turn result: a conclusion the model actually writes

- New `WrapUp` tool. On any turn where the model changed files, ran commands,
  completed multi-step work, or stopped because it needs a decision, it records
  `status`, a substantive summary, `changes`, `verification`, `remaining` and
  `next_actions` before writing its closing message.
- The engine captures that record and attaches it to the turn as `outcome`,
  together with machine-checkable facts: status, open work, stop reason,
  duration and tool count. If the model does not call `WrapUp`, the engine
  nudges it once (bounded); if it still does not, clients fall back to the
  machine facts, so no turn ends without a result block.
- The closing instruction no longer conflicts with the stop gate. “Do not stop
  to summarize” applies only while work remains; once the work is closed, a
  conclusion is required.
- `message_done`, `cancelled` and `error` now all carry `outcome`. A user stop
  or a timeout reports where the turn stopped and what remains instead of only
  saying “cancelled”.
- Desktop, VS Code, CLI and TUI render the same block: status, model summary,
  remaining work, stop reason and next step. Changes and verification are
  available under “Details” so the conclusion stays readable.

### Desktop

- The turn-result card is compact: model summary, up to three remaining items
  and the next step stay visible; changes, verification and extra remaining
  items fold into Details.
- When the model's WrapUp summary substantially repeats the closing message,
  it is shown only once.
- Tool-result diffs are read-only. Per-hunk Accept/Reject and “apply selected”
  were removed: the tool already wrote the file, so those buttons were a second
  partial write, not an approval. Use checkpoint/undo to revert a change.
  The dedicated file-preview diff keeps its review actions.

### VS Code extension

- The extension host used to drop the new `outcome` field while normalizing
  stream events, so the IDE never received the result block. It is now
  forwarded and typed in the shared protocol.
- Assistant turns are flat: no nested cards. Completed tool calls collapse into
  one “N tool calls” process row; failures stay visible. The transcript uses
  VS Code surface colors, 4–8px radii and one accent instead of gradients,
  blur and per-tool theme colors.
- The composer textarea had no `min-width` in its flex row, so it shrank to one
  character wide and Chinese input rendered vertically. It now takes the
  remaining width; narrow panels hide the history button and resize grip.

### Verification

- `go test` for engine, query, tools, permission and i18n; desktop `tsc` and
  ChatView tests; VS Code build, event-routing and debate-render tests; i18n
  gate.
- Real-input runs: a Windows Desktop build created and read back a file and
  displayed the model-written result card; a VS Code window with the packaged
  VSIX did the same, including Chinese composer input and the result block
  after the host-forwarding fix.
- Checksums for every artifact are in
  [v2.1.22-SHA256SUMS.txt](v2.1.22-SHA256SUMS.txt). Windows binaries remain
  unsigned; SmartScreen may warn.

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart any daemon started by an older build; a running process cannot be
  replaced in place.
- No configuration or data migration is required.

---

## 中文

v2.1.22 解决的是“一轮结束时到底发生了什么”说不清的问题。此前界面只显示模型最后碰巧写下的那句话；工具密集的回合里，那句话常常是最后一次工具执行前的进度描述，甚至整轮没有正文。用户无法判断任务是完成了、部分完成、被停止，还是在等自己。这个版本增加由模型撰写的回合结论，通过共享协议传到各端，并在 Desktop、VS Code 插件、CLI 和 TUI 中一致呈现。配置与数据格式不变。

### 回合结果：由模型真正写出的结论

- 新增 `WrapUp` 工具。凡是改过文件、跑过命令、完成多步工作，或因需要用户决策而停止的回合，模型在写收尾消息前记录 `status`、实质性总结、`changes`、`verification`、`remaining` 和 `next_actions`。
- 引擎捕获这份记录，作为 `outcome` 随回合返回，同时附带机器可核对的事实：状态、未完成项、停止原因、耗时和工具调用数。模型没有调用 `WrapUp` 时，引擎会有界地提醒一次；仍未调用时，客户端退回机器事实，保证没有回合缺少结果区。
- 收尾指令不再与收尾闸门冲突。“不许停下来总结”只在还有未完成工作时生效；工作清空后必须给出结论。
- `message_done`、`cancelled`、`error` 都携带 `outcome`。用户停止或超时不再只显示“已取消”，而是说明停在哪、还剩什么。
- Desktop、VS Code、CLI、TUI 使用同一套内容：状态、模型总结、剩余工作、停止原因、下一步。改动和验证收进“详情”，避免结论区变成第二篇长文。

### Desktop

- 结果卡更紧凑：模型总结、最多 3 条剩余工作和下一步常驻；改动、验证和更多剩余项折叠进“详情”。
- 模型 `WrapUp` 总结与收尾正文高度重复时，只显示一次。
- 工具结果 diff 改为只读。移除逐 hunk 的接受/拒绝和“应用所选”：工具已经写完文件，这些按钮实质是第二次部分回写，不是审批。需要撤销时使用检查点/回退。独立文件预览面板保留审查操作。

### VS Code 插件

- 扩展宿主在归一化流事件时丢掉了新的 `outcome` 字段，导致 IDE 一直收不到结果卡；现已透传并纳入共享协议类型。
- 助手回合改为扁平结构，不再层层套卡片。已完成的工具调用收成一行“N 步工具调用”，失败项保持可见。界面使用 VS Code 原生表面色、4–8px 圆角和单一强调色，去掉渐变、毛玻璃和每种工具一套主题色。
- 输入框此前没有 `min-width`，被两侧按钮挤成一个字符宽，中文输入呈竖排；现已占满剩余宽度，窄面板隐藏历史按钮和拖拽手柄。

### 验证

- 引擎、query、工具、权限与 i18n 的 Go 测试；Desktop `tsc` 与 ChatView 测试；VS Code 构建、事件路由与辩论渲染测试；i18n 门禁。
- 真实输入验证：Windows Desktop 构建创建并读回文件，显示模型撰写的结果卡；带打包 VSIX 的 VS Code 窗口完成同样操作，中文输入与结果卡均正常。
- 所有产物的校验和见 [v2.1.22-SHA256SUMS.txt](v2.1.22-SHA256SUMS.txt)。Windows 二进制仍未签名，SmartScreen 可能提示。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 使用旧版本启动的 daemon 需要重启；运行中的进程无法原地替换。
- 无需迁移配置或数据。

### Artifacts

- Windows: Aruhan-Setup, Aruhan-CLI-Setup, Aruhan-Desktop-Setup and Factory-Setup installers; portable CLI/Desktop ZIPs; TUI installer.
- Linux/macOS: aruhan-* and factory-* tarballs with standalone binaries.
- VS Code: aruhan-vscode.vsix.
- Evidence: sbom.cdx.json, licenses.json, Aruhan-Manuals-2.1.22.zip, v2.1.22-SHA256SUMS.txt.

All Windows binaries are unsigned; SmartScreen may warn. Verify every download against v2.1.22-SHA256SUMS.txt.

---

### 产物

- Windows：Aruhan-Setup、Aruhan-CLI-Setup、Aruhan-Desktop-Setup、Factory-Setup 安装包；CLI/Desktop 便携 ZIP；TUI 安装器。
- Linux/macOS：aruhan-* 与 factory-* tar 包及独立二进制。
- VS Code：aruhan-vscode.vsix。
- 佐证：sbom.cdx.json、licenses.json、Aruhan-Manuals-2.1.22.zip、v2.1.22-SHA256SUMS.txt。

Windows 二进制均未签名，SmartScreen 可能提示。下载后请用 v2.1.22-SHA256SUMS.txt 校验。
