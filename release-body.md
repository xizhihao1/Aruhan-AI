# Aruhan v2.1.21

**Release date / 发布日期：2026-11-19** · [Checksums / 校验和](v2.1.21-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.21) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.21) · [English](#english) · [中文](#中文)

---

## English

v2.1.21 is a corrective release built cleanly from source. The v2.1.20
release attachments were produced before the approval, stop, language and
engine-selection fixes landed, so this release rebuilds every artifact with
those fixes included. Configuration and data formats are unchanged.

### YOLO and approval modes

- Selecting YOLO (or BYPASS) now really disables per-tool approval prompts.
  The evaluator's high-risk branch previously returned “ask” unconditionally,
  even for YOLO, which is why every command, file read and directory listing
  kept opening an approval dialog.
- The IDE sends the composer's current mode with each message. Selecting YOLO
  and sending immediately used to race the asynchronous settings save and run
  the first turn with the old default mode; the turn now always uses the
  mode shown in the composer, and the host echoes that mode back so the
  executed turn and the composer agree.
- High-risk operations are allowed in YOLO/BYPASS while hard-risk denials
  still apply: catastrophic deletes, credential exfiltration patterns and
  protected-path writes cannot be auto-approved.
- Non-interactive callers still fail closed: an approval that cannot be
  answered is denied instead of silently allowed.
- Deny/ask reasons are preserved, so a blocked action explains why.

### Stop now cancels the whole turn

- Desktop stop falls back to task-level cancellation when the stream ids are
  no longer tracked, and cancels every pending approval belonging to that
  stream. The daemon emits `permission_cancelled`.
- The IDE sends `abort` with `stream_id`; the daemon cancels the stream and
  its pending approvals, and the webview closes any open approval dialog.
- Desktop and IDE clear the approval state on `permission_cancelled`; a
  stopped run no longer keeps popping dialogs after the stop button.
- A user stop is no longer rendered as an error. The engine used to emit an
  `error` event with message `aborted` while the cancelled tool unwound,
  which clients displayed as “⚠ aborted / 错误: aborted”. Both clients now
  swallow post-stop error events, keep the stop notice localized, mark
  in-flight tools as cancelled instead of done, and skip online reflection
  after cancellation so no extra model request is made.
- Verified with `ping -n 60`: stop ended the turn with “任务已被取消”, the
  tool card showed a stopped mark, no “aborted” error appeared, and no dialog
  appeared during 20 seconds of observation.

### Reply language

- The engine appends a transient, per-turn reminder to the latest user
  message: answer in the language of that message unless an explicit
  preference is configured. This is the same persistent-preference-with-
  default behavior used by mature coding assistants.
- The reminder fixes the drift where a Chinese request received an English
  answer because the system language directive was buried among tool
  instructions.
- Code, identifiers, paths, commands and quoted errors keep their original
  form. An explicit `zh`/`en` preference still wins.

### IDE danger-mode confirmation

- VS Code webviews are sandboxed iframes: `window.confirm()` is ignored and
  returns `false`. The YOLO and full-access toolbar buttons therefore did
  nothing in the IDE, and the catalog/media reset confirmations always
  cancelled.
- Destructive mode changes now use an in-page dialog with Cancel and
  “I understand, enable”. The toolbar and the settings-defaults handlers
  await the answer, then refresh the status bar so the active mode is visible.
- Regression coverage was added to CI.

### Engine selection

- Desktop and IDE rejects bundled engines whose `arm64`/`amd64`/`386`
  suffix does not match the host architecture and picks the newest matching
  engine instead of an older CLI from `PATH`.
- Restart any daemon started by an older build before using this one; a
  running process cannot be replaced in place.

### Factory installer

- `Factory-Setup-2.1.21.exe` bundles both `factory.exe` and `aruhan.exe`,
  the station-pack/pipeline/planner templates, and the web console. Factory
  drives Aruhan as its executor, so both binaries are required for a working
  install.
- Login autostart is an optional section and is **unchecked by default**.
  The installer does not start the service silently; the Start Menu/desktop
  shortcut runs `factory service start -open`, and selecting the optional
  section installs and starts the service at the end of setup.
- Linux/macOS tarballs contain both binaries, templates, the web console and
  `install.sh`.

### Verification

- IDE, real mouse and keyboard on VS Code 1.145.2: YOLO selected through the
  toolbar, danger dialog confirmed, status bar showed `yolo`; a Chinese prompt
  requiring Bash returned a Chinese answer with 117 CJK characters and zero
  approval dialogs; the Bash tool executed and returned the expected marker.
- IDE select-and-send race: switching to YOLO and sending within 150 ms still
  ran Bash with zero approval dialogs and returned the expected marker.
- IDE stop: `ping -n 60 127.0.0.1` was stopped after the stop button appeared;
  the UI showed “任务已被取消” with a stopped tool mark, no `aborted` error
  event reached the webview, zero approval dialogs appeared, and the
  transcript length stayed constant for 20 seconds.
- Desktop, real mouse and keyboard: YOLO high-risk file read, glob and Bash
  ran without dialogs; stop on `ping -n 60` reported
  `handleQueryStop matched=1 cancelled=1`; a fresh Chinese request returned
  Chinese prose.
- Regression suites: Go tests for the changed engine/permission/daemon
  packages, IDE `danger-confirm-webview`, inline diff/reasoning and
  `yolo-permissions-confirm` tests, extension lint and webview syntax check.
- Full artifact hashes: see `v2.1.21-SHA256SUMS.txt`.

### Upgrade notes

- Official v2.1.21 builds inject `ExpiresAt=2027-02-28`; local builds without
  `-Expires` are not time-limited.
- Windows binaries are unsigned; SmartScreen may warn. Signing instructions:
  [RELEASE-SIGNING](../operations/RELEASE-SIGNING.md).
- Close Desktop, a running daemon and any `factory serve` before replacing
  installed binaries. Reinstall the VSIX to pick up the new webview.

---

## 中文

v2.1.21 是基于源码重新全量构建的修正版。v2.1.20 的发布附件是在审批、
停止、回复语言和引擎选择修复之前构建的；本版把全部修复重新打进所有
安装包。配置与数据格式不变。

### YOLO 与审批档位

- 选择 YOLO（或 BYPASS）后不再逐工具弹出审批。此前权限评估器的
  高危分支无条件返回“询问”，即使处于 YOLO 模式，导致每条命令、每次
  读文件和列目录都弹窗。
- IDE 发送消息时会带上输入区当前档位。此前选完 YOLO 立即发送会与
  异步保存竞争，首个回合仍按旧的 default 档位执行；现在本回合一定使用
  界面显示的档位，宿主还会回发权威档位，保证执行档位与输入区一致。
- YOLO/BYPASS 下高危操作直接放行，但硬性风险仍然拒绝：灾难性删除、
  凭据外泄模式、受保护路径写入不能自动批准。
- 非交互调用仍然 fail-closed：无法获得答复的审批按拒绝处理，绝不静默放行。
- 拒绝/询问的原因会保留，被阻止的操作能说明原因。

### 停止会取消整个回合

- 桌面端停止在流 ID 已失配时回退到按任务取消，并取消该流下所有待审批
  请求；daemon 发出 `permission_cancelled`。
- IDE 停止携带 `stream_id` 调用 `abort`；daemon 取消该流及其待审批请求，
  webview 关闭已打开的审批弹窗。
- 桌面端与 IDE 在收到 `permission_cancelled` 后清理审批状态；点击停止后
  不会再持续弹窗。
- 用户主动停止不再被渲染成错误。引擎在取消工具收尾时会发出
  `error message="aborted"`，客户端此前显示为“⚠ aborted / 错误: aborted”。
  现在两端都会吞掉停止后的 error 事件，停止提示使用本地化文案，
  在飞工具标记为已取消而不是打勾，并且取消后不再触发在线反思，
  不会再多发一次模型请求。
- 用 `ping -n 60` 实测：停止后显示“任务已被取消”，工具卡显示停止标记，
  不再出现 aborted 错误，持续观察 20 秒没有审批弹窗，输出长度保持不变。

### 回复语言

- 引擎在每轮请求中向“最新一条用户消息”追加一次性的语言提醒：除非用户
  显式配置了语言，否则按这条消息的语言回答。这与成熟编程助手的“持久
  偏好 + 未设置时跟随用户”行为一致。
- 该提醒修复了中文需求返回英文的问题——原先语言指令被埋在大量工具说明中，
  模型容易忽略。
- 代码、标识符、路径、命令和引用的错误文本保持原样；显式 `zh`/`en`
  偏好仍然优先。

### IDE 危险档位确认

- VS Code webview 是 sandbox iframe，`window.confirm()` 会被忽略并直接
  返回 `false`。因此 IDE 中的 YOLO / 全电脑访问按钮此前点击无效，
  目录重置、媒体清理等确认也总是取消。
- 现在危险档位切换使用页面内对话框（取消 / 我已了解，仍要启用），
  工具栏与“新会话默认值”都会等待用户答复，并在切换后刷新状态栏，
  当前档位一眼可见。
- 已加入 CI 回归测试。

### 引擎选择

- 桌面端与 IDE 会拒绝架构后缀（`arm64`/`amd64`/`386`）与本机不一致的
  内置引擎，并选择最新的匹配引擎，而不是 PATH 中较旧的 CLI。
- 使用新版前请重启旧版本启动的 daemon；运行中的进程无法原地替换。

### Factory 安装包

- `Factory-Setup-2.1.21.exe` 同时包含 `factory.exe` 与 `aruhan.exe`、
  工位包/流水线/规划模板和 Web 控制台。Factory 通过 Aruhan 执行工位，
  两者缺一不可。
- 登录自启是可选组件，**默认不勾选**；安装程序不会静默启动服务。
  开始菜单/桌面快捷方式执行 `factory service start -open`；勾选可选组件时
  才会在安装结束时注册并启动服务。
- Linux/macOS tar.gz 同样包含两个二进制、模板、Web 控制台和 `install.sh`。

### 验证

- IDE（VS Code 1.145.2，真实鼠标/键盘）：通过工具栏开启 YOLO 并确认
  危险对话框，状态栏显示 `yolo`；中文需求实际调用 Bash，回答为中文
  （117 个汉字），审批弹窗 0 次，命令输出包含预期标记。
- IDE“选完立即发送”：切到 YOLO 后 150 毫秒内发送，Bash 仍然零审批执行，
  返回预期标记。
- IDE 停止：`ping -n 60 127.0.0.1` 运行中点击停止，界面显示“任务已被取消”
  与工具停止标记，webview 不再收到 `aborted` 错误，审批弹窗 0 次，
  随后 20 秒 transcript 长度保持不变。
- 桌面端（真实鼠标/键盘）：YOLO 下高危读文件、Glob、Bash 均无弹窗；
  停止 `ping -n 60` 记录 `handleQueryStop matched=1 cancelled=1`；
  新中文需求返回中文。
- 回归：相关 Go 引擎/权限/daemon 包测试、IDE `danger-confirm-webview`、
  inline diff/思考与 `yolo-permissions-confirm` 测试、扩展 lint 与
  webview 语法检查全部通过。
- 全量产物校验和见 `v2.1.21-SHA256SUMS.txt`。

### 升级说明

- 官方 v2.1.21 构建注入 `ExpiresAt=2027-02-28`；未传 `-Expires` 的本地构建
  不受时间限制。
- Windows 二进制未签名，SmartScreen 可能提示；签名流程见
  [RELEASE-SIGNING](../operations/RELEASE-SIGNING.md)。
- 替换已安装二进制前请关闭桌面端、daemon 与 `factory serve`；IDE 需重新
  安装 VSIX 以加载新的 webview。
