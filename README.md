### Notes of this theme

This theme was built using code from Things theme.

## 在其他电脑上使用

仓库自带 `install.sh`，克隆后一条命令即可装到任意 Obsidian 库：

```bash
git clone git@github.com:accessiblefish/obsidian-selfuse-theme.git
cd obsidian-selfuse-theme
./install.sh /path/to/你的库            # 可跟多个库路径
```

默认用符号链接安装，之后在仓库目录里 `git pull` 更新主题，所有库自动生效，无需重新安装。Windows 或不想依赖仓库位置时用 `./install.sh --copy ...` 改为复制文件（更新需重跑一次）。

安装后在 Obsidian 中启用：**设置 → 外观 → 主题 → Things**。

也可以不用脚本：直接把整个仓库 clone 到 `<库>/.obsidian/themes/Things/`（目录名随意），效果相同。

## 开发

修改 `theme.css` 后运行 `npm run lint:css`，确保 Stylelint 通过再提交，详见 `AGENTS.md`。
