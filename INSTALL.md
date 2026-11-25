# Install / 安装 — Aruhan v2.1.29 (China mainland edition / 国内版)

## Windows

1. Download `aruhan-windows-amd64-cn.exe` (CLI) or the desktop installer
   asset from this release.
2. Put the CLI on `PATH`, or run it from the download directory:
   `.aruhan-windows-amd64-cn.exe --version`.
3. The desktop installer creates Start Menu entries and registers the
   uninstaller.

## Linux

```bash
tar -xzf aruhan-linux-amd64-cn.tar.gz
install -m 0755 aruhan ~/.local/bin/aruhan
aruhan --version
```

## macOS

Use the `.pkg` asset when present, or unpack the `darwin` archive and move
`aruhan` to a directory on `PATH`. Release binaries are not notarized;
allow them in **System Settings → Privacy & Security** if Gatekeeper blocks
the first launch.

## VS Code extension

Install the `.vsix` asset:

```bash
code --install-extension <file>-cn.vsix
```

## Run

```bash
aruhan --plain          # CLI / REPL
aruhan query "..."      # one-shot
aruhan chat             # full-screen TUI (or just `aruhan` on a terminal)
aruhan-desktop          # desktop (headless on Linux/macOS)
factory serve           # Factory control plane, console at :8787/console/
```

## Verify

```bash
sha256sum -c SHA256SUMS
```

Every China mainland edition build reports its edition:

```bash
aruhan --version   # aruhan <version> (CN edition)
```

## 中文

## Windows

1. 下载 `aruhan-windows-amd64-cn.exe`（CLI）或本 Release 中的桌面安装包。
2. 将 CLI 加入 `PATH`，或直接在下载目录运行
   `.aruhan-windows-amd64-cn.exe --version`。
3. 桌面安装包会创建开始菜单项并注册卸载程序。

## Linux

```bash
tar -xzf aruhan-linux-amd64-cn.tar.gz
install -m 0755 aruhan ~/.local/bin/aruhan
aruhan --version
```

## macOS

优先使用 `.pkg` 安装包；没有时解压 `darwin` 归档并把 `aruhan` 放到
`PATH` 目录。发布二进制未做公证；首次启动被 Gatekeeper 拦截时，在
“系统设置 → 隐私与安全性”中放行。

## VS Code 插件

安装本 Release 中的 `.vsix`：

```bash
code --install-extension <file>-cn.vsix
```

## 运行

```bash
aruhan --plain          # CLI / REPL
aruhan query "..."      # 一次性查询
aruhan chat             # 全屏 TUI（交互终端也可直接运行 `aruhan`）
aruhan-desktop          # 桌面端（Linux/macOS 为 headless）
factory serve           # Factory 控制面，控制台 :8787/console/
```

## 校验

```bash
sha256sum -c SHA256SUMS
```

国内版构建可通过版本号确认发行版：

```bash
aruhan --version   # aruhan <版本号> (CN edition)
```
