# Aruhan v2.1.19

**Release date / 发布日期：2026-11-17** · [Checksums / 校验和](v2.1.19-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.19) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.19) · [English](#english) · [中文](#中文)

---

## English

v2.1.19 is a TUI/CLI reliability release. It fixes the input, selection and
running-state rendering problems reproduced in real streaming turns, and keeps
the same configuration and data formats.

### TUI input

- Windows input is split by console type. Classic conhost uses Bubble Tea
  `coninput`, so the console owns Chinese IME composition and the input line is
  no longer rendered twice (composition ghosting). ConPTY terminals (Windows
  Terminal, IDE terminals) keep the CONIN$ + VT input path, which handles UTF-8
  and bracketed paste correctly and does not hit the coninput broken-pipe error
  on resize.
- `Ctrl+J` remains available on classic conhost with
  `ARUHAN_TUI_VT_INPUT=1`; the default newline key is `Alt+Enter`.

### Mouse selection and copy

- A left click no longer activates a selection or changes the bottom band;
  only a real drag does.
- Selection is anchored to transcript lines, so streaming output does not move
  it, and the highlight covers only the selected columns while keeping colors.
- Releasing the mouse copies the selection and keeps the highlight. Hovering
  after release no longer changes the selection (reported in 2.1.18 testing).
- Copy feedback is shown in status line 2 instead of appending a transcript
  line, so the output area does not scroll after a copy.
- Windows clipboard reads/writes use the Win32 API directly. This removes the
  PowerShell child process that blocked the event loop for 0.5–2 seconds per
  copy.

### Running-state rendering

- The status bar renders a single running indicator; the old static
  `ToolStatus`/`CurrentToolName` copy is gone.
- Classic conhost now uses a full-screen painter (fixed-height frame written
  from `\x1b[H` on every update, coalesced in a writer goroutine) instead of
  the standard line-diff renderer. This fixes the duplicate “thinking” line and
  the overwritten status row seen while a turn was streaming. ConPTY keeps the
  standard renderer; the console type is detected by the console window class
  (`PseudoConsoleWindow` vs `ConsoleWindowClass`).
- The frame is normalized to a fixed number of rows and leaves two columns, so
  line-diff residues and terminal auto-wrap are avoided.
- Multi-paragraph streamed replies no longer repeat or drop paragraphs: a
  paragraph flush replaces its placeholder, and the next paragraph starts a new
  one. The turn summary uses the first physical line only.

### Status bar and banner

- F2 now always shows the file-access pill for all three scopes (read-only,
  workspace, full disk) instead of hiding full access.
- The banner line “version | model | permission | scope” is refreshed in place
  after F2, `Ctrl+Y`, `Shift+Tab` or a model switch, so the top of the screen
  matches the current state.

### CLI (plain REPL)

- F2 cycles the file-access scope like the TUI and prints the new scope.
  Previously the F2 escape sequence was partially consumed and the trailing
  byte was inserted into the input line.
- Engine INFO logs are suppressed while a turn is streaming, so
  `stream route`, `initializing agent engine` and `cache warmup` no longer cut
  through answers. The configured level is restored afterwards;
  `ARUHAN_REPL_LOG_INFO=1` keeps INFO for troubleshooting.

### Startup

- Startup no longer waits on the CodeMapper background index: `IsAvailable` is
  lock-free and crew integration no longer calls `NodeCount` synchronously.
  Measured with a copy of a real 175 MB data directory: TUI banner in ~1.5 s,
  `--plain` banner in ~0.2 s.

### Verification

- Real turns with streaming and a Bash tool call, including click/drag/copy
  while output was live: `docs/testing/assets/tui-running-2026-11-16`.
- Selection/copy evidence: `docs/testing/assets/tui-selection-2026-11-16`;
  F2 scope evidence: `docs/testing/assets/tui-f2-2026-11-17` and
  `docs/testing/assets/cli-f2-2026-11-17`.
- New regression tests cover click-without-selection, release-copy, hover after
  release, column-accurate CJK copy, multi-paragraph streaming, frame
  normalization, painter protocol, renderer choice, scope pills and F2
  decoding.
- Brand gate, gofmt, plan-check (105/105) and the i18n guard pass.
- PTY baseline tests pass except `TestPTYCtrlCShowsTwoStageExit`, which is
  flaky on this machine in the 2.1.18 baseline as well (1 of 5 runs).
- Full build: `build-all.ps1 -Clean -Expires 2027-02-28` produced
  57 artifacts; `sha256sum -c` passed; the
  embedded version is 2.1.19 (commit e99ce045). Windows binaries are unsigned.

### Known limitations

- ConPTY terminals keep the standard renderer. If running-state residue is
  observed there, the full-screen painter can be forced with
  `ARUHAN_TUI_FULL_REDRAW=1`, but ConPTY resize can then terminate the process;
  classic conhost is the supported target for that mode.
- Windows binaries remain unsigned.
- In the plain CLI, the line editor is suspended while a turn streams, so the
  prompt is not redrawn until the turn ends; typed input is still queued. ESC
  does not interrupt a CLI turn (use `Ctrl+C`).
- The trial expiry injected into official builds is 2027-02-28.

---

## 中文

v2.1.19 是一次 TUI/CLI 可靠性版本，修复真实流式回合中复现的输入、选择与运行态
渲染问题，配置与数据格式保持不变。

### TUI 输入

- Windows 输入按终端类型分流：经典 conhost 使用 Bubble Tea `coninput`，由
  控制台负责中文输入法组字，输入行不再出现"组字 + textarea"两份的重影；
  ConPTY（Windows Terminal、IDE 终端）保留 CONIN$ + VT 输入，UTF-8 与括号
  粘贴正常，也不会在缩放时触发 coninput 的 broken pipe。
- 经典 conhost 需要 `Ctrl+J` 换行时设置 `ARUHAN_TUI_VT_INPUT=1`；默认换行键
  为 `Alt+Enter`。

### 鼠标选择与复制

- 单击不再激活选区或改变底部固定带，只有真正拖动才选择。
- 选区锚定在 transcript 行上，流式输出不会让选区漂移；反色只覆盖选中列，
  并保留原有颜色。
- 松开鼠标即复制并保留高亮；松开后悬停/滑动不再改变选区（2.1.18 测试中发现）。
- 复制结果改为状态栏第二行提示，不再追加 transcript 行，复制后输出区不滚动。
- Windows 剪贴板读写改为原生 Win32 API，去掉每次复制启动 PowerShell 子进程
  导致的 0.5–2 秒事件循环阻塞。

### 运行态渲染

- 状态栏只保留一条运行指示；删除旧的 `ToolStatus`/`CurrentToolName` 静态重复行。
- 经典 conhost 改用整屏重绘（每帧从 `\x1b[H` 写入固定行数，独立 goroutine
  合并高频更新），修复流式回合中"思考中"重复、状态栏第二行被盖的问题。
  ConPTY 沿用标准渲染器；终端类型通过控制台窗口类名判别
  （`PseudoConsoleWindow` / `ConsoleWindowClass`）。
- 帧规整为固定行数并保留两列余量，避免行级 diff 残影与终端自动换行。
- 多段流式回答不再重复或丢失段落：段落 flush 替换自身占位行，下一段新建
  占位行；回合摘要只取第一行。

### 状态栏与横幅

- F2 三档文件范围（只读/工作区/全电脑）在状态栏都常驻显示，不再隐藏全电脑。
- 顶部 banner 的"版本 | 模型 | 权限 | 文件范围"行在 F2、`Ctrl+Y`、
  `Shift+Tab`、切换模型后原地刷新，顶部与当前状态一致。

### CLI（行式 REPL）

- F2 与 TUI 一样循环切换文件访问范围并打印当前档位；此前 F2 转义序列被部分
  消费，尾字节被插入输入行。
- 回合流式输出期间压制引擎 INFO 日志，`stream route`、`initializing agent
  engine`、`cache warmup` 不再切断回答；回合结束恢复配置级别，
  `ARUHAN_REPL_LOG_INFO=1` 可保留 INFO 用于排障。

### 启动

- 启动不再等待 CodeMapper 后台索引：`IsAvailable` 无锁，crew 集成不再同步
  调用 `NodeCount`。用真实 175MB 数据目录副本实测：TUI 首屏约 1.5 秒，
  `--plain` 约 0.2 秒。

### 验证

- 真实流式回合 + Bash 工具调用，运行中点击/拖拽/复制：
  `docs/testing/assets/tui-running-2026-11-16`。
- 选择/复制证据：`docs/testing/assets/tui-selection-2026-11-16`；F2 范围证据：
  `docs/testing/assets/tui-f2-2026-11-17`、`docs/testing/assets/cli-f2-2026-11-17`。
- 新增回归用例覆盖：单击不选择、松开复制、松开后悬停、中文按列复制、多段
  流式、帧规整、整屏重绘协议、渲染器分流、范围 pill、F2 解码。
- 品牌门禁、gofmt、plan-check（105/105）、i18n 门禁通过。
- PTY 基线用例除 `TestPTYCtrlCShowsTwoStageExit` 外通过；该用例在本机 2.1.18
  基线上同样偶发失败（5 次中 1 次）。
- 全量构建：`build-all.ps1 -Clean -Expires 2027-02-28` 生成
  57 项工件；`sha256sum -c` 全部通过；内嵌版本
  2.1.19（commit e99ce045）。Windows 二进制未签名。

### 已知限制

- ConPTY 终端沿用标准渲染器。若那里仍出现运行态残影，可用
  `ARUHAN_TUI_FULL_REDRAW=1` 强制整屏重绘，但 ConPTY 缩放可能导致进程退出；
  该模式的支持目标是经典 conhost。
- 行式 CLI 在回合流式输出期间挂起行编辑器，提示符在回合结束后恢复；输入仍会
  入队。CLI 回合中 ESC 不中断（请用 `Ctrl+C`）。
- 官方构建注入的试用到期日为 2027-02-28。
