#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# install-online.sh — Aruhan 远程一键安装脚本
#
# 用途: Aruhan AI 智能助手 CLI 远程一键安装入口。自动检测平台/架构,
#       从 Gitee release 下载对应 tar.gz 并安装 aruhan 到 PATH。
#
# 用法:
#   curl -sSL https://gitee.com/guleng2005/Aruhan-AI/releases/download/v1.1.0/install-online.sh | bash
#   bash install-online.sh                          # 默认安装到 ~/.local/bin
#   bash install-online.sh --prefix=/usr/local      # 指定安装目录
#   bash install-online.sh --version=v1.2.0         # 指定版本 (默认 v1.1.0)
#
# 说明:
#   - 非交互, 无需 sudo (默认装到用户目录 ~/.local/bin)
#   - 下载用 curl (回退 wget), 解压 tar.gz, 复制二进制为 aruhan
#   - 自动配置 PATH 与 ARUHAN_BINARY 环境变量 (写入 shell profile)
#   - 幂等: 重复执行会覆盖旧版本
# ---------------------------------------------------------------------------
set -euo pipefail

# --- 可配置常量 ---
OWNER="guleng2005"
REPO="Aruhan-AI"
DEFAULT_VERSION="v1.1.0"
# Gitee release 下载基础 URL (若 Gitee 实际 URL 格式不同, 改这里)
BASE_URL="https://gitee.com/${OWNER}/${REPO}/releases/download"

# --- 颜色输出 ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; exit 1; }

# get_latest_tag 通过 Gitee API 获取最新 release 的 tag_name。
# 失败时输出空串, 由调用方回退到 DEFAULT_VERSION。
get_latest_tag() {
    curl -fsSL "https://gitee.com/api/v5/repos/${OWNER}/${REPO}/releases/latest" 2>/dev/null \
        | grep -o '"tag_name":"[^"]*"' | head -1 | sed 's/"tag_name":"//; s/"$//'
}

# --- 参数解析 ---
VERSION=""          # 空 = 自动获取最新版本
PREFIX=""
for arg in "$@"; do
    case "$arg" in
        --version=*) VERSION="${arg#*=}" ;;
        --prefix=*)  PREFIX="${arg#*=}" ;;
        -h|--help)
            sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
            exit 0
            ;;
        *) error "Unknown argument: $arg (use --help)" ;;
    esac
done

# --- 确定版本号 (未显式指定时自动取最新) ---
if [[ -z "$VERSION" ]]; then
    VERSION="$(get_latest_tag)"
    if [[ -z "$VERSION" ]]; then
        VERSION="$DEFAULT_VERSION"
        warn "无法获取最新版本，回退到 $VERSION"
    else
        info "检测到最新版本: $VERSION"
    fi
fi

# 规范化版本号: 去掉前缀 v, 供 tar.gz 文件名使用
VER="${VERSION#v}"

# --- 平台/架构检测 ---
OS_NAME="$(uname -s)"
case "$OS_NAME" in
    Linux)  OS="linux" ;;
    Darwin) OS="darwin" ;;
    *)      error "Unsupported OS: $OS_NAME (only Linux/macOS supported)" ;;
esac

ARCH_RAW="$(uname -m)"
case "$ARCH_RAW" in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *) error "Unsupported architecture: $ARCH_RAW (only amd64/arm64 supported)" ;;
esac

# --- 默认安装目录 ---
if [[ -z "$PREFIX" ]]; then
    PREFIX="$HOME/.local"
fi
INSTALL_DIR="${PREFIX}/bin"
BIN_NAME="aruhan"

# --- 下载 ---
TARBALL="aruhan-${OS}-${ARCH}-${VER}.tar.gz"
URL="${BASE_URL}/${VERSION}/${TARBALL}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

info "Downloading Aruhan ${VERSION} (${OS}/${ARCH}) ..."
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$URL" -o "$TMP/$TARBALL" || error "Download failed: $URL"
elif command -v wget >/dev/null 2>&1; then
    wget -q "$URL" -O "$TMP/$TARBALL" || error "Download failed: $URL"
else
    error "Neither curl nor wget found. Install one of them first."
fi

# --- 解压 ---
info "Extracting ..."
tar xzf "$TMP/$TARBALL" -C "$TMP"
PKG_DIR="$TMP/aruhan-${OS}-${ARCH}"
SRC_BIN="${PKG_DIR}/aruhan-${OS}-${ARCH}"
if [[ ! -f "$SRC_BIN" ]]; then
    # 兜底: 包内二进制名可能是 aruhan
    SRC_BIN="${PKG_DIR}/aruhan"
fi
[[ -f "$SRC_BIN" ]] || error "Binary not found in archive (expected ${SRC_BIN})"

# --- 安装 ---
info "Installing to ${INSTALL_DIR} ..."
mkdir -p "$INSTALL_DIR" || error "Cannot create ${INSTALL_DIR}"
# 覆盖前停掉旧进程 (升级场景)
pkill -x aruhan 2>/dev/null || true
cp "$SRC_BIN" "${INSTALL_DIR}/${BIN_NAME}"
chmod +x "${INSTALL_DIR}/${BIN_NAME}"

# 复制 VERSION 文件 (供 aruhan 运行时版本回退)
if [[ -f "${PKG_DIR}/VERSION" ]]; then
    cp "${PKG_DIR}/VERSION" "${INSTALL_DIR}/VERSION" 2>/dev/null || true
fi

# --- 配置 PATH 与 ARUHAN_BINARY ---
configure_shell() {
    local rc="$1"
    [[ -f "$rc" ]] || return 0
    # PATH
    if ! grep -q "${INSTALL_DIR}" "$rc" 2>/dev/null; then
        printf '\n# Aruhan (added by install-online.sh)\nexport PATH="%s:$PATH"\n' "$INSTALL_DIR" >> "$rc"
    fi
    # ARUHAN_BINARY — 供 VSCode 插件 / dsh 等客户端定位引擎
    if ! grep -q "ARUHAN_BINARY" "$rc" 2>/dev/null; then
        printf 'export ARUHAN_BINARY="%s/%s"\n' "$INSTALL_DIR" "$BIN_NAME" >> "$rc"
    fi
}

configure_shell "$HOME/.bashrc"
configure_shell "$HOME/.zshrc"
configure_shell "$HOME/.profile"

# 当前会话立即生效 (非交互场景下也有用)
export PATH="${INSTALL_DIR}:${PATH}"
export ARUHAN_BINARY="${INSTALL_DIR}/${BIN_NAME}"

# --- 完成 ---
info "Aruhan ${VERSION} installed to ${INSTALL_DIR}/${BIN_NAME}"
info "Run 'aruhan --version' to verify (new shells will pick up PATH automatically)."
