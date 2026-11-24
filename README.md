### Notes of this theme

This theme was built using code from Things theme.

## 在其他电脑上使用

仓库自带 `install.sh`。克隆后用编辑器打开脚本，在顶部 `VAULT_PATHS` 里填入你的库路径（可填多个），保存后直接运行：

```bash
git clone git@github.com:accessiblefish/obsidian-selfuse-theme.git
cd obsidian-selfuse-theme
# 编辑 install.sh, 在 VAULT_PATHS 中填入库路径
./install.sh
```

默认复制 `theme.css` / `manifest.json` 到每个库的 `.obsidian/themes/Things/` 下，与仓库位置脱钩（更新主题后重跑一次即可）。也可以用 `./install.sh --link <库路径>` 临时改为符号链接安装，之后 `git pull` 更新自动生效。

安装后在 Obsidian 中启用：**设置 → 外观 → 主题 → Things**。

也可以不用脚本：直接把整个仓库 clone 到 `<库>/.obsidian/themes/Things/`（目录名随意），效果相同。

## 开发

修改 `theme.css` 后运行 `npm run lint:css`，确保 Stylelint 通过再提交，详见 `AGENTS.md`。
