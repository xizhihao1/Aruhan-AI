# Aruhan v2.1.29

**Release date / 发布日期：2026-11-25** · [CN checksums / 国内版校验和](v2.1.29-SHA256SUMS.txt) · [INTL checksums / 国际版校验和](v2.1.29-SHA256SUMS-intl.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.29) · [English](#english) · [中文](#中文)

---

## English

v2.1.29 fixes the Windows installer data-directory split that could make an
installed build show "API key not set" even though the key was still on disk.
It includes all 2.1.28 features. Replace 2.1.28 installations with this build.

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
  2.1.29 clears the old installer default from `ARUHAN_DATA_DIR`; the first
  launch copies the old data automatically. Running 2.1.28 and 2.1.29 side by
  side against different directories is not supported.

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
  each, `SHA256SUMS` 57/57, `EDITION.txt` version 2.1.29.
- `check-edition-binary.mjs` reports no other-edition tokens in CN or INTL CLI,
  desktop and Factory binaries.
- Catalog hot-refresh browser E2E on both release builds.
- Installer checks: all three Windows NSIS scripts compile with NSIS 3.13; the
  macOS pkg postinstall/uninstall and unix scripts pass `bash -n`; `install.ps1`
  parses cleanly.
- New tests: legacy installer data adoption (first useful candidate, missing
  files only, user-state merge) and platform legacy paths.
- Checksums: [CN](v2.1.29-SHA256SUMS.txt),
  [INTL](v2.1.29-SHA256SUMS-intl.txt). Windows binaries remain unsigned.
- GitHub carries the complete CN and INTL asset sets; the Gitee mirror carries
  the CN installers/archives/VSIX plus Windows TUI installers (repo-wide 1 GB
  attachment quota; full set remains on GitHub).

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart daemons started by an older build.
- No manual configuration or data migration is required; the first launch
  adopts legacy installer data automatically.

---

## 中文

v2.1.29 修复 Windows 安装包的数据目录分裂问题：安装后即使密钥仍在磁盘上，
界面也可能提示“未设置 API Key”。本版包含 2.1.28 的全部功能，请用本版替换
2.1.28 安装。

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
- **升级说明。** 使用 Windows 整合包的用户安装 2.1.29 时会清除旧安装器写入的
  默认变量，首次启动自动复制旧数据。不支持 2.1.28 与 2.1.29 并行使用不同目录。

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
  `EDITION.txt` 版本 2.1.29。
- `check-edition-binary.mjs` 对 CN/INTL 的 CLI、桌面与 Factory 二进制均未发现
  对方版本 token。
- 两个发行版执行目录热刷新浏览器 E2E。
- 安装器检查：三个 Windows NSIS 脚本均通过 NSIS 3.13 编译；macOS pkg 的
  postinstall/uninstall 与 unix 脚本通过 `bash -n`；`install.ps1` 语法解析通过。
- 新增测试：旧安装器数据接管（首个有效候选、只补缺失文件、用户状态合并）与
  各平台旧目录。
- 校验和：[国内版](v2.1.29-SHA256SUMS.txt)、
  [国际版](v2.1.29-SHA256SUMS-intl.txt)。Windows 二进制未签名。
- GitHub 保留 CN/INTL 完整资产；Gitee 镜像提供 CN 安装包/压缩包/VSIX 与
  Windows TUI 安装器（仓库附件配额 1GB，完整集合见 GitHub）。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 重启旧版本启动的 daemon。
- 无需手工配置或数据迁移；首次启动会自动接管旧安装器数据。
