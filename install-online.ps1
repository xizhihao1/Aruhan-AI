<#
.SYNOPSIS
    Aruhan AI 智能助手 CLI 远程一键安装脚本 (Windows)

.DESCRIPTION
    自动检测 Windows 架构 (amd64/arm64), 从 Gitee release 下载对应 .zip
    并安装 aruhan.exe 到用户目录, 配置 PATH 与 ARUHAN_BINARY 环境变量。
    下载后自动通过 SHA256SUMS 校验安装包完整性。

    非交互, 无需管理员权限 (默认装到 $env:LOCALAPPDATA\Aruhan\CLI)。

.PARAMETER Version
    指定版本号 (如 v1.2.0), 默认自动获取最新 release。

.PARAMETER Prefix
    指定安装根目录, 默认 $env:LOCALAPPDATA\Aruhan。

.EXAMPLE
    # 一键安装 (PowerShell)
    irm https://gitee.com/guleng2005/Aruhan-AI/raw/master/install-online.ps1 | iex

.EXAMPLE
    # 指定版本
    .\install-online.ps1 -Version v2.0.1

.EXAMPLE
    # 指定安装目录
    .\install-online.ps1 -Prefix "C:\tools\aruhan"
#>

param(
    [string]$Version = "",
    [string]$Prefix  = ""
)

# --- 可配置常量 ---
$Owner   = "guleng2005"
$Repo    = "Aruhan-AI"
$DefaultVersion = "v2.1.24"
$BaseUrl = "https://gitee.com/$Owner/$Repo/releases/download"

# --- 颜色输出辅助 ---
function Write-Info($msg)  { Write-Host "[INFO]  $msg" -ForegroundColor Green }
function Write-Warn($msg)  { Write-Host "[WARN]  $msg" -ForegroundColor Yellow }
function Write-Err($msg)   { Write-Host "[ERROR] $msg" -ForegroundColor Red; exit 1 }

# --- 获取最新版本 tag ---
function Get-LatestTag {
    try {
        $resp = Invoke-RestMethod -Uri "https://gitee.com/api/v5/repos/$Owner/$Repo/releases/latest" -Method Get -ErrorAction Stop
        return $resp.tag_name
    } catch {
        return ""
    }
}

# --- 确定版本号 ---
if (-not $Version) {
    $Version = Get-LatestTag
    if (-not $Version) {
        $Version = $DefaultVersion
        Write-Warn "无法获取最新版本, 回退到 $Version"
    } else {
        Write-Info "检测到最新版本: $Version"
    }
}

# 规范化: 去掉前缀 v, 供文件名使用
$Ver = $Version.TrimStart('v')

# --- 架构检测 ---
$ArchRaw = $env:PROCESSOR_ARCHITECTURE
switch -Wildcard ($ArchRaw) {
    "AMD64"  { $Arch = "amd64" }
    "ARM64"  { $Arch = "arm64" }
    "x86"    { Write-Err "32 位 Windows 不支持, 请使用 64 位系统" }
    default  { Write-Err "不支持的架构: $ArchRaw (仅支持 amd64/arm64)" }
}

# --- 安装目录 ---
if (-not $Prefix) {
    $Prefix = Join-Path $env:LOCALAPPDATA "Aruhan"
}
# 与 aruhan-cli.nsi 的 InstallDir 保持一致（$LOCALAPPDATA\Aruhan\CLI）。
# 修复前这里是 "bin"，会与 CLI 包落在两个并列目录里，于是 PATH 中存在
# 两个同名 aruhan.exe，实际生效的取决于 PATH 顺序，卸载任一都会留残留。
$InstallDir = Join-Path $Prefix "CLI"
$BinName    = "aruhan.exe"

# --- 下载 ---
$ZipName = "aruhan-windows-$Arch-$Ver.zip"
$Url     = "$BaseUrl/$Version/$ZipName"
$TmpDir  = Join-Path ([System.IO.Path]::GetTempPath()) ("aruhan-install-" + [System.Guid]::NewGuid().ToString("N").Substring(0,8))

Write-Info "下载 Aruhan $Version (windows/$Arch) ..."
Write-Info "  URL: $Url"

try {
    New-Item -ItemType Directory -Force -Path $TmpDir | Out-Null
    $ZipPath = Join-Path $TmpDir $ZipName
    # 使用 WebClient 下载 (兼容旧版 PowerShell, 支持进度)
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($Url, $ZipPath)
} catch {
    Write-Err "下载失败: $Url`n$($_.Exception.Message)"
}

# --- 校验 SHA256 (下载同 Release 的 SHA256SUMS 比对) ---
$SumsUrl = "$BaseUrl/$Version/SHA256SUMS"
$SumsPath = Join-Path $TmpDir "SHA256SUMS"
try {
    $wc.DownloadFile($SumsUrl, $SumsPath)
} catch {
    Write-Err "下载失败: $SumsUrl`n$($_.Exception.Message)"
}
$SumsLine = Get-Content $SumsPath | Where-Object { $_ -match ([regex]::Escape($ZipName) + '$') } | Select-Object -First 1
if (-not $SumsLine) { Write-Err "SHA256SUMS 中没有 $ZipName 的校验条目" }
$ExpectedHash = (($SumsLine -split '\s+')[0]).ToLower()
$ActualHash = (Get-FileHash -Algorithm SHA256 $ZipPath).Hash.ToLower()
if ($ActualHash -ne $ExpectedHash) { Write-Err "SHA256 校验失败: 期望 $ExpectedHash, 实际 $ActualHash" }
Write-Info "SHA256 校验通过: $ActualHash"

# --- 解压 ---
Write-Info "解压 ..."
try {
    Expand-Archive -Path $ZipPath -DestinationPath $TmpDir -Force
} catch {
    Write-Err "解压失败: $($_.Exception.Message)"
}

# 定位二进制 (优先 aruhan.exe, 兜底 aruhan-windows-*.exe)
$SrcBin = Join-Path $TmpDir "aruhan.exe"
if (-not (Test-Path $SrcBin)) {
    $candidate = Get-ChildItem -Path $TmpDir -Filter "aruhan-windows-*.exe" -File | Select-Object -First 1
    if ($candidate) { $SrcBin = $candidate.FullName }
}
if (-not (Test-Path $SrcBin)) {
    Write-Err "压缩包内未找到 aruhan.exe"
}

# --- 旧目录迁移 (2026-10-24) ---
# 早期版本装到 $Prefix\bin。改成 $Prefix\CLI 后，老用户升级会在这个新目录里
# 再装一份，而旧的 bin 目录和它的 PATH 条目会一直留着，于是 PATH 中同时存在
# 两个 aruhan.exe。这里把本脚本自己写进去的文件迁走，并移除旧 PATH 条目。
# 安全约束：只动 aruhan.exe / VERSION / models.json 这三个已知文件；目录里若还
# 有其它东西就保留整个目录并提示，绝不递归删除。
$LegacyDir = Join-Path $Prefix "bin"
if ((Test-Path $LegacyDir) -and -not [string]::Equals($LegacyDir.TrimEnd([char]'\'), $InstallDir.TrimEnd([char]'\'), [StringComparison]::OrdinalIgnoreCase)) {
    $migrated = 0
    foreach ($f in @("aruhan.exe", "VERSION", "models.json")) {
        $legacyFile = Join-Path $LegacyDir $f
        if (Test-Path $legacyFile) {
            try {
                if (-not (Test-Path $InstallDir)) {
                    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
                }
                Move-Item -Path $legacyFile -Destination (Join-Path $InstallDir $f) -Force
                $migrated++
            } catch {
                Write-Warn "迁移失败: $legacyFile -> $InstallDir ($($_.Exception.Message))"
            }
        }
    }

    # 从用户 PATH 移除旧条目（按分段完整路径比较，不用子串匹配）
    $legacyUserPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($legacyUserPath) {
        $legacyTrim = $LegacyDir.TrimEnd([char]'\')
        $keptSegments = @($legacyUserPath -split ';' | Where-Object {
            $_ -and -not [string]::Equals($_.Trim().TrimEnd([char]'\'), $legacyTrim, [StringComparison]::OrdinalIgnoreCase)
        })
        $rebuiltUserPath = $keptSegments -join ';'
        if ($rebuiltUserPath -ne $legacyUserPath) {
            [Environment]::SetEnvironmentVariable("Path", $rebuiltUserPath, "User")
            Write-Info "已从用户 PATH 移除旧目录 $LegacyDir"
        }
    }

    # 目录空了才删，有其它文件则保留
    $legacyRemain = @(Get-ChildItem -Path $LegacyDir -Force -ErrorAction SilentlyContinue)
    if ($legacyRemain.Count -eq 0) {
        Remove-Item -Path $LegacyDir -Force -ErrorAction SilentlyContinue
        Write-Info "已清理空目录 $LegacyDir"
    } else {
        $legacyNames = ($legacyRemain | Select-Object -ExpandProperty Name) -join ', '
        Write-Warn "$LegacyDir 中还有非本安装器写入的文件，已保留目录: $legacyNames"
    }

    if ($migrated -gt 0) {
        Write-Info "已从 $LegacyDir 迁移 $migrated 个文件到 $InstallDir"
    }
}

# --- 冲突检测 ---
# 三种 Windows 安装方式落在三个不同目录：
#   install-online.ps1    -> %LOCALAPPDATA%\Aruhan\CLI   （与 aruhan-cli.nsi 一致）
#   aruhan-cli.nsi        -> %LOCALAPPDATA%\Aruhan\CLI
#   aruhan-installer.nsi  -> %LOCALAPPDATA%\Aruhan
# 混装会让 PATH 里出现多个同名 aruhan.exe，实际生效哪一个取决于 PATH 顺序，
# 而且卸载其中一个会留下另一个。这里只告警、不阻断安装：并存可能是用户有意的。
$otherInstalls = @(
    (Join-Path $env:LOCALAPPDATA "Aruhan\CLI\aruhan.exe"),
    (Join-Path $env:LOCALAPPDATA "Aruhan\aruhan.exe"),
    (Join-Path $env:LOCALAPPDATA "aruhan\aruhan.exe")
) | Where-Object { (Test-Path $_) -and ((Split-Path $_ -Parent) -ne $InstallDir) }
if ($otherInstalls) {
    Write-Warn "检测到其他位置的 Aruhan 安装:"
    foreach ($p in $otherInstalls) { Write-Warn "  $p" }
    Write-Warn "继续安装会让 PATH 中出现多个 aruhan.exe，实际生效的取决于 PATH 顺序。"
    Write-Warn "建议先在「设置 > 应用 > Aruhan」卸载旧版本，再执行本安装。"
}

# --- 安装 ---
Write-Info "安装到 $InstallDir ..."
try {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
    # 覆盖前停掉旧进程 (升级场景)
    Get-Process -Name "aruhan" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Copy-Item -Path $SrcBin -Destination (Join-Path $InstallDir $BinName) -Force

    # 复制 VERSION 文件 (供运行时版本回退)
    $verFile = Join-Path $TmpDir "VERSION"
    if (Test-Path $verFile) {
        Copy-Item -Path $verFile -Destination (Join-Path $InstallDir "VERSION") -Force -ErrorAction SilentlyContinue
    }
} catch {
    Write-Err "安装失败: $($_.Exception.Message)"
} finally {
    # 清理临时目录
    Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue
}

# --- 配置 PATH (用户级, 持久化) ---
# 按 ";" 分段做完整路径比较（忽略大小写与尾分隔符）。
# 原实现用 -notlike "*$InstallDir*" 子串匹配，会把 ...\aruhan 误判为
# ...\aruhan-desktop 的前缀，导致目录未写入 PATH 却报告"已包含"。
$targetDir = $InstallDir.TrimEnd([char]'\')
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$alreadyInPath = $false
if ($userPath) {
    foreach ($entry in ($userPath -split ';')) {
        if ($entry -ne '' -and $entry.TrimEnd([char]'\') -ieq $targetDir) {
            $alreadyInPath = $true
            break
        }
    }
}
if (-not $alreadyInPath) {
    $newPath = if ($userPath) { "$userPath;$InstallDir" } else { $InstallDir }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Info "已将 $InstallDir 添加到用户 PATH (新终端生效)"
} else {
    Write-Info "PATH 已包含 $InstallDir"
}

# --- 配置 ARUHAN_BINARY (用户级, 持久化) ---
[Environment]::SetEnvironmentVariable("ARUHAN_BINARY", (Join-Path $InstallDir $BinName), "User")
Write-Info "已设置 ARUHAN_BINARY = $(Join-Path $InstallDir $BinName)"

# 当前会话立即生效
$env:Path = "$InstallDir;$env:Path"
$env:ARUHAN_BINARY = Join-Path $InstallDir $BinName

# --- 完成 ---
Write-Info "Aruhan $Version 已安装到 $(Join-Path $InstallDir $BinName)"
Write-Info "运行 'aruhan --version' 验证 (新终端会自动加载 PATH)"
