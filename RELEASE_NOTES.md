# Release v2.1.34 — China mainland edition / 国内版

**Version v2.1.34** · **China mainland edition** · [README](README.md) · [Install](INSTALL.md) · [License](LICENSE) · [Disclaimer](DISCLAIMER.md)

Aruhan is a local-first AI engineering workspace: CLI, terminal UI, desktop
app, VS Code extension, and the Factory control plane share one runtime and
one configuration directory. This release contains compiled artifacts only.

## Assets

| Asset | Bytes |
|---|---|
| **darwin/aruhan-darwin-amd64-2.1.34-cn.tar.gz** | 43244890 |
| **darwin/aruhan-darwin-arm64-2.1.34-cn.tar.gz** | 40923695 |
| **darwin/factory-darwin-amd64-2.1.34-cn.tar.gz** | 45225578 |
| **darwin/factory-darwin-arm64-2.1.34-cn.tar.gz** | 42615882 |
| **linux/aruhan-linux-amd64-2.1.34-cn.tar.gz** | 42580113 |
| **linux/aruhan-linux-arm64-2.1.34-cn.tar.gz** | 39443192 |
| **linux/factory-linux-amd64-2.1.34-cn.tar.gz** | 44533247 |
| **linux/factory-linux-arm64-2.1.34-cn.tar.gz** | 41119587 |
| **vscode/aruhan-vscode-cn.vsix** | 88282311 |
| **windows/Aruhan-CLI-Setup-2.1.34-cn.exe** | 21898625 |
| **windows/aruhan-cn.exe** | 72830464 |
| **windows/aruhan-desktop-arm64-cn.exe** | 38299648 |
| **windows/aruhan-desktop-cn.exe** | 44043264 |
| **windows/Aruhan-Desktop-Setup-2.1.34-cn.exe** | 33524655 |
| **windows/aruhan-desktop-windows-amd64-2.1.34-cn.zip** | 15561481 |
| **windows/aruhan-desktop-windows-arm64-2.1.34-cn.zip** | 13075258 |
| **windows/Aruhan-Setup-2.1.34-cn.exe** | 33537912 |
| **windows/aruhan-tui-installer-windows-amd64-cn.exe** | 76389376 |
| **windows/aruhan-tui-installer-windows-arm64-cn.exe** | 71437312 |
| **windows/aruhan-windows-amd64-2.1.34-cn.zip** | 29059069 |
| **windows/aruhan-windows-amd64-cn.exe** | 72830464 |
| **windows/aruhan-windows-arm64-2.1.34-cn.zip** | 26780104 |
| **windows/aruhan-windows-arm64-cn.exe** | 68076032 |
| **windows/factory-cn.exe** | 41264640 |
| **windows/Factory-Setup-2.1.34-cn.exe** | 34172751 |
| **windows/factory-windows-amd64-cn.exe** | 41264640 |
| **windows/factory-windows-arm64-cn.exe** | 37983744 |

## Notes / 说明

This build only allows models and media providers operated in mainland China.
Foreign model providers are filtered from the catalog, settings, and every
outbound request; there is no cross-edition fallback.
Updates are checked against Gitee Releases only.

本构建仅允许中国境内运营的模型与媒体供应商。
国外模型供应商会从目录、设置和所有对外请求中过滤，不存在跨发行版回退。
更新仅检查 Gitee Releases。

## Licensing / 授权

Official release builds include a 30-day evaluation period from the first run.
The first-run record is encrypted with a machine-bound key and anchored; deleting
it alone blocks startup. Continued use after the evaluation period,
commercial use, private/on-premises deployment, custom development, and
source-code or perpetual buyout require a separate written license.
Contact **37735973@qq.com**.

官方发布包包含从首次运行起算的 30 天评估期。首次运行记录使用机器绑定密钥加密
并保存锚点；只删除该记录会阻止启动。评估期结束后继续使用、商业使用、
私有化/本地部署、定制开发以及源码或永久买断，需要另行签署书面授权。
联系 **37735973@qq.com**。

See [LICENSE](LICENSE) and [DISCLAIMER.md](DISCLAIMER.md). Source code is not
published in this repository.
