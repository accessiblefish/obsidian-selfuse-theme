#!/usr/bin/env bash
# 把本主题安装到 Obsidian 库中。
#
# 使用方法: 在下方 VAULT_PATHS 里填入你的库路径, 然后直接运行 ./install.sh
set -euo pipefail

# ========== 在这里填入你的 Obsidian 库路径 (可填多个) ==========
VAULT_PATHS=(
  # "/path/to/你的库"
  # "/path/to/另一个库"
)
# ==============================================================

THEME_NAME="Things"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="copy"   # copy = 复制文件; link = 符号链接 (git pull 后自动生效)

usage() {
  cat <<EOF
用法: 在脚本顶部 VAULT_PATHS 中填入库路径, 然后运行 $(basename "$0")

也可以用命令行参数临时指定库 (优先级高于 VAULT_PATHS):
  $(basename "$0") [--link] <库路径> [更多库路径...]

  --link      用符号链接代替复制 (之后 git pull 更新主题无需重新安装)
  -h, --help  显示本说明
EOF
}

CLI_VAULTS=()
for arg in "$@"; do
  case "$arg" in
    --link) MODE="link" ;;
    --copy) MODE="copy" ;;
    -h|--help) usage; exit 0 ;;
    --*) echo "未知参数: $arg" >&2; usage; exit 1 ;;
    *) CLI_VAULTS+=("$arg") ;;
  esac
done

if [[ ${#CLI_VAULTS[@]} -gt 0 ]]; then
  VAULT_PATHS=("${CLI_VAULTS[@]}")
fi

if [[ ${#VAULT_PATHS[@]} -eq 0 ]]; then
  echo "请先在脚本顶部 VAULT_PATHS 中填入你的 Obsidian 库路径。" >&2
  usage
  exit 1
fi

for vault in "${VAULT_PATHS[@]}"; do
  if [[ ! -d "$vault" ]]; then
    echo "跳过: $vault 不存在" >&2
    continue
  fi
  dest="$vault/.obsidian/themes/$THEME_NAME"
  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  if [[ "$MODE" == "copy" ]]; then
    mkdir -p "$dest"
    cp "$SRC_DIR/theme.css" "$SRC_DIR/manifest.json" "$dest/"
  else
    ln -s "$SRC_DIR" "$dest"
  fi
  echo "已安装 ($MODE): $dest"
done

cat <<EOF

接下来在 Obsidian 中启用:
  设置 → 外观 → 主题 → 选择 "$THEME_NAME"
EOF
