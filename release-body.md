# Aruhan v2.1.18

**Release date / 发布日期：2026-11-16** · [Checksums / 校验和](https://github.com/xizhihao1/Aruhan-AI/releases/download/v2.1.18/v2.1.18-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.18) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.18) · [English](#english) · [中文](#中文)

---

## English

v2.1.18 turns Factory deployment and project lifecycle into operations the local
console can verify instead of guesswork. It also fixes the TUI/CLI startup and
feedback problems found in real sessions.

### First-run setup and deployment

- The overview shows a **First-run setup** card for the projects directory and
  the execution model.
- The model wizard saves a deployment default and verifies the API key with a
  read-only `GET <base_url>/models` request. An invalid key stays in the dialog
  and is not saved as the default.
- **Runtime & deployment → Deployment settings** lets a local single-tenant
  console change the **projects root**, create or select a directory, migrate
  existing projects (same-volume rename or per-project merge), and **move back
  to the previous root** with the same confirmed migration flow.
- **Deployment check** runs a read-only nine-item self-check: projects root,
  writability, database directory, station pack, default pipeline, pack/pipeline
  alignment, planning templates, console assets and execution model (including
  whether its key is configured). A pipeline that references stations absent
  from the pack is reported before dispatch; a Unix install that copied only the
  binary without `web/` is also reported.
- The directory picker accepts a pasted absolute path and Enter, in addition to
  browsing.

### Projects, regression and logs

- **Archive bin** lists archived projects and restores one by name. Restoring
  never overwrites an existing project and is rejected while runs are active.
- The regression page can select a local regression suite, run it, optionally
  update the baseline, and follow the subprocess status.
- **Run logs** lists the latest local `api-*.log` / `resume-*.log` worker logs
  and shows the last 64 KB. It is local-admin only, does not expose absolute
  paths, and rejects non-worker files and traversal.
- Migration responses include `migrated_projects` and `migration_ms`, shown in
  the success toast.

### New-run and TUI fixes

- The model field is a provider-grouped picker with an explicit “use the
  deployment/project default” choice and a “custom model” entry for endpoints
  outside the catalog.
- Settings has jump buttons for Deployment, Deployment check, Run logs,
  Execution models, Media models and Tenant policy.
- Toast notifications have a close button.
- TUI startup no longer blocks on CodeMapper `Ping` behind the indexing write
  lock; measured `initCodeMapper` dropped from 3–8 s to about 0.9 s.
- The TUI keeps run controls visible, adds `F2` to cycle read-only →
  workspace-write → full-access, shows the scope in the banner, and displays
  `Bash running · Ns · command · Esc to interrupt` during long tool calls.
- Quote-aware command checks no longer reject regex carets inside quotes;
  `$?` and `$$` are allowed in the sandbox while dynamic expansion stays
  fail-closed.
- CodeMapper closes SQLite with `wal_checkpoint(TRUNCATE)` and a 64 MiB journal
  limit. A stale home-directory cache of 64 MiB or more is removed when Aruhan
  starts with the home directory as its root; project indexes are untouched.

### Verification

- `scripts/ci.sh --full`: all checks passed (Go tests, plan-check 105/105, i18n,
  govulncheck, npm audit, web 169 tests, VS Code extension, desktop Go and 298
  frontend tests).
- Windows Edge real-click audit, Linux WSL native deployment, and macOS
  cross-compilation were verified.
- `build-all.ps1 -Clean -Expires 2027-02-28` produced 57 artifacts;
  `sha256sum -c` passed for all 57, and the checksums are recorded in
  `v2.1.18-SHA256SUMS.txt`.
- Official builds carry `ExpiresAt=2027-02-28`: usable through that day; from
  2027-03-01 the CLI/TUI/daemon print the localized trial-expired message and
  exit. Local builds without `-Expires` are not gated.

### Known limitations

- Permanent project delete and project-ID rename are not exposed in the web
  console. Archive + restore is the safe default; delete/rename need a separate
  history/alias design.
- The console does not restart its own service; use `factory service restart`
  from an external shell or the service manager.
- Large-directory merges report a result summary, not live per-project progress.
- Worker log filenames do not yet carry the run ID, so a run cannot deep-link to
  its exact log.
- Windows binaries are unsigned.

---

## 中文

v2.1.18 把 Factory 的部署与项目生命周期从“猜”变成控制台可验证的操作，并修复
真实会话中发现的 TUI/CLI 启动与反馈问题。

### 首次运行与部署

- 总览页显示**首次运行设置**卡片，检查项目空间目录与执行模型。
- 模型向导保存部署级默认模型，并用只读 `GET <base_url>/models` 验证 Key；
  无效 Key 留在弹窗中，不会写成默认模型。
- **运行环境与部署 → 部署配置**支持本机单租户修改**项目空间根目录**：创建或
  选择目录、迁移现有项目（同盘 rename 或逐项目合并），并用同一套确认/迁移
  流程**迁回上一目录**。
- **部署自检**只读检查 9 项：项目空间根目录、可写性、数据库目录、工位包、
  默认流水线、工位包与流水线匹配、规划模板、控制台资产、执行模型（含 Key
  是否配置）。流水线引用了包里不存在的工位会在派发前指出；Linux/macOS 只
  复制二进制、缺少 `web/` 也会暴露。
- 目录选择器支持直接粘贴绝对路径并回车，同时保留逐级浏览。

### 项目、回归与日志

- **归档箱**列出归档项目，可按名称恢复；恢复不会覆盖同名项目，有运行中任务
  时拒绝。
- 回归页可选择本机回归集并运行，可勾选更新基线，轮询子进程状态。
- **运行日志**列出本机最近的 `api-*.log` / `resume-*.log`，可查看最后 64 KB；
  仅本机管理员可用，不暴露绝对路径，拒绝非 worker 文件和路径穿越。
- 迁移响应返回 `migrated_projects` 与 `migration_ms`，成功提示显示项目数与耗时。

### 新建运行与 TUI 修复

- 模型字段改为按供应商分组的选择器，明确提供“使用部署/项目默认模型”和
  “自定义模型（目录外）”两种入口。
- 设置页提供“部署与目录 / 部署自检 / 运行日志 / 执行模型 / 媒体模型 /
  租户策略”跳转。
- Toast 增加关闭按钮。
- TUI 启动不再阻塞在 CodeMapper 后台索引写锁后的 `Ping`；实测
  `initCodeMapper` 从 3–8 秒降到约 0.9 秒。
- TUI 运行中常驻快捷键提示；新增 `F2` 循环只读→工作区→全电脑；横幅显示
  文件范围；长工具调用显示 `Bash 运行中 · Ns · 命令 · Esc 中断`。
- 命令安全检查只在引号外拒绝 `^`，正则里的 `"^(ok|---)"` 不再误杀；沙箱允许
  `$?`/`$$`，动态展开仍然 fail-closed。
- CodeMapper 退出时 `Close` + `wal_checkpoint(TRUNCATE)`，并设置 64 MiB WAL
  上限；以主目录为根启动时会删除旧版本遗留的 ≥64 MiB 生成缓存，项目索引
  不受影响。

### 验证

- `scripts/ci.sh --full` 全部通过：Go 全量、plan-check 105/105、i18n、
  govulncheck、npm audit、web 169 项、VS Code 扩展、桌面 Go 与前端 298 项。
- Windows Edge 真实点击、Linux WSL 原生部署、macOS 交叉编译均已验证。
- `build-all.ps1 -Clean -Expires 2027-02-28` 生成 57 项工件；`sha256sum -c` 全部
  57 项通过；校验和记录在 `v2.1.18-SHA256SUMS.txt`。
- 官方构建注入 `ExpiresAt=2027-02-28`：当天仍可用，2027-03-01 起
  CLI/TUI/daemon 输出本地化“试用期已到”并退出；未传 `-Expires` 的本地构建
  不受限制。

### 已知限制

- Web 控制台不提供永久删除项目或修改项目 ID；归档 + 恢复是安全默认，
  删除/改名需要单独的历史/别名设计。
- 控制台不自行重启服务；请在外部终端或服务管理器中执行
  `factory service restart`。
- 大目录合并只给结果摘要，没有逐项目实时进度。
- worker 日志文件名暂不含运行 ID，运行详情还不能精确跳到对应日志。
- Windows 二进制未签名。
