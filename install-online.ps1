<#
.SYNOPSIS
    Aruhan AI 智能助手 CLI 远程一键安装脚本 (Windows)

.DESCRIPTION
    自动检测 Windows 架构 (amd64/arm64), 从 Gitee release 下载对应 .zip
    并安装 aruhan.exe 到用户目录, 配置 PATH 与 ARUHAN_BINARY 环境变量。

    非交互, 无需管理员权限 (默认装到 $env:LOCALAPPDATA\Aruhan\bin)。

.PARAMETER Version
    指定版本号 (如 v1.2.0), 默认自动获取最新 release。

.PARAMETER Prefix
    指定安装根目录, 默认 $env:LOCALAPPDATA\Aruhan。

.EXAMPLE
    # 一键安装 (PowerShell)
    irm https://gitee.com/guleng2005/Aruhan-AI/raw/master/install-online.ps1 | iex

.EXAMPLE
    # 指定版本
    .\install-online.ps1 -Version v1.1.0

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
$DefaultVersion = "v1.1.0"
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
$InstallDir = Join-Path $Prefix "bin"
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
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$InstallDir*") {
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
