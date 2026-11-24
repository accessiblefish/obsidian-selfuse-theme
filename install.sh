#!/usr/bin/env bash
# 把本主题安装到一个或多个 Obsidian 库中。
#
# 用法:
#   ./install.sh <库路径> [更多库路径...]     # 默认: 符号链接, git pull 后自动生效
#   ./install.sh --copy <库路径> [...]        # 复制文件, 与仓库脱钩
set -euo pipefail

THEME_NAME="Things"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="link"

usage() {
  cat <<EOF
用法: $(basename "$0") [--copy] <库路径> [更多库路径...]

把主题安装到指定 Obsidian 库的 .obsidian/themes/$THEME_NAME/ 下。

  --copy      复制 theme.css / manifest.json（默认创建符号链接，
              之后 git pull 更新主题无需重新安装）
  -h, --help  显示本说明
EOF
}

VAULTS=()
for arg in "$@"; do
  case "$arg" in
    --copy) MODE="copy" ;;
    -h|--help) usage; exit 0 ;;
    --*) echo "未知参数: $arg" >&2; usage; exit 1 ;;
    *) VAULTS+=("$arg") ;;
  esac
done

if [[ ${#VAULTS[@]} -eq 0 ]]; then
  usage
  exit 1
fi

for vault in "${VAULTS[@]}"; do
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
