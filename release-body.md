# Aruhan v2.1.20

**Release date / 发布日期：2026-11-18** · [Checksums / 校验和](v2.1.20-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.20) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.20) · [English](#english) · [中文](#中文)

---

## English

v2.1.20 aligns the Desktop and IDE clients with the TUI transcript
experience, fixes stale engine selection, and completes the Factory console
work started after v2.1.19. Configuration and data formats are unchanged.

### Diff and reasoning in Desktop and IDE

- Tool cards render the same canonical hunks as the TUI: three context lines,
  a 15-row inline cap, and an explicit control to expand the full diff.
- The inline diff appears immediately, including when the tool returns no
  textual output. Cards with a diff auto-expand, and long tool chains keep
  diff-bearing cards visible instead of collapsing them into the summary.
- The IDE no longer wipes the inline diff by writing the result text after it
  was mounted, and opens the tool body so changed lines are visible at once.
- Reasoning blocks expand while the model is thinking and collapse when the
  response finishes. Later reasoning groups use the same rule; the collapsed
  row keeps only line and token counts.

### Language and runtime

- Assistant reply language defaults to the language of the user's latest
  message. Chinese questions receive Chinese prose; English questions receive
  English prose. Code, identifiers, paths, commands and quoted errors keep
  their original form. An explicit `zh`/`en` setting still overrides the
  default, and the UI language no longer forces replies.
- YOLO/BYPASS permission modes now bypass high-risk approval prompts unless a
  hard risk denial applies, matching the “no confirmations” promise.
- Long completions continue after a max-output-token stop instead of ending
  with a half-written answer.
- `aruhan query` prints the final answer once; it no longer streams the same
  tokens to stderr before printing the result.
- `TaskLedger` and `DeliverableImpact` are now core tools. They were required
  by the system prompt but hidden behind `ToolSearch`, which made models claim
  they were unavailable, leave work items open and trigger repeated
  Auto-continuing turns.

### Stale engine selection

- Desktop chooses the newest engine among its build and install candidates
  instead of the first platform-suffixed file it finds. `ARUHAN_BINARY` and
  `PATH` remain fallbacks.
- The IDE resolves its extension directory through the extension manifest
  rather than a hard-coded extension ID, so an ID mismatch can no longer send
  it silently to an older CLI on `PATH`. Bundled engines are rebuilt for
  Windows, Linux and macOS in the VSIX.
- Restart any daemon started by an older build before using the new one; a
  running process cannot be replaced in place.

### Factory console and planning

- The start page now follows the designed plan flow; the sidebar CTA and the
  start page share one composer.
- The model infers project scale, modules and integrations from the
  requirement. Manual module/integration inputs were removed from the primary
  flow; the legacy form is available only as advanced parameters.
- Run details show real project paths, heartbeat-based liveness and the
  effective execution policy. Gate approval and tool auto-approval are
  separate settings.
- Thinking effort is carried through the ACP session policy with
  run > station > project > deployment precedence.
- Pipeline and station-pack resolution use one configuration root, fixing
  “unknown station” mismatches.
- Factory runtime state is excluded from snapshots and Windows long paths are
  enabled, so crew handoffs survive deep paths.
- System events render through React, fixing the runtime DOM failure during
  long SSE streams.

### Verification

- Go tests for the changed engine, provider, config, CLI and Factory control
  plane packages pass.
- Shared render model: 31 render tests and 12 protocol tests pass.
- Desktop frontend: diff, reasoning-lifecycle and effort suites pass.
- Factory web console: 172 tests pass.
- IDE inline diff/reasoning regression test passes.
- Real Desktop run with mouse and keyboard: YOLO + high effort, Chinese
  prompt returned Chinese prose, the inline diff showed 14 rows with the
  “show full diff (21 more rows)” control, reasoning expanded during
  streaming and collapsed at the end, and `TaskLedger` completed without an
  Auto-continuing loop.
- Full artifact build: see `v2.1.20-SHA256SUMS.txt` for the complete list and
  hashes.

### Upgrade notes

- Official v2.1.20 builds inject `ExpiresAt=2027-02-28`; local builds without
  `-Expires` are not time-limited.
- Windows binaries are unsigned; SmartScreen may warn. Signing instructions:
  [RELEASE-SIGNING](../operations/RELEASE-SIGNING.md).
- Close Desktop, a running daemon and any `factory serve` before replacing
  installed binaries.

---

## 中文

v2.1.20 让 Desktop 与 IDE 插件的对话记录与 TUI 对齐，修复旧引擎选择问题，并
完成 v2.1.19 之后的 Factory 控制台与规划工作。配置与数据格式不变。

### Desktop 与 IDE 的 diff 和思考展示

- 工具卡渲染与 TUI 相同的 canonical hunk：上下各 3 行上下文、内联最多 15 行、
  可展开查看完整 diff。
- diff 立即显示，包括工具没有文本输出的情况；带 diff 的卡片自动展开，长工具链
  聚合时不会再把这些卡片折叠进摘要。
- IDE 修复了先挂 diff、随后写文本又把 diff 清空的问题，并自动展开工具正文，
  修改行一眼可见。
- 思考块在模型思考时展开、回答完成后折叠；后续推理组使用同一规则，折叠行只保留
  行数与 token 估算。

### 语言与运行时

- AI 回复语言默认跟随用户最新一条消息：中文提问用中文正文，英文提问用英文正文。
  代码、标识符、路径、命令、报错原文保持原样。显式设置 `zh`/`en` 仍可覆盖默认；
  界面语言不再强制回复语言。
- YOLO/BYPASS 权限模式不再对高风险工具弹审批（硬风险拒绝仍然生效），与
  “不再确认”的承诺一致。
- 达到最大输出 token 时继续生成，而不是留下半截回答。
- `aruhan query` 只打印一次最终答案，不再先向 stderr 流式输出一遍。
- `TaskLedger` 与 `DeliverableImpact` 加入核心工具。系统提示要求使用它们，但它们
  此前只能通过 `ToolSearch` 发现，模型因此声称“不可用”，留下未完成项并反复触发
  Auto-continuing。现已在每轮工具定义中直接可见。

### 旧引擎选择问题

- Desktop 在 build/安装目录候选中选择最新引擎，而不是第一个带平台后缀的文件；
  `ARUHAN_BINARY` 与 `PATH` 仅作回退。
- IDE 通过扩展清单解析自身目录，不再硬编码扩展 ID；ID 不匹配时不会静默回退到
  旧版 PATH CLI。VSIX 内置的 Windows/Linux/macOS 引擎已重新构建。
- 旧版本启动的 daemon 需要重启一次；运行中的进程无法原地替换。

### Factory 控制台与规划

- 开始页按设计后的规划流程工作；侧栏“创建工作”和开始页共用同一个输入区。
- 由模型根据需求推断项目规模、模块与集成，主流程移除人工模块/集成输入；旧表单只
  作为高级参数入口。
- 运行详情显示真实项目路径、基于心跳的存活状态和实际执行策略；人工闸门与工具自动
  批准拆成独立设置。
- 思考档位通过 ACP 会话策略传递，优先级为 run > station > project > deployment。
- 流水线与工位包使用同一配置根解析，修复“unknown station”不匹配。
- Factory 运行态目录从快照中排除，并启用 Windows 长路径，深目录 crew 交接不再失败。
- 系统事件改由 React 渲染，修复长 SSE 流下的 DOM 运行时错误。

### 验证

- 变更涉及的 Go engine/provider/config/CLI 与 Factory 控制面测试通过。
- 共享渲染模型：31 个 render 测试、12 个 protocol 测试通过。
- Desktop 前端 diff、思考生命周期、档位测试通过。
- IDE 内联 diff/思考回归测试通过。
- 真实桌面鼠标键盘测试：YOLO + 高思考档位，中文提示返回中文正文；内联 diff 显示
  14 行并带“展开完整 diff（还有 21 行）”；思考流式期间展开、结束后折叠；
  `TaskLedger` 正常完成，未出现 Auto-continuing 循环。
- 全量产物与哈希见 `v2.1.20-SHA256SUMS.txt`。

### 升级说明

- 官方 v2.1.20 构建注入 `ExpiresAt=2027-02-28`；未传 `-Expires` 的本地构建不受
  时间限制。
- Windows 二进制未签名，SmartScreen 可能提示；签名流程见
  [RELEASE-SIGNING](../operations/RELEASE-SIGNING.md)。
- 替换已安装二进制前，请关闭 Desktop、正在运行的 daemon 和 `factory serve`。
