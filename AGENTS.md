# AGENTS.md

## 禁令

- 禁止读取或修改真实环境（如 Obsidian 库 `.obsidian/` 目录下）的文件；所有改动只在开发仓库内进行。
- 当用户反馈问题时，禁止将其归因于"真实环境没有同步"；必须先假设问题出在仓库代码本身并排查。

## CSS 审查

1. 修改 `theme.css` 后运行 `npm run lint:css`，处理 Stylelint 报告的全部问题。
2. 需要自动修复时运行 `npm run lint:css:fix`，检查 diff 确认样式改动符合预期，再运行 `npm run lint:css`。
3. 交付前确保 Stylelint 以退出码 0 结束且无剩余问题；确需调整规则时，在变更中说明原因。
