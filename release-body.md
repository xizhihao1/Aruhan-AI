# Aruhan v2.1.31

**Release date / 发布日期：2026-11-26** · [CN checksums / 国内版校验和](https://gitee.com/guleng2005/Aruhan-AI/releases/download/v2.1.31/SHA256SUMS) · [English](#english) · [中文](#中文)

---

## English

Aruhan is a local-first AI engineering workspace: one engine behind a CLI,
terminal UI, desktop app, VS Code extension, and the Factory control plane. It
reads the repository, edits code, runs commands and tests, reviews the diff,
and carries work through gated delivery pipelines — with your own API key and
no publisher-hosted backend.

v2.1.31 is a desktop hotfix on top of 2.1.30: deleting a chat task now removes
its daemon counterpart, so deleted tasks no longer reappear as blank entries
after a restart. The fix is in the shared desktop UI, covering the native
Windows desktop and the Linux/macOS headless browser UI. All 2.1.30 installer,
catalog and client fixes are included.

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
- VS Code already used the daemon task id and is unaffected; CLI/TUI have no
  workspace task list. A regression test covers the `task.list` sync path.

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
  2.1.31 clears the old installer default from `ARUHAN_DATA_DIR`; the first
  launch copies the old data automatically. Running 2.1.28 and 2.1.31 side by
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
  each, `SHA256SUMS` 57/57, `EDITION.txt` version 2.1.31.
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
- New tests: legacy installer data adoption (first useful candidate, missing
  files only, user-state merge), platform legacy paths, portable sibling engine
  resolution including CPU architecture, and env-provider selection
  applicability.
- Trial-state test on the release binary: `trial.json` is stored as
  `enc:v1:...`; deleting it while the anchor remains exits 1 with the short
  missing-state message; an expired legacy date exits 1 with the short
  contact message.
- Checksums: [CN](v2.1.31-SHA256SUMS.txt),
  [INTL](v2.1.31-SHA256SUMS-intl.txt). Windows binaries remain unsigned.
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

## 中文

Aruhan 是本地优先的 AI 工程工作台：同一套引擎驱动 CLI、终端 TUI、桌面端、
VS Code 插件和 Factory 控制面。它会阅读仓库、修改代码、执行命令与测试、
审查差异，并让工作经过带门禁的交付流水线；使用你自己的 API Key，没有发布者
托管的后端。

v2.1.31 是 2.1.30 的桌面端热修：删除聊天任务时同时删除对应的 daemon 任务，
删除后不再在重启时以空白任务形式复活。修复位于共享桌面 UI，覆盖 Windows
原生桌面与 Linux/macOS headless 浏览器 UI。2.1.30 的安装器、模型目录与各端
修复全部包含在内。

### 删除的任务不再复活

- 桌面聊天会创建本地任务（`task-<时间戳>`）与 daemon 任务（`task-<hex>`），
  通过 `daemonTaskId` 关联。旧删除逻辑传的是本地 id，daemon 任务留在
  `tasks.json`；重启时 `task.list` 同步把它加回列表，形成以首次提问命名的
  空白任务（例如“你是谁”）。
- 现在删除优先使用 `daemonTaskId`，并给两个 id 都登记持久化墓碑，daemon
  删除失败也不会复活；用户删除本地任务后迟到的 `task.create` 响应会立即
  清理；从回收站恢复时解除两个 id 的墓碑。
- VS Code 原本就用 daemon 任务 id，不受影响；CLI/TUI 没有工作区任务列表。
  新增回归测试覆盖 `task.list` 同步路径。

### 模型目录 v18

- **豆包（火山方舟）。** 加入官方 `doubao-seed-2-1-pro-260915` 与 turbo 变体
  并更新默认项；纠正仍在提供却被误标退役的模型。
- 退役表改为按供应商作用域，某个供应商的退役记录不再误伤其他供应商的同名模型。
- `models.json` 目录版本 17 → 18；用户已有的旧目录在首次使用时自动升级。
- GLM-5.4 暂不加入：官方已发布但 API 未开放，待 API 可用后再补。
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
- **升级说明。** 使用 Windows 整合包的用户安装 2.1.31 时会清除旧安装器写入的
  默认变量，首次启动自动复制旧数据。不支持 2.1.28 与 2.1.31 并行使用不同目录。

### 便携桌面引擎选择

- 便携桌面现在优先使用同目录随包部署的**同发行版**引擎，再回退到开发用的
  `build/` 中间产物。此前 CN 便携桌面可能选中 `build/` 中残留的 INTL
  `aruhan`，daemon 因而报 CN 供应商在国际版不可用。Linux/macOS headless
  桌面同样修复。
- 同级引擎探测同时校验 CPU 架构：发布目录会同时放 amd64/arm64 引擎，若不校验，
  amd64 机器可能选中更新的 arm64 文件（反之亦然），daemon fork 失败后桌面会
  静默降级为 standalone。

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
  `EDITION.txt` 版本 2.1.31。
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
- 新增测试：旧安装器数据接管（首个有效候选、只补缺失文件、用户状态合并）、
  各平台旧目录、便携桌面同级引擎解析（含 CPU 架构）与环境变量供应商选择。
- 发布二进制试用状态验证：`trial.json` 为 `enc:v1:...`；删除它但保留锚点时
  退出码 1，并输出简短的缺失提示；旧日期到期时退出码 1，并输出简短联系提示。
- 校验和：[国内版](v2.1.31-SHA256SUMS.txt)、
  [国际版](v2.1.31-SHA256SUMS-intl.txt)。Windows 二进制未签名。
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
