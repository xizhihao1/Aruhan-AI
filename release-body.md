# Aruhan v2.1.24

**Release date / 发布日期：2026-11-19** · [Checksums / 校验和](v2.1.24-SHA256SUMS.txt) · [Gitee](https://gitee.com/guleng2005/Aruhan-AI/releases/tag/v2.1.24) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.24) · [English](#english) · [中文](#中文)

---

## English

v2.1.24 is a Desktop patch release for two problems reported after v2.1.23: the
debate switch could appear stuck in the on state, and a deleted “Recovered
task” came back after every restart. Both had identifiable root causes; the
restart problem also exposed a storage deadlock that silently blocked the task
list from being saved. Configuration and data formats are unchanged.

### Debate switch could not be turned off

- The switch writes the per-task `debateEnabled` field. If `activeTaskId`
  pointed at a task that no longer existed (left behind by a recovery or delete
  path), `UPDATE_WORKSPACE_TASK` updated nothing, while the UI read
  `currentTask ?? settings` and kept showing the global default — still on.
  The engine had already stopped the debate; only the switch and the next send
  stayed out of sync.
- Even with a live task, the display snapshot (`debateEnabledByTaskRef`,
  captured when the turn was sent) kept rendering that task as a debate after
  the switch was turned off — the debate layout hid the thinking block and
  parsed the reply into debate sections. The toggle now updates the snapshot
  together with the task field.
- The toggle also validates the active task id. When it is stale, the switch
  writes the global default and persists it through `ConfigSave`, so the pill
  and the next request agree. Verified on screen: on → “Debate ∞”, off →
  “Debate”, with `debate.start` / `debate.stop` in the daemon log and the next
  turn reporting `debate=false`.

### Deleted recovered tasks no longer return

- Root cause 1: the local crash journal (`aruhan_wal`) had grown to 3.4MB and
  filled the 5MB `localStorage`. The next task-list, trash-snapshot and
  tombstone writes all failed with quota errors, so after a restart the Go
  archive rebuilt the missing task as “Recovered task”.
- Root cause 2: soft delete intentionally keeps the Go archive for trash
  restore but persisted no deletion marker. Recovery therefore treated the
  task as an orphan and recreated it on every start.
- Fixes:
  - The local WAL is dropped when it exceeds its 256KB budget and snapshots
    cannot be written; the Go journal holds the same map and remains the
    recovery source. Quota reclaim now also removes an oversized local WAL.
  - Soft-deleted task ids are persisted (`aruhan_soft_deleted_tasks`) and the
    Go archive receives an empty tombstone, so neither archive nor WAL recovery
    can recreate the task. Restoring from trash clears both markers and
    re-mirrors the restored history.
  - Startup dedupe also filters ids marked deleted.
- The task-row button was mislabelled “Delete workspace”; it now says “Delete
  task”.

### Verification

- Screen-driven Desktop run with real mouse/keyboard: debate on/off states and
  screenshots; daemon log shows `debate started` then `debate stopped`, and the
  following turn reports `debate=false`.
- Deleting a recovered task: `aruhan_soft_deleted_tasks` contains its id, the
  trash snapshot is persisted, and a full restart does not bring the task back.
- Before the storage fix `localStorage` measured 5120KB (full) with a 3443KB
  WAL; after it measured 2289KB with an empty WAL.
- Desktop `tsc --noEmit`, tool-group tests 5/5, version consistency and brand
  gates.
- Checksums for every artifact are in
  [v2.1.24-SHA256SUMS.txt](v2.1.24-SHA256SUMS.txt). Windows binaries remain
  unsigned; SmartScreen may warn.

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart any daemon started by an older build.
- No configuration or data migration is required. Duplicate task entries and
  an oversized local WAL are cleaned automatically on first start.

---

## 中文

v2.1.24 是 Desktop 的修补版本，处理 v2.1.23 之后反馈的两个问题：辩论开关关闭后看起来仍处于辩论模式；删除的“已恢复的任务”每次重启又回来。两个问题都定位到了根因；重启问题还暴露出一个会静默阻断任务列表写入的存储死锁。配置与数据格式不变。

### 辩论开关关不掉

- 开关写入任务级 `debateEnabled`。当 `activeTaskId` 指向一个已不存在的任务（恢复/删除链路遗留）时，`UPDATE_WORKSPACE_TASK` 实际没有更新任何条目；界面读取 `currentTask ?? settings`，继续显示全局默认值（仍为开启）。引擎其实已经停止辩论，只是开关和下一次发送不一致。
- 即使任务有效，显示快照 `debateEnabledByTaskRef`（发送时记录）在关闭开关后仍按辩论结构渲染该任务——辩论布局会隐藏思考块、把正文拆成辩论分段，看起来就是“还在辩论”。现在切换开关会同步更新该快照。
- 切换前还会校验活跃任务 id；失效时写全局默认并通过 `ConfigSave` 持久化，保证开关状态与下一次请求一致。屏幕实测：开启显示“辩论 ∞”，关闭恢复“辩论”；daemon 日志出现 `debate.start` / `debate.stop`，随后回合报告 `debate=false`。

### 删除的恢复任务不再回来

- 根因一：本地崩溃日志 `aruhan_wal` 涨到 3.4MB，占满 5MB 的 `localStorage`。后续任务列表、回收站快照、删除墓碑全部因配额失败，重启后 Go 归档把缺失任务重建成“已恢复的任务”。
- 根因二：软删除为了回收站恢复刻意保留 Go 归档，却没有持久化删除标记，恢复逻辑因此把任务当孤儿，每次启动都重建。
- 修复：
  - 本地 WAL 超过 256KB 且快照写不进去时直接丢弃（Go journal 持有同一份，仍是恢复源）；配额回收也会删除超限的本地 WAL。
  - 软删除的任务 id 持久化到 `aruhan_soft_deleted_tasks`，同时向 Go 归档写空墓碑，归档与 WAL 恢复都不会再重建；从回收站恢复时解除两个标记并重新镜像历史。
  - 启动去重同时过滤已删除 id。
- 任务行右侧按钮此前误标为“删除工作”，现改为“删除任务”。

### 验证

- 真实鼠标/键盘的 Desktop 屏幕测试：辩论开关开/关状态与截图；daemon 日志依次出现 `debate started`、`debate stopped`，下一回合 `debate=false`。
- 删除恢复任务：`aruhan_soft_deleted_tasks` 记录其 id，回收站快照成功落盘，完整重启后任务不再出现。
- 存储修复前 `localStorage` 实测 5120KB（满），WAL 3443KB；修复后 2289KB，WAL 为空。
- Desktop `tsc --noEmit`、工具聚合测试 5/5、版本一致性与品牌门禁通过。
- 所有产物的校验和见 [v2.1.24-SHA256SUMS.txt](v2.1.24-SHA256SUMS.txt)。Windows 二进制仍未签名，SmartScreen 可能提示。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 使用旧版本启动的 daemon 需要重启。
- 无需迁移配置或数据。重复任务条目与超限的本地 WAL 会在首次启动时自动清理。

### Artifacts

- Windows: Aruhan-Setup, Aruhan-CLI-Setup, Aruhan-Desktop-Setup and Factory-Setup installers; portable CLI/Desktop ZIPs; TUI installer.
- Linux/macOS: aruhan-* and factory-* tarballs with standalone binaries.
- VS Code: aruhan-vscode.vsix.
- Evidence: sbom.cdx.json, licenses.json, Aruhan-Manuals-2.1.24.zip, v2.1.24-SHA256SUMS.txt.

All Windows binaries are unsigned; SmartScreen may warn. Verify every download against v2.1.24-SHA256SUMS.txt.

---

### 产物

- Windows：Aruhan-Setup、Aruhan-CLI-Setup、Aruhan-Desktop-Setup、Factory-Setup 安装包；CLI/Desktop 便携 ZIP；TUI 安装器。
- Linux/macOS：aruhan-* 与 factory-* tar 包及独立二进制。
- VS Code：aruhan-vscode.vsix。
- 佐证：sbom.cdx.json、licenses.json、Aruhan-Manuals-2.1.24.zip、v2.1.24-SHA256SUMS.txt。

Windows 二进制均未签名，SmartScreen 可能提示。下载后请用 v2.1.24-SHA256SUMS.txt 校验。
