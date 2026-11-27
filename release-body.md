# Aruhan v2.1.33

**Release date / 发布日期：2026-11-27** · [CN checksums / 国内版校验和](https://gitee.com/guleng2005/Aruhan-AI/releases/download/v2.1.33/SHA256SUMS) · 中文（文末点击展开 / collapsed at the end）

**⬇ [立即下载 / Download now](https://github.com/xizhihao1/Aruhan-AI/releases)** —
[Windows](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/Aruhan-Setup-2.1.33-cn.exe) · [macOS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-desktop-darwin-amd64-cn) · [Linux](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-linux-amd64-2.1.33-cn.tar.gz) ·
[全部资产 / all assets](https://github.com/xizhihao1/Aruhan-AI/releases)

## Download / 下载

| Platform | Package | Download |
|---|---|---|
| Windows | Bundle: CLI + desktop + Factory | [Aruhan bundle installer](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/Aruhan-Setup-2.1.33-cn.exe) |
| Windows | Separate installers | [CLI](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/Aruhan-CLI-Setup-2.1.33-cn.exe) · [Desktop](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/Aruhan-Desktop-Setup-2.1.33-cn.exe) · [Factory](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/Factory-Setup-2.1.33-cn.exe) |
| Windows | Portable ZIP | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-windows-amd64-2.1.33-cn.zip) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-windows-arm64-2.1.33-cn.zip) |
| Windows arm64 | TUI installer | [amd64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-tui-installer-windows-amd64-cn.exe) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-tui-installer-windows-arm64-cn.exe) |
| macOS | Desktop app | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-desktop-darwin-amd64-cn) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-desktop-darwin-arm64-cn) |
| macOS | CLI/TUI tarball | [Intel](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-darwin-amd64-2.1.33-cn.tar.gz) · [Apple Silicon](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-darwin-arm64-2.1.33-cn.tar.gz) |
| Linux | Desktop app | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-desktop-linux-amd64-cn) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-desktop-linux-arm64-cn) |
| Linux | CLI/TUI/Factory tarball | [x64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-linux-amd64-2.1.33-cn.tar.gz) · [arm64](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-linux-arm64-2.1.33-cn.tar.gz) |
| VS Code | Extension | [VSIX](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/aruhan-vscode-cn.vsix) |
| All | Integrity | [SHA256SUMS](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.33/SHA256SUMS) |

Installation, upgrade, PATH, Gatekeeper and SmartScreen notes are in
[INSTALL.md](INSTALL.md); the full asset list is at the bottom of this page.

---

## English

Aruhan is a local-first AI engineering workspace: one engine behind a CLI,
terminal UI, desktop app, VS Code extension, and the Factory control plane. It
reads the repository, edits code, runs commands and tests, reviews the diff,
and carries work through gated delivery pipelines — with your own API key and
no publisher-hosted backend.

v2.1.33 fixes the local CLI/TUI project root on top of 2.1.32: running
`aruhan`, `aruhan chat`, `aruhan query` or pipe mode inside a git repository
now sets `ProjectRoot`, so TaskLedger no longer fails with "当前会话不在项目内".
It also makes runtime settings take effect across clients: desktop and VS Code
reload `desktop.json`/`vscode.json` changes without restarting, and switching a
workspace rebuilds the code index. It also applies permission, work-mode,
model, effort and sampling changes to the in-flight stream at the next
decision point, and adds image/PDF reading, structured questions and typed
review reports. The release includes the 2.1.32 desktop task-deletion fixes and
all 2.1.31/2.1.30 installer, catalog and client fixes.

### Local CLI/TUI project root

- Only the `--plain` REPL passed through the startup banner that sets
  `ProjectRoot`. The default full-screen TUI, `aruhan query`, and pipe mode did
  not, so `TaskLedger` rejected every call even when launched inside a git
  repository; the model kept retrying because the system prompt requires the
  ledger.
- `initializeSubsystems()` now wires the same project-root/reference resolvers
  for every non-daemon local entry point, quietly (no banner printed before the
  TUI alternate screen). Daemon mode still derives its root from the active
  workspace.
- The local session root now follows the launch directory like a normal
  developer tool: Git top-level when inside a repository, otherwise the absolute
  cwd. A plain directory outside Git therefore still has a working TaskLedger
  and completion gate. Home, system directories, filesystem roots and an
  unusable cwd are rejected so `.aruhan` state is never written into `~/.aruhan`
  (the legacy config location) or a system folder; those sessions fall back to
  the "ledger unavailable" prompt with the stop gate disabled.
- Local CLI/TUI roots take precedence over a desktop's global active workspace
  (`E:\test` no longer leaks into a TUI launched from another repository);
  daemon/desktop still follow the active workspace.
- Regression tests cover the real initialization in Git and non-Git
  directories, the local-vs-active-workspace priority, the quiet wiring helper,
  the availability-dependent prompt contract, and `SetLedgerDir` toggling it.

### Non-interactive tool permissions

- `aruhan query`, pipe mode, interactive `aruhan`/`aruhan --plain`, and
  `aruhan chat` accept `--permission-mode <default|auto|acceptEdits|yolo>`.
  The mode applies only to that run and is not persisted; without it, a non-TTY
  run still auto-denies approval prompts.
- Prompt mandates now follow the enabled tool set: if codemapper,
  DeliverableImpact, TodoWrite, WrapUp, AskUser, Agent, Glob/Grep or the shell
  tool is unavailable, the system prompt stops requiring it and states the
  degraded path instead of sending the model into a retry loop. The static
  prompt cache is invalidated when the tool set changes, so a cached prompt
  cannot keep advertising a tool that was later disabled.
- Real end-to-end check: `aruhan query --permission-mode yolo` in a Git working
  directory ran TaskLedger add → Bash verify → TaskLedger close → WrapUp and
  returned `TASKLEDGER_OK`; the ledger was created under the working directory.

### Approval options and cross-surface roots

- TUI and plain-terminal "allow for this session" now grants that tool in
  memory for the session and is cleared on session switch. It previously only
  switched to `auto`, which still prompts for explicit-ask/unknown tools.
- "Always allow" now persists only that tool's rule; it no longer changes the
  global permission mode to `auto` as a side effect.
- Hard-risk tools no longer show "always allow" in desktop and VS Code: the
  server refuses to persist those rules, so the button silently degraded to a
  one-time grant. TUI/terminal already hid it.
- ACP workers (`aruhan acp`, used by Factory/dsh) are excluded from the local
  CLI/TUI launch-directory root. They keep the orchestrator/active-workspace
  root, so this change does not point Factory stations or IDE workers at the
  install directory. Daemon/desktop behavior is unchanged.

### Concurrent debate stability

- Fixed a prompt-builder deadlock that could hang a three-party debate: while
  one goroutine rendered the dynamic prompt sections under the read lock, it
  re-acquired the same read lock; once another role queued for the write lock
  (`SetMcpInstructions`), the writer-preferring RWMutex blocked both forever.
  The locked render path now uses a lock-free tool-availability helper, and a
  regression test holds the outer read lock with a queued writer. Repeated
  stress runs of the concurrent session/debate combinations pass.

### Deleted tasks stay deleted

- Desktop chat creates a local task (`task-<timestamp>`) plus a daemon task
  (`task-<hex>`) linked by `daemonTaskId`. Deletion used to call `task.delete`
  with the local id, leaving the daemon task in `tasks.json`; the next start's
  `task.list` sync then re-added it as an empty task named after the first
  prompt (for example "你是谁").
- Deletion now targets `daemonTaskId` when present, tombstones both ids so a
  failed daemon delete cannot resurrect the task, cleans up a `task.create`
  response that arrives after the user deleted the local task, and unmarks both
  ids when restoring from Trash.
- Deleting the last task (or a non-active task while `activeTaskId` was empty or
  stale) used to leave the persisted message mirror untouched. The next start
  cleared the task list and active id, then rendered those orphan messages in an
  empty task list; the ChatView daemon-session fallback could restore the
  deleted conversation the same way. Messages and the active-task key are now
  cleared whenever the active task no longer exists, persisted messages are
  ignored when no task/active task remains, and the daemon fallback is skipped
  when the task list is empty.
- VS Code already used the daemon task id and is unaffected; CLI/TUI have no
  workspace task list. Regression tests cover the `task.list` sync path and the
  empty-list orphan-message case.

### Model catalog v18

- **Doubao (Volcengine Ark).** Added the official `doubao-seed-2-1-pro-260915`
  and turbo variants and updated the default; corrected models that had been
  marked retired while still available.
- Retired-model entries are now scoped per provider, so one provider's
  retirement no longer hides a same-named model at another provider.
- `models.json` catalog version 17 → 18; existing user catalogs upgrade
  automatically on first use.
- GLM-5.4 is intentionally not added yet: the model was announced but its API
  is not open. It will be added once the official API is available.
- The billing pricing table now covers every catalog model in the default, CN
  and INTL catalogs. New Doubao 2.1 Pro/Turbo and
  local/alias IDs are marked `unknown` where official pricing is not tracked,
  so cost display degrades honestly instead of the catalog check failing.
- Catalogs are refreshed across CN and INTL; edition filtering is unchanged.

### One data directory on every install path

- **Cause.** The Windows combined installer set
  `ARUHAN_DATA_DIR=%LOCALAPPDATA%\Aruhan\data`, while the CLI and desktop
  packages and the script installers used the application default
  `%APPDATA%\Aruhan`. On macOS/Linux, the pkg and TUI installers pointed data at
  `<prefix>/data`, which is often root-owned and not writable by the user. The
  same machine could therefore hold two data directories, and switching
  packages looked like lost credentials.
- **Fix.** Installers no longer set `ARUHAN_DATA_DIR` or the legacy
  `ARUHAN_CONFIG_DIR`. `paths.AppDataDir()` is the single authority on every
  surface: `%APPDATA%\Aruhan` on Windows, `~/Library/Application Support/Aruhan`
  on macOS, `~/.config/Aruhan` on Linux. Explicit `ARUHAN_HOME` /
  `ARUHAN_DATA_DIR` values still win.
- **Automatic adoption.** On the first start after upgrading, missing user state
  is copied from a legacy installer directory (`%LOCALAPPDATA%\Aruhan\data`,
  `/usr/local/aruhan/data`, `~/.local/aruhan/data`,
  `~/.local/share/aruhan/data`, `/opt/aruhan/data`): keys/catalogs, permissions,
  rules, sessions, memory, skills, teams, credentials and queues. Existing files
  in the new location are never overwritten. A marker prevents short CLI
  invocations from rescanning large trees.
- **Uninstall.** Installers remove programs and PATH entries; user data is
  preserved by default. The Windows prompts name the current directory and any
  legacy installer directory, and only delete them when the user explicitly
  chooses a full cleanup. macOS/Linux pkg, unix and TUI uninstallers keep user
  data. The macOS pkg now actually ships the `uninstall.sh` its README
  referenced, and the uninstallers no longer remove an explicit user
  `ARUHAN_DATA_DIR`.
- **Upgrade note.** If you use the combined Windows installer, installing
  2.1.33 clears the old installer default from `ARUHAN_DATA_DIR`; the first
  launch copies the old data automatically. Running 2.1.28 and 2.1.33 side by
  side against different directories is not supported.

### Portable desktop engine selection

- A portable desktop now prefers the same-edition engine binary shipped next to
  it before falling back to development `build/` intermediates. Previously a
  CN portable desktop could pick up an INTL `aruhan` left in `build/` and the
  daemon rejected the CN provider as unavailable. The same fix covers Linux
  and macOS headless desktops.
- Sibling-engine discovery also enforces the current CPU architecture. Release
  directories ship both amd64 and arm64 engines; without this guard a newer
  arm64 file could be selected on amd64 (and vice versa), making the daemon
  fork fail and the desktop silently fall back to standalone mode.

### Environment-provider parity in the UI

- When `ARUHAN_API_KEY` / `ARUHAN_PROVIDER` are set, desktop, VS Code and TUI
  now show that provider as configured and selected instead of "not
  configured": the daemon's `model.list` / `provider.list` include env-only
  providers (still edition-filtered), desktop settings and model selection use
  the env provider/model, VS Code resolves it for the active provider and model
  list, and the TUI marks it as current.
- If `ARUHAN_PROVIDER` is set without `ARUHAN_MODEL` (or the model does not
  belong to that provider), the TUI banner/status, `/provider`, `/model` and
  desktop `currentModel` display the provider catalog default instead of
  "unknown". Only the display changes; request routing keeps the engine's
  existing fallback.

### Runtime settings hot reload

- `config.changed` now carries the config version, data directory and
  `changed_keys`; the daemon logs the loaded path and changed keys, and the
  version-layer `desktop.json` / `vscode.json` files are watched as well.
- Desktop subscribes to `config.changed` and `workspace.changed`, reloads its
  config store and refreshes the workspace list without restarting. Theme,
  permission-mode and provider changes apply while the window stays open.
- Switching the active workspace rebuilds the code index: the previous mapper is
  unregistered, client hints are replaced instead of appended, and construction
  is idempotent and bound to the new root.
- A config apply-timing matrix test fails when a serializable settings field is
  added without declaring when it takes effect, so new settings cannot silently
  skip hot-reload semantics.

### In-flight policy, model and sampling changes

- `policy.update` applies permission, file-access and work-mode changes to the
  active task/session stream without restarting it. Scopes are `stream`, `task`
  and `session`; YOLO/full-access still require explicit confirmation; changes
  are written to the config audit log and broadcast as `config.changed`.
- The timing moved from "next turn" to "next decision point": the next tool
  call in the same turn already uses the new permission/sandbox/work mode.
  Pending approvals are not auto-approved; desktop and VS Code add an
  "allow this call and switch to YOLO" action for normal-risk calls, while
  high-risk calls keep a one-time grant.
- Work mode is read back from the per-client version files, so plan mode
  survives a restart. Per-session agents receive `tool_timeouts` and the hook
  manager, and `/config set` writes the layer of the client that started the
  daemon instead of always `terminal.json`.
- Changing model, provider, reasoning effort, max tokens or temperature now
  applies to the next LLM request in the same turn; switching providers builds
  the matching provider instance. A new turn is no longer required.
- Global defaults inherit into running tasks unless the client pinned a field:
  desktop task snapshots and VS Code sessions send explicit pins, so unpinned
  fields follow `config.save`/hot reload while pinned fields stay task-local.
  Sub-agents inherit the parent turn's max tokens, temperature and effort.
  The daemon exposes a settings revision that increments on every successful
  save or config hot reload; the desktop settings header shows it as a badge
  and VS Code reports `config.changed` in the status bar.

### Multimodal reading, structured questions and review reports

- `FileRead` returns PNG/JPEG/GIF/BMP/TIFF/WebP images as a vision attachment
  after downscaling (longest side 2048 px, 2 MiB payload) plus a small preview
  thumbnail; PDFs are returned as page-delimited text, and scanned PDFs report
  that no text was extractable. Images are charged a fixed token budget, at
  most three recent images stay in context, and catalogs may mark a model as
  text-only so the engine keeps the image out of the request and points the
  model at OCR instead.
- `AskUser` accepts per-option descriptions/previews, a recommended option,
  multi-select and optional free text. Desktop renders a question card, VS Code
  uses native pickers, and TUI/CLI offer numbered selection; answers return to
  the model as the tool result instead of a placeholder.
- `ReviewReport` records typed findings (file/line, severity, category and a
  concrete failure scenario) and renders a text summary in generic tool cards;
  the static `CodeReview` checks remain available.
- Local outbound policy is now configurable in the desktop Settings page
  (**Outbound policy**), the VS Code permission panel, and the CLI/TUI
  `/egress` command. Mode (`off`/`ask`/`allowlist`), host allowlist, PLC/OT
  allowlist, private/metadata blocking and loopback re-allow are stored in the
  client's version file and applied at the next tool decision. `ask` reuses the
  normal permission dialog; `allowlist` denies unknown hosts without prompting.
  `ARUHAN_EGRESS_MODE`/`_ALLOW`/`_OT_ALLOW`/`_DENY_PRIVATE`/`_ALLOW_LOOPBACK`
  still take precedence for deployments.

### Local plugin packages, MCP skills and richer tool cards

- `.aruhan-plugin` local packages: one ZIP carries `plugin.json` (name, exact
  version, type, command, declared permissions) plus the implementation files.
  `plugin.inspect` shows the manifest and permissions before anything runs;
  `plugin.install` accepts a `path` and installs atomically. Extraction reuses
  the registry-artifact defenses (zip-slip, entry count, per-entry and total
  size limits), names are validated before they become directories, and a
  failed load removes the tree and leaves no persisted record.
- A package may bundle an executable (resolved to an absolute path and
  requiring an `exec` permission) or run a bundled script through
  node/python/python3 with the plugin directory as cwd. Disable/enable and
  daemon restart restore local packages from `plugin.json`, and `plugin.list`
  now includes them alongside registry plugins. Desktop's Plugins page adds a
  browse → inspect → permission preview → install flow, and the CLI/TUI expose
  the same steps as `/plugin inspect` and `/plugin install`.
- Tool-type packages are exposed to the agent as `plugin.<name>` (or the
  `tool.name` declared in the manifest) with the manifest's input schema,
  forwarded to the plugin's one-shot stdin/stdout JSON contract. Registering or
  removing a plugin tool rebuilds the action registry, so it is usable without
  a daemon restart; MCP servers were already dynamic through the MCP action.
  The package contract is documented in `docs/plugin-packages.md`.
- `aruhan mcp-serve` exposes installed file-based skills as read-only MCP
  prompts named `skill.<name>`; prompts return the skill's instruction body and
  never execute tools. Built-in skills without a prompt body are omitted.
- A bundled `structured-review` skill provides a production review protocol
  (read the change, severity/category rules, mandatory concrete failure
  scenario, de-duplication) and points the model at `ReviewReport`.
- Desktop and VS Code tool cards render FileRead image thumbnails and
  `ReviewReport` findings (severity, category, file:line, failure scenario,
  suggestion, checked/not-checked). The full image payload remains vision-only
  in the daemon; clients only receive the bounded thumbnail.

### 2.1.28 features included

- Background-agent completion events carry `task_id`/`session_id`; desktop adds
  a **Continue** action and a per-task opt-in **auto-continue** chip (off by
  default, visible+idle, five-streak cap).
- `skill install` accepts local paths, `https://` archives, and
  `owner/repo[@ref][/subdir]` sources with a 64 MiB / 2 min cap and an SSRF
  guard; enterprise private hosts require `ARUHAN_SKILL_ALLOW_PRIVATE=1`.
- Typed slash commands in desktop and VS Code follow CLI routing, including
  `/computer <task>` and aliases.
- Windows screenshots use `CreateDIBSection`; ComputerUse has a configurable
  step budget (default 20, hard cap 50) and live `tool_progress` lines.
- Desktop and VS Code use command-run parity; old automation views fall back to
  chat.

### Verification

- Release gate: CN and INTL matrices from the same source SHA, 59 artifacts
  each, `SHA256SUMS` 57/57, `EDITION.txt` version 2.1.33.
- `check-edition-binary.mjs` reports no other-edition tokens in CN or INTL CLI,
  desktop and Factory binaries.
- Catalog hot-refresh browser E2E on both release builds; catalog v18 provider
  tests pass for CN and INTL, including scoped retired entries and the 17→18
  upgrade path.
- Real-window desktop check with env-only DeepSeek config and no
  `ARUHAN_MODEL`: Settings → Models showed **DeepSeek 已配置** and
  **DeepSeek V4.1 Flash**; `/api/models` returned
  `activeProvider=deepseek`, `currentModel=deepseek-flash`. With a newer INTL
  engine planted in `build/`, the product desktop selected the CN amd64 sibling
  and the daemon stayed connected (no standalone fallback).
- Installer checks: all three Windows NSIS scripts compile with NSIS 3.13; the
  macOS pkg postinstall/uninstall and unix scripts pass `bash -n`; `install.ps1`
  parses cleanly.
- Full gate on the merged hot-reload tree: `scripts/ci.sh --full` passed;
  `go test ./...` 872s, desktop frontend 63/63 files and 338/338 tests.
- In-flight policy: permission/sandbox/work-mode changes apply to the next tool
  call, and model/provider/effort/max-tokens/temperature changes apply to the
  next LLM request; pending approvals stay pending. Covered by clean-environment
  permission, engine, config, query and daemon tests.
- Multimodal and questions: FileRead image/PDF tests, AskUser round-trip tests
  (engine, daemon, desktop, VS Code), ReviewReport validation tests; desktop
  `tsc`, `npm run build` and the AskUser card vitest suite pass; the VS Code
  extension compiles; i18n and brand gates pass.
- Plugin packages, MCP prompts and structured review: plugin tests cover atomic
  install, zip-slip, script escape, exec-permission enforcement, overwrite
  refusal, inspect-without-install, restore/enable from `plugin.json`,
  auto-registration of the agent tool bridge, manifest tool schemas, disabled
  package listing and the bounded output writer; MCP skill-prompt list/get and
  filtering tests pass; the structured-review protocol test passes; the desktop
  suite is 65 files / 348 tests and the VS Code extension builds with a
  syntax-checked webview bundle.
- Outbound policy: tests prove a config change is observed by the next policy
  evaluation, environment mode wins over persisted mode, and environment
  allowlists/private-network denial stay additive. Desktop and VS Code expose
  the same fields and persist them through the client version file. A real CLI
  run with `allowlist = api.example.com` denied `https://evil.example/x` with
  "host is not in egress allowlist".
- Settings revision: a daemon unit test asserts the revision increments after a
  successful `config.save` and after a config hot reload; desktop tsc and VS
  Code build pass with the revision badge/status-bar wiring.
- Linux headless (WSL Ubuntu + real Chromium, real clicks): the settings page
  showed **Config revision #1**; clicking the dark theme triggered a save and
  the badge changed to **#2** without JS errors, confirming the
  save → daemon apply → `config.changed` → UI refresh loop.
- Real-input pass on Windows (mouse/keyboard, screenshots): in the TUI,
  `/egress` showed `off`, then mode/allow/deny changes were written to
  `terminal.json`; `/plugin inspect` and `/plugin install` succeeded;
  `/plugin load` exposed `plugin.echo` and a scripted call returned
  `plugin-ok` in the same session; the AskUser selector navigated with the
  arrow keys and answered with Enter.
- Real-input pass on the Windows desktop (mouse/keyboard, screenshots):
  the apply-timing legend and the **Config revision** badge were visible and
  advanced from `#1` to `#2` after a save; the Outbound policy form persisted
  `allowlist` + `api.example.com` + private-network blocking to `desktop.json`;
  a local package was inspected and installed from the Plugins page; the model
  called `plugin.echo` and received `{"echo":"plugin-ok","ok":true}`; the
  AskUser card was answered; the ReviewReport findings card and FileRead image
  thumbnail rendered, with the raw data-URL no longer printed. A FileRead
  permission prompt was approved through the normal dialog.
- Real-window hot-reload check: editing the isolated `desktop.json` changed the
  desktop theme from light to dark within four seconds without restarting the
  window; daemon and frontend logs both reported the changed keys.
- Real-window permission screen test with a local mock provider (no paid model
  call): the high-risk approval dialog hid "always allow"; "allow once" ran the
  high-risk command and the result returned to the desktop conversation. PTY
  tests also verify the TUI high-risk options (allow once/deny only) and that a
  non-Git local TUI project root is the process cwd, not the data directory.
- New tests: legacy installer data adoption (first useful candidate, missing
  files only, user-state merge), platform legacy paths, portable sibling engine
  resolution including CPU architecture, and env-provider selection
  applicability.
- Trial-state test on the release binary: `trial.json` is stored as
  `enc:v1:...`; deleting it while the anchor remains exits 1 with the short
  missing-state message; an expired legacy date exits 1 with the short
  contact message.
- Checksums: [CN](v2.1.33-SHA256SUMS.txt),
  [INTL](v2.1.33-SHA256SUMS-intl.txt). Windows binaries remain unsigned.
- GitHub carries the complete CN and INTL asset sets; the Gitee mirror carries
  the CN installers, portable archives, VSIX, Windows TUI installers, and
  Linux/macOS desktop binaries (repo-wide 1 GB attachment quota; bare CLI
  binaries remain on GitHub).

### Commercial use and legal notice

Official release builds include a 30-day evaluation period from the first run.
The first-run date is encrypted with a machine-bound key and anchored; deleting
`trial.json` alone blocks startup. Continued use after the evaluation period,
commercial use, private/on-premises deployment, custom development, and
source-code or perpetual buyout require a separate written license:
**37735973@qq.com**. Aruhan is provided
**AS IS**, without warranty; to the maximum extent permitted by law the authors
are not liable for AI output, tool execution, data loss, or other outcomes.
Review every change, keep backups, use least-privilege permissions, and do not
use Aruhan in high-risk environments without independent validation. Reverse
engineering, bypassing licensing or tenant isolation, and resale or
redistribution without written permission are prohibited. The release README
and `DISCLAIMER.md` carry the full notice.

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart daemons started by an older build.
- No manual configuration or data migration is required; the first launch
  adopts legacy installer data automatically.

---

<details>
<summary><strong>中文 / Chinese — 点击展开 / click to expand</strong></summary>

## 中文

Aruhan 是本地优先的 AI 工程工作台：同一套引擎驱动 CLI、终端 TUI、桌面端、
VS Code 插件和 Factory 控制面。它会阅读仓库、修改代码、执行命令与测试、
审查差异，并让工作经过带门禁的交付流水线；使用你自己的 API Key，没有发布者
托管的后端。

v2.1.33 在 2.1.32 基础上修复本地 CLI/TUI 项目根：在 git 仓库内运行
`aruhan`、`aruhan chat`、`aruhan query` 或 pipe 模式都会设置 `ProjectRoot`，
TaskLedger 不再报“当前会话不在项目内”。本版同时让运行时设置在各端即时生效：
桌面与 VS Code 无需重启即可接收 `desktop.json` / `vscode.json` 变更，切换
工作区会重建代码索引。本版还会把权限、工作模式、模型、档位与采样参数的变更
应用到在飞流的下一次决策点，并新增图片/PDF 读取、结构化提问与结构化 review
报告。本版包含 2.1.32 的桌面任务删除修复，以及 2.1.31/2.1.30 的安装器、
模型目录与各端修复。

### 本地 CLI/TUI 项目根

- 原先只有 `--plain` REPL 会经过启动 banner 并设置 `ProjectRoot`；默认全屏
  TUI、`aruhan query` 与 pipe 模式都没有设置，导致在 git 仓库内运行时
  TaskLedger 仍拒绝调用，而系统提示又要求模型使用账本，形成反复失败。
- `initializeSubsystems()` 现在为所有**非 daemon 本地入口**静默注入同一套
  项目根/引用解析器（进入 TUI 备用屏幕前不打印 banner）；daemon 仍由 active
  workspace 决定根目录。
- 本地会话根改为跟随启动目录：在 Git 仓库内取仓库顶层，否则就是绝对 cwd。
  因此非 Git 的普通目录仍有可用的 TaskLedger 与完成度闸门。用户主目录、系统
  目录、文件系统根和不可用 cwd 会被拒绝，避免把 `.aruhan` 写进 `~/.aruhan`
  （旧版配置位置）或系统目录；这些会话降级为“账本不可用”，并同步停用收尾
  闸门。
- 本地 CLI/TUI 的会话根优先于桌面留下的全局 active workspace（在另一个仓库
  启动 TUI 不会再被 `E:\test` 污染）；daemon/桌面仍以 active workspace 为准。
- 新增回归测试：Git 与非 Git 目录的真实初始化、本地根 vs active workspace
  优先级、静默注入、按可用性切换提示契约、以及 `SetLedgerDir` 开关行为。

### 非交互工具权限

- `aruhan query`、pipe 模式、交互式 `aruhan`/`aruhan --plain` 与
  `aruhan chat` 均支持 `--permission-mode <default|auto|acceptEdits|yolo>`，
  只对本次运行生效、不写入配置；不指定时，非 TTY 环境仍会拒绝审批。
- 提示词强制项改为跟随实际启用的工具：codemapper、DeliverableImpact、
  TodoWrite、WrapUp、AskUser、Agent、Glob/Grep 或 shell 工具不可用时不再
  要求模型调用，而是给出降级说明，避免反复调用必然失败的工具。工具集变化时
  会清空静态提示缓存，避免缓存继续宣传已禁用的工具。
- 真实端到端验证：在 Git 工作目录执行
  `aruhan query --permission-mode yolo`，依次完成 TaskLedger add → Bash 验证
  → TaskLedger close → WrapUp，并返回 `TASKLEDGER_OK`；账本确实落在工作目录。

### 审批选项与跨端会话根

- TUI 与纯终端提示的“本次会话允许”现在会真正在内存中放行该工具，切换/新建
  会话时清除；旧实现只切到 auto，对显式 ask/未知工具仍会再次弹窗。
- “始终允许”现在只持久化该工具的规则，不再顺带把全局权限模式改成 auto。
- 桌面端与 VS Code 对高危工具不再显示“始终允许”：服务端本来就拒绝持久化
  这类规则，按钮会把“始终”静默降级为“仅本次”。TUI/终端原本已隐藏。
- ACP worker（`aruhan acp`，Factory/dsh 使用）不再套用本地 CLI/TUI 的启动
  目录根，继续使用编排器/active workspace 根，避免把 Factory 工位或 IDE
  worker 指到安装目录；daemon/桌面行为不变。

### 并发辩论稳定性

- 修复提示词构建器的死锁：一个 goroutine 持读锁渲染动态段时再次申请同一读锁；
  一旦另一个角色排队申请写锁（`SetMcpInstructions`），写者优先的 RWMutex
  会让双方永久互等，整轮三方辩论卡死。持锁渲染路径改用无锁的工具可用性
  查询，并新增“外层读锁 + 排队写者”回归测试；并发会话/辩论组合的压力测试
  重复运行均通过。

### 删除的任务不再复活

- 桌面聊天会创建本地任务（`task-<时间戳>`）与 daemon 任务（`task-<hex>`），
  通过 `daemonTaskId` 关联。旧删除逻辑传的是本地 id，daemon 任务留在
  `tasks.json`；重启时 `task.list` 同步把它加回列表，形成以首次提问命名的
  空白任务（例如“你是谁”）。
- 现在删除优先使用 `daemonTaskId`，并给两个 id 都登记持久化墓碑，daemon
  删除失败也不会复活；用户删除本地任务后迟到的 `task.create` 响应会立即
  清理；从回收站恢复时解除两个 id 的墓碑。
- 删除最后一个任务（或删除非活动任务时 `activeTaskId` 已为空/失效）过去不会
  清理持久化的消息镜像；重启后任务列表和 active id 都被清空，但聊天窗口仍
  渲染这些孤儿消息，ChatView 的 daemon 会话兜底还可能把已删对话恢复出来。
  现在只要活动任务不再存在，就同时清空消息与 active-task 键；无任务/无活动
  任务时忽略持久化消息，任务列表为空时跳过 daemon 会话兜底。
- VS Code 原本就用 daemon 任务 id，不受影响；CLI/TUI 没有工作区任务列表。
  新增回归测试覆盖 `task.list` 同步与“空列表孤儿消息”两种路径。

### 模型目录 v18

- **豆包（火山方舟）。** 加入官方 `doubao-seed-2-1-pro-260915` 与 turbo 变体
  并更新默认项；纠正仍在提供却被误标退役的模型。
- 退役表改为按供应商作用域，某个供应商的退役记录不再误伤其他供应商的同名模型。
- `models.json` 目录版本 17 → 18；用户已有的旧目录在首次使用时自动升级。
- GLM-5.4 暂不加入：官方已发布但 API 未开放，待 API 可用后再补。
- 计费价格表补齐默认、CN、INTL 三份目录中的全部模型；新增的豆包 2.1
  Pro/Turbo 以及本地/别名 ID 在官方价格未跟踪时标记
  `unknown`，费用显示如实降级，不再让目录完整性检查失败。
- CN/INTL 两版目录同步刷新，发行版过滤逻辑不变。

### 各安装方式统一到一个数据目录

- **原因。** Windows 整合包把 `ARUHAN_DATA_DIR` 指向
  `%LOCALAPPDATA%\Aruhan\data`，而 CLI/桌面安装包与脚本安装走应用默认的
  `%APPDATA%\Aruhan`。macOS/Linux 的 pkg 与 TUI 安装器又把数据放在
  `<prefix>/data`，该目录常为 root 所有，普通用户不可写。同一台机器因此可能
  出现两套数据目录，切换安装包就像凭据丢失。
- **修复。** 安装器不再设置 `ARUHAN_DATA_DIR` 与遗留的 `ARUHAN_CONFIG_DIR`。
  数据位置只由 `paths.AppDataDir()` 决定：Windows 为 `%APPDATA%\Aruhan`，
  macOS 为 `~/Library/Application Support/Aruhan`，Linux 为
  `~/.config/Aruhan`。显式设置的 `ARUHAN_HOME` / `ARUHAN_DATA_DIR` 仍然优先。
- **自动接管旧数据。** 升级后首次启动时，从旧安装器目录
  （`%LOCALAPPDATA%\Aruhan\data`、`/usr/local/aruhan/data`、
  `~/.local/aruhan/data`、`~/.local/share/aruhan/data`、`/opt/aruhan/data`）
  复制缺失的用户状态：密钥/目录、权限、规则、会话、记忆、技能、团队、凭据与
  队列。新位置已有文件绝不覆盖。写入标记文件，避免每次短命令都扫描大目录。
- **卸载。** 安装器只删除程序与 PATH 配置，默认保留用户数据。Windows 卸载
  提示同时列出当前目录与旧安装器目录，只有用户明确选择彻底清理时才删除；
  macOS/Linux 的 pkg、unix 与 TUI 卸载器始终保留数据。macOS pkg 现在真正随包
  安装 README 中引用的 `uninstall.sh`，且各卸载器不再删除用户显式设置的
  `ARUHAN_DATA_DIR`。
- **升级说明。** 使用 Windows 整合包的用户安装 2.1.33 时会清除旧安装器写入的
  默认变量，首次启动自动复制旧数据。不支持 2.1.28 与 2.1.33 并行使用不同目录。

### 便携桌面引擎选择

- 便携桌面现在优先使用同目录随包部署的**同发行版**引擎，再回退到开发用的
  `build/` 中间产物。此前 CN 便携桌面可能选中 `build/` 中残留的 INTL
  `aruhan`，daemon 因而报 CN 供应商在国际版不可用。Linux/macOS headless
  桌面同样修复。
- 同级引擎探测同时校验 CPU 架构：发布目录会同时放 amd64/arm64 引擎，若不校验，
  amd64 机器可能选中更新的 arm64 文件（反之亦然），daemon fork 失败后桌面会
  静默降级为 standalone。

### 运行时设置热生效

- `config.changed` 现在携带配置版本、数据目录与 `changed_keys`；daemon 日志
  记录实际加载路径与变更键，并同时监听版本层 `desktop.json` / `vscode.json`。
- 桌面订阅 `config.changed` 与 `workspace.changed`，不重启窗口即可重新加载
  配置 store 并刷新工作区列表；主题、权限模式与供应商变更即时生效。
- 切换活动工作区会重建代码索引：注销旧 mapper、替换而不是追加客户端提示，
  构建过程幂等并绑定新根目录。
- 新增配置生效时机矩阵测试：新增可序列化设置字段若未声明生效时机，测试直接
  失败，防止新设置悄悄绕过热生效语义。

### 运行中的策略、模型与采样变更

- `policy.update` 把权限、文件访问范围与工作模式的变更应用到该任务/会话的
  在飞流，无需重启。作用域为 `stream` / `task` / `session`；YOLO/full-access
  仍需显式确认；变更写入配置审计日志并广播 `config.changed`。
- 生效时机从“下一轮”提前到“下一次决策点”：同一轮的下一次工具调用就使用新的
  权限/沙箱/工作模式。已挂起的审批不会自动放行；桌面与 VS Code 在普通风险
  调用上增加“允许本次并切换 YOLO”，高危调用仍只允许一次。
- 工作模式会从各端版本文件读回，计划模式重启后不再丢失；per-session agent
  会收到 `tool_timeouts` 与 HookManager；`/config set` 写入启动 daemon 的
  客户端对应层，而不是一律写 `terminal.json`。
- 模型、供应商、思考档位、max tokens 与 temperature 的运行中变更现在会对
  同一轮的下一次 LLM 请求生效；切换供应商会构造对应实例，不再要求新开一轮。
- 全局默认值会继承到运行中的任务，除非客户端显式 pin：桌面任务快照与 VS Code
  会话会携带 pin，未 pin 字段跟随 `config.save`/热重载，pin 字段保持任务本地。
  子代理继承父轮次的 max tokens、temperature 与思考档位。daemon 提供设置修订号，
  每次保存成功或配置热重载递增；桌面设置页头部以角标显示，VS Code 在状态栏
  提示 `config.changed`。

### 多模态读取、结构化提问与 review 报告

- `FileRead` 会把 PNG/JPEG/GIF/BMP/TIFF/WebP 图片缩放后作为视觉附件返回
  （最长边 2048px、2MiB 上限），并附带一张小预览图；PDF 按页返回文本，扫描件
  会明确提示无法抽取文本。图片按固定 token 预算计费，最多保留最近三张；
  目录可把模型标记为纯文本，引擎会跳过图片并提示改用 OCR。
- `AskUser` 支持逐项描述/预览、推荐项、多选与可选自由文本。桌面渲染问题卡片，
  VS Code 使用原生选择器，TUI/CLI 提供编号选择；答案作为工具结果回传给模型，
  不再停留在占位符。
- `ReviewReport` 记录结构化 findings（文件/行号、严重度、类别、具体失败场景），
  并在通用工具卡中渲染文本摘要；静态 `CodeReview` 检查仍然保留。
- 本地出站策略已可在桌面设置页（**出站策略**）、VS Code 权限面板与 CLI/TUI
  的 `/egress` 命令中配置：模式（`off`/`ask`/`allowlist`）、host 白名单、
  PLC/OT 白名单、私网/metadata 拦截与回环放行。配置保存在当前客户端的版本
  文件，并在下一次工具决策生效；`ask` 复用现有权限对话框，`allowlist` 直接
  拒绝未知 host。部署仍可用 `ARUHAN_EGRESS_MODE`/`_ALLOW`/`_OT_ALLOW`/
  `_DENY_PRIVATE`/`_ALLOW_LOOPBACK` 覆盖。

### 环境变量供应商在各端 UI 的显示

- 设置 `ARUHAN_API_KEY` / `ARUHAN_PROVIDER` 后，桌面、VS Code 与 TUI 会把该
  供应商显示为已配置、已选中，不再显示“未配置”：daemon 的 `model.list` /
  `provider.list` 纳入仅由环境变量提供的供应商（仍按发行版过滤），桌面设置与
  模型选择使用 env 供应商/模型，VS Code 解析为当前供应商与模型，TUI 标记为
  current。
- 设置 `ARUHAN_PROVIDER` 但未设置 `ARUHAN_MODEL`（或模型不属于该供应商）时，
  TUI banner/状态栏、`/provider`、`/model` 与桌面 `currentModel` 显示该供应商
  目录中的默认模型，不再显示“unknown”。仅影响显示；请求路由仍沿用引擎原有
  回退逻辑。

### 本地插件包、MCP 技能与更完整的工具卡

- 新增 `.aruhan-plugin` 本地插件包：一个 ZIP 内含 `plugin.json`（名称、精确版本、
  类型、命令、声明权限）与实现文件。`plugin.inspect` 在安装前展示清单与权限，
  `plugin.install` 接受 `path` 并以原子方式安装。解压复用注册表制品的防护
  （zip-slip、条目数、单条与总大小上限），名称在成为目录前校验；加载失败会
  删除目录且不写持久化记录。
- 包内可携带可执行文件（解析为绝对路径，并要求声明 `exec` 权限），或通过
  node/python/python3 运行包内脚本，工作目录即插件目录。禁用/启用与 daemon
  重启都从 `plugin.json` 恢复本地包，`plugin.list` 也会列出它们。桌面插件页
  新增“浏览 → 预览 → 权限确认 → 安装”入口，CLI/TUI 提供 `/plugin inspect`
  与 `/plugin install`。
- 类型为 tool 的包会以 `plugin.<名称>`（或清单中的 `tool.name`）暴露给模型，
  参数 schema 来自 `tool.input_schema`，调用通过一次性 stdin/stdout JSON 契约
  转发给插件。插件工具注册/移除后会重建 action registry，无需重启 daemon；
  MCP server 的工具本就通过 MCP action 动态可见。包契约见
  `docs/plugin-packages.md`。
- `aruhan mcp-serve` 把已安装的、带指令正文的技能暴露为只读 MCP prompts
  （`skill.<名称>`），只返回技能正文，不执行任何工具；无正文的内置技能不暴露。
- 新增内置 `structured-review` 技能：规定生产级审查流程（先读变更、严重度/
  类别规则、必须给出具体失败场景、按根因去重），并引导模型调用 `ReviewReport`。
- 桌面与 VS Code 工具卡可渲染 FileRead 图片缩略图与 `ReviewReport` findings
  （严重度、类别、文件:行号、失败场景、建议、已检查/未检查）。完整图片负载仍只
  在 daemon 内供视觉通道使用，客户端只收到有界缩略图。

### 包含的 2.1.28 功能

- 后台子代理完成事件带 `task_id`/`session_id`；桌面新增**继续**动作与任务级
  **自动续跑** chip（默认关、仅可见且空闲、连续 5 次后暂停）。
- `skill install` 支持本地路径、`https://` 归档与
  `owner/repo[@ref][/subdir]` 来源；下载上限 64 MiB / 2 分钟，带 SSRF 防护；
  企业内网需 `ARUHAN_SKILL_ALLOW_PRIVATE=1`。
- 桌面与 VS Code 手打斜杠命令按 CLI 语义路由，包括 `/computer <任务>` 与别名。
- Windows 截图改用 `CreateDIBSection`；ComputerUse 步数预算可配置（默认 20、
  硬上限 50），并通过 `tool_progress` 实时展示步骤。
- 桌面与 VS Code 的 `command.run` 对齐；旧自动化视图回落到聊天。

### 验证

- 发布门禁：CN/INTL 使用同一源码 SHA，各 59 个产物，`SHA256SUMS` 57/57，
  `EDITION.txt` 版本 2.1.33。
- `check-edition-binary.mjs` 对 CN/INTL 的 CLI、桌面与 Factory 二进制均未发现
  对方版本 token。
- 两个发行版执行目录热刷新浏览器 E2E；目录 v18 的 CN/INTL 供应商测试通过，
  覆盖退役表按供应商作用域与 17→18 自动升级。
- 真实桌面窗口验证：仅设置 env DeepSeek、未设 `ARUHAN_MODEL` 时，设置→模型
  显示 **DeepSeek 已配置**、**DeepSeek V4.1 Flash**；`/api/models` 返回
  `activeProvider=deepseek`、`currentModel=deepseek-flash`。在 `build/` 放入
  更新的 INTL 引擎后，产品桌面仍选中同级 CN amd64 引擎，daemon 保持连接，
  未降级 standalone。
- 安装器检查：三个 Windows NSIS 脚本均通过 NSIS 3.13 编译；macOS pkg 的
  postinstall/uninstall 与 unix 脚本通过 `bash -n`；`install.ps1` 语法解析通过。
- 合并热重载后的完整门禁：`scripts/ci.sh --full` 通过；`go test ./...`
  872s，桌面前端 63/63 文件、338/338 用例通过。
- 在飞策略：权限/沙箱/工作模式变更作用于下一次工具调用，模型/供应商/档位/
  max tokens/temperature 变更作用于下一次 LLM 请求；已挂起审批保持挂起。由
  干净环境下的 permission、engine、config、query 与 daemon 测试覆盖。
- 多模态与提问：FileRead 图片/PDF 测试、AskUser 回传链路测试（engine、daemon、
  桌面、VS Code）、ReviewReport 校验测试；桌面 `tsc`、`npm run build` 与
  AskUser 卡片 vitest 通过；VS Code 扩展编译通过；i18n 与品牌门禁通过。
- 插件包、MCP prompts 与结构化 review：插件测试覆盖原子安装、zip-slip、脚本
  越界、exec 权限强制、拒绝覆盖、只预览不安装、从 `plugin.json` 恢复/启用、
  自动注册 agent 工具桥、清单工具 schema、禁用包仍可列出与有界输出写入；
  MCP 技能 prompt 的列出/读取/过滤测试与 structured-review 协议测试通过；
  桌面 65 文件 / 348 用例通过，VS Code 扩展构建通过且 webview 脚本通过语法检查。
- 出站策略：测试证明配置变更在下一次策略判定即被读取、环境变量模式优先于
  持久化模式、环境白名单与私网拦截保持叠加；桌面与 VS Code 暴露相同字段并通过
  各端版本文件持久化。真实 CLI 运行中，`allowlist = api.example.com` 时
  `https://evil.example/x` 被拒绝，原因记录为“host is not in egress allowlist”。
- 设置修订号：daemon 单元测试断言保存成功与配置热重载后修订号递增；桌面 tsc
  与 VS Code 构建通过，角标/状态栏接线完整。
- Linux headless（WSL Ubuntu + 真实 Chromium、真实点击）：设置页显示
  **配置修订 #1**；真实点击深色主题触发保存后角标变为 **#2**，页面无 JS
  错误，验证“保存 → daemon 应用 → config.changed → UI 刷新”闭环。
- Windows 真实输入验证（鼠标/键盘 + 截图）：TUI 中 `/egress` 初始为 off，
  修改模式/白名单/私网拦截后写入 `terminal.json`；`/plugin inspect` 与
  `/plugin install` 成功；`/plugin load` 后同一会话内 `plugin.echo` 可被模型
  调用并返回 `plugin-ok`；AskUser 选择器用方向键选择、回车提交。
- Windows 桌面真实输入验证（鼠标/键盘 + 截图）：设置页“生效时机”图例与
  **Config revision** 角标可见，保存后由 `#1` 递增到 `#2`；出站策略表单把
  `allowlist` + `api.example.com` + 私网拦截写入 `desktop.json`；在插件页
  预览并安装本地包；模型调用 `plugin.echo` 返回
  `{"echo":"plugin-ok","ok":true}`；AskUser 卡片完成作答；ReviewReport
  findings 卡片与 FileRead 图片缩略图正常渲染，且不再打印原始 data-URL；
  FileRead 权限弹窗通过正常对话框批准。
- 真实桌面窗口热生效验证：在独立数据目录中修改 `desktop.json`，桌面主题在
  4 秒内由浅色切换为深色，窗口未重启；daemon 与前端日志均记录变更键。
- 真实桌面窗口权限测试（本地 mock 供应商，不产生付费调用）：高危审批弹窗
  不显示“始终允许”；点击“允许”后高危命令确实执行，结果回传到桌面会话。
  PTY 测试同时覆盖 TUI 高危审批只提供“允许一次/拒绝”，以及非 Git 目录下
  本地 TUI 的项目根是进程 cwd 而不是数据目录。
- 新增测试：旧安装器数据接管（首个有效候选、只补缺失文件、用户状态合并）、
  各平台旧目录、便携桌面同级引擎解析（含 CPU 架构）与环境变量供应商选择。
- 发布二进制试用状态验证：`trial.json` 为 `enc:v1:...`；删除它但保留锚点时
  退出码 1，并输出简短的缺失提示；旧日期到期时退出码 1，并输出简短联系提示。
- 校验和：[国内版](v2.1.33-SHA256SUMS.txt)、
  [国际版](v2.1.33-SHA256SUMS-intl.txt)。Windows 二进制未签名。
- GitHub 保留 CN/INTL 完整资产；Gitee 镜像提供 CN 安装包、便携压缩包、VSIX、
  Windows TUI 安装器与 Linux/macOS 桌面二进制（仓库附件配额 1GB，裸 CLI
  二进制保留在 GitHub）。

### 商业使用与法律提示

官方发布包包含从首次运行起算的 30 天评估期。首次运行日期使用机器绑定密钥加密
并保存锚点；只删除 `trial.json` 会阻止启动。评估期结束后继续使用、商业使用、
私有化/本地部署、定制开发以及源码或永久买断，需要另行签署书面授权：
**37735973@qq.com**。Aruhan 按**“现状”**提供，
不附带任何担保；在适用法律允许的最大范围内，作者不对 AI 输出、工具执行、
数据丢失或其他使用后果承担责任。请审查每一处改动、保留备份、使用最小权限；
未经独立验证，不要用于高风险环境。禁止逆向工程、绕过授权或租户隔离，以及
未经书面许可的转售或再分发。完整条款见发布 README 与 `DISCLAIMER.md`。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 重启旧版本启动的 daemon。
- 无需手工配置或数据迁移；首次启动会自动接管旧安装器数据。

</details>
