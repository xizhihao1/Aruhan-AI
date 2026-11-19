# Aruhan v2.1.23

**Release date / 发布日期：2026-11-19** · [Checksums / 校验和](v2.1.23-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.23) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.23) · [English](#english) · [中文](#中文)

---

## English

v2.1.23 is a Desktop patch release. It fixes two user-visible defects found in
real use: long tool chains flickered between all-expanded and collapsed, and
the completion sound kept ringing. Neither affected the VS Code extension.
Configuration and data formats are unchanged.

### Tool cards no longer flicker

- Long-chain grouping was evaluated on every streaming render and collapsed
  whenever no tool was running. Sequential tools leave such a gap between every
  pair, so the list alternated between “many cards” and “one summary card”.
- Grouping is now deferred until the turn really ends. While the turn is live
  every tool card stays expanded; after completion the chain folds once into a
  labelled “N tool calls” summary. The summary now uses the translated label
  instead of a bare number.
- The VS Code extension already grouped only at reply end and is unchanged.

### Completion sound rings once

- Root cause: interrupted-task recovery (WAL replay) appended duplicate task
  entries with the same id and name “Recovered task” on successive starts. The
  global task-status listener walked the array, so the same id changed between
  `completed` and `cancelled` repeatedly and played the completion sound each
  time — reproduced as 24 sounds in 200 seconds.
- The task list is now deduplicated by id at startup (and cleaned on disk);
  WAL recovery no longer creates a placeholder for an id that already exists.
  The sound listener also ignores duplicate ids.
- A five-second startup mute prevents task-list and approval recovery from
  playing any sound while the application is starting. Normal completion and
  approval alerts resume immediately afterwards.
- Approval sounds are deduplicated by request id, so reconnecting and re-reading
  pending approvals cannot replay the same alert.

### Verification

- Real Desktop run with a diagnostic build: before the fix, 24 `task_done`
  sounds in 200 seconds; after the fix, one status transition and no repeated
  sound. Startup with the fix produced zero sound events in 12 seconds, and the
  stored task list went from 9 entries (four duplicates) to 5 unique tasks.
- A real model turn with six read-only tool calls: cards stayed expanded while
  streaming and folded once at completion.
- Desktop `tsc --noEmit`; desktop tool-group tests 5/5; shared render tests
  31/31; version consistency and brand gates.
- Checksums for every artifact are in
  [v2.1.23-SHA256SUMS.txt](v2.1.23-SHA256SUMS.txt). Windows binaries remain
  unsigned; SmartScreen may warn.

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart any daemon started by an older build; a running process cannot be
  replaced in place.
- No configuration or data migration is required. Existing duplicate task
  entries are cleaned automatically on first start.

---

## 中文

v2.1.23 是 Desktop 的修补版本，修复真实使用中发现的两个可见问题：长工具链在“全部展开”和“折叠成一条”之间来回跳变，以及完成提示音持续响。两者都不影响 VS Code 插件。配置与数据格式不变。

### 工具卡片不再跳变

- 长链聚合此前在每次流式渲染时都判断，只要“当前没有 running 工具”就折叠。工具是串行执行的，每两个工具之间都会出现这种空档，于是卡片在“很多张”和“一张摘要”之间反复切换。
- 现在聚合推迟到整轮真正结束之后：运行中所有工具卡保持展开；结束后一次性折叠为带文字的“N 步工具调用”摘要，摘要也由纯数字改为本地化文案。
- VS Code 插件本来只在回复结束时聚合一次，本次未改动。

### 完成提示音只响一次

- 根因：中断任务恢复（WAL 重放）在多次启动后不断追加同一 id、名为“已恢复的任务”的重复条目。全局任务状态监听按数组遍历，同一 id 在 `completed` 与 `cancelled` 之间被重复覆盖，每次都播放完成音——实测 200 秒内响 24 次。
- 现在启动时按 id 去重任务列表并回写磁盘；WAL 恢复不再为已存在的 id 创建占位任务；提示音监听也跳过重复 id。
- 新增 5 秒启动静音：应用启动阶段的任务列表恢复与审批补拉不播放任何提示音，之后立即恢复正常提醒。
- 审批音按 request_id 去重，重连补拉或事件重放都不会重复播放同一条审批提示。

### 验证

- 带诊断日志的真实 Desktop 运行：修复前 200 秒内 24 次 `task_done`；修复后只有一次状态跃迁、没有重复提示音。修复版启动后 12 秒内提示音事件为 0，任务列表由 9 条（含 4 条重复）收敛为 5 条唯一任务。
- 一次真实模型回合包含 6 个只读工具：运行中卡片保持展开，结束后只折叠一次。
- Desktop `tsc --noEmit`；Desktop 工具聚合测试 5/5；共享渲染测试 31/31；版本一致性与品牌门禁通过。
- 所有产物的校验和见 [v2.1.23-SHA256SUMS.txt](v2.1.23-SHA256SUMS.txt)。Windows 二进制仍未签名，SmartScreen 可能提示。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 使用旧版本启动的 daemon 需要重启；运行中的进程无法原地替换。
- 无需迁移配置或数据。历史重复任务条目会在首次启动时自动清理。

### Artifacts

- Windows: Aruhan-Setup, Aruhan-CLI-Setup, Aruhan-Desktop-Setup and Factory-Setup installers; portable CLI/Desktop ZIPs; TUI installer.
- Linux/macOS: aruhan-* and factory-* tarballs with standalone binaries.
- VS Code: aruhan-vscode.vsix.
- Evidence: sbom.cdx.json, licenses.json, Aruhan-Manuals-2.1.23.zip, v2.1.23-SHA256SUMS.txt.

All Windows binaries are unsigned; SmartScreen may warn. Verify every download against v2.1.23-SHA256SUMS.txt.

---

### 产物

- Windows：Aruhan-Setup、Aruhan-CLI-Setup、Aruhan-Desktop-Setup、Factory-Setup 安装包；CLI/Desktop 便携 ZIP；TUI 安装器。
- Linux/macOS：aruhan-* 与 factory-* tar 包及独立二进制。
- VS Code：aruhan-vscode.vsix。
- 佐证：sbom.cdx.json、licenses.json、Aruhan-Manuals-2.1.23.zip、v2.1.23-SHA256SUMS.txt。

Windows 二进制均未签名，SmartScreen 可能提示。下载后请用 v2.1.23-SHA256SUMS.txt 校验。
