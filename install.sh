#!/usr/bin/env bash
# 把本主题复制到 Obsidian 库中。
#
# 使用方法: 在下方 VAULT_PATHS 里填入你的库路径, 然后直接运行 ./install.sh
set -euo pipefail

# ========== 在这里填入你的 Obsidian 库路径 (可填多个) ==========
VAULT_PATHS=(
  # "/path/to/你的库"
  # "/path/to/另一个库"
)
# ==============================================================

THEME_NAME="Tuse"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ${#VAULT_PATHS[@]} -eq 0 ]]; then
  echo "请先在脚本顶部 VAULT_PATHS 中填入你的 Obsidian 库路径。" >&2
  exit 1
fi

for vault in "${VAULT_PATHS[@]}"; do
  if [[ ! -d "$vault" ]]; then
    echo "跳过: $vault 不存在" >&2
    continue
  fi
  dest="$vault/.obsidian/themes/$THEME_NAME"
  mkdir -p "$dest"
  cp "$SRC_DIR/theme.css" "$SRC_DIR/manifest.json" "$dest/"
  echo "已安装: $dest"
done

cat <<EOF

接下来在 Obsidian 中启用:
  设置 → 外观 → 主题 → 选择 "$THEME_NAME"
EOF
