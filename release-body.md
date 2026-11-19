# Aruhan v2.1.25

**Release date / 发布日期：2026-11-19** · [Checksums / 校验和](v2.1.25-SHA256SUMS.txt) · [GitHub](https://github.com/xizhihao1/Aruhan-AI/releases/tag/v2.1.25) · [English](#english) · [中文](#中文)

---

## English

v2.1.25 is a Desktop settings patch. It fixes the provider edit dialog
reusing the previous step's text and dialogs closing while the user drags to
select text. It also points the Gitee release README and release page at Gitee
downloads instead of GitHub. Configuration and data formats are unchanged.

### Provider edit: one input per step

- “Edit” runs three prompts in a row (Base URL → Default Model → API Key). All
  three reused the same dialog instance, and its input only resets when the
  dialog opens. After entering a URL, the default-model prompt therefore still
  showed the URL — and confirming it would have saved the URL as the default
  model.
- Each step now has its own dialog instance (`key` per provider/step). The input
  starts empty, is focused and selected for every step.
- Storage is unchanged and already separate: `aruhan.json` keeps
  `providers.<key>.base_url`, `default_model` and `api_key` as independent
  fields; `provider.edit` writes them independently and `provider.list` returns
  them separately, so every client reads the right value.

### Dialogs no longer close while selecting text

- The backdrop closed a dialog whenever a click ended outside it. Dragging from
  an input to select text and releasing on the backdrop makes the browser report
  the click on the backdrop, so the dialog disappeared (“flash closed”).
- Backdrop close now requires both mouse-down and click on the backdrop itself.
  `PromptDialog` and `ConfirmDialog` share the fix. Verified with a real drag
  from the input to outside the dialog: it stays open and the selection remains.

### Gitee pages point to Gitee

- The Gitee release repository README and the v2.1.25 release page link to Gitee
  Releases. GitHub remains the mirror for GitHub visitors; Gitee pages no longer
  require a GitHub connection to download.

### Verification

- Real mouse/keyboard Desktop run: URL step → default-model step shows an empty
  input (previously the URL), then drag-selecting text keeps the dialog open.
- Desktop `tsc --noEmit`; version consistency and brand gates.
- Checksums for every artifact are in
  [v2.1.25-SHA256SUMS.txt](v2.1.25-SHA256SUMS.txt). Windows binaries remain
  unsigned; SmartScreen may warn.

### Upgrade notes

- Replace the CLI/TUI/Desktop binaries and reinstall the VSIX.
- Restart any daemon started by an older build.
- No configuration or data migration is required.

---

## 中文

v2.1.25 是 Desktop 设置修补版本：修复供应商编辑弹窗沿用上一步文本、鼠标拖选文字时弹窗闪退，并把 Gitee 发布仓 README 与发布页的下载链接指向 Gitee。配置与数据格式不变。

### 供应商编辑：每一步独立输入框

- “Edit” 连续弹出三步输入（Base URL → 默认模型 → API Key），三步复用同一个弹窗实例，而输入框只在弹窗打开时重置。因此输入 URL 后，默认模型这一步仍显示 URL——若直接确认，还会把 URL 存成默认模型。
- 现在每一步使用独立的弹窗实例（按供应商/步骤设置 `key`），输入框为空、自动聚焦并全选。
- 存储本身没有混在一起：`aruhan.json` 中 `providers.<key>` 分别保存 `base_url`、`default_model`、`api_key`，`provider.edit` 分别写入，`provider.list` 分别返回，各端都能正确读取。

### 拖选文字不再导致弹窗闪退

- 遮罩此前只要点击事件落在遮罩上就关闭弹窗。用户在输入框内按下鼠标、拖到弹窗外释放时，浏览器把 click 报在遮罩上，弹窗随即消失。
- 现在只有“按下和点击都发生在遮罩上”才关闭。`PromptDialog` 与 `ConfirmDialog` 同步修复。用真实鼠标从输入框拖到弹窗外验证：弹窗保持打开，选中内容保留。

### Gitee 页面指向 Gitee

- Gitee 发布仓 README 与 v2.1.25 发布页的下载链接改为 Gitee Releases；GitHub 页面继续指向 GitHub，作为镜像存在。Gitee 用户下载不再依赖 GitHub 连通性。

### 验证

- 真实鼠标/键盘 Desktop 测试：URL 步确认后，默认模型步输入框为空（此前残留 URL）；拖选文字后弹窗不关闭。
- Desktop `tsc --noEmit`；版本一致性与品牌门禁通过。
- 所有产物的校验和见 [v2.1.25-SHA256SUMS.txt](v2.1.25-SHA256SUMS.txt)。Windows 二进制仍未签名，SmartScreen 可能提示。

### 升级说明

- 替换 CLI/TUI/Desktop 二进制并重新安装 VSIX。
- 使用旧版本启动的 daemon 需要重启。
- 无需迁移配置或数据。

### Artifacts

- Windows: Aruhan-Setup, Aruhan-CLI-Setup, Aruhan-Desktop-Setup and Factory-Setup installers; portable CLI/Desktop ZIPs; TUI installer.
- Linux/macOS: aruhan-* and factory-* tarballs with standalone binaries.
- VS Code: aruhan-vscode.vsix.
- Evidence: sbom.cdx.json, licenses.json, Aruhan-Manuals-2.1.25.zip, v2.1.25-SHA256SUMS.txt.

All Windows binaries are unsigned; SmartScreen may warn. Verify every download against v2.1.25-SHA256SUMS.txt.

---

### 产物

- Windows：Aruhan-Setup、Aruhan-CLI-Setup、Aruhan-Desktop-Setup、Factory-Setup 安装包；CLI/Desktop 便携 ZIP；TUI 安装器。
- Linux/macOS：aruhan-* 与 factory-* tar 包及独立二进制。
- VS Code：aruhan-vscode.vsix。
- 佐证：sbom.cdx.json、licenses.json、Aruhan-Manuals-2.1.25.zip、v2.1.25-SHA256SUMS.txt。

Windows 二进制均未签名，SmartScreen 可能提示。下载后请用 v2.1.25-SHA256SUMS.txt 校验。
