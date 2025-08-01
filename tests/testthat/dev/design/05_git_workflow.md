# Git工作流标准

## 分支策略

### 主要分支
- `main`: 生产分支，稳定版本
- `develop`: 开发分支，集成新功能

### 功能分支
- `feature/功能名称`: 新功能开发
- `bugfix/问题描述`: 错误修复
- `hotfix/紧急修复`: 紧急修复

## 提交规范

### 提交信息格式
```
type(scope): subject

body

footer
```

### 类型说明
- `feat`: 新功能
- `fix`: 错误修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

### 示例
```
feat(package): add new export_to_excel function

Add comprehensive Excel export functionality with formatting options.
Includes header styles, table styles, and customizable colors.

Closes #123
```

## 工作流程

### 功能开发流程
1. 从`develop`分支创建功能分支
2. 在功能分支上开发
3. 提交代码并推送到远程
4. 创建Pull Request
5. 代码审查
6. 合并到`develop`分支

### 发布流程
1. 从`develop`分支创建发布分支
2. 版本号更新和文档完善
3. 测试和修复
4. 合并到`main`和`develop`
5. 创建版本标签

## 代码审查

### 审查要点
- 代码质量和风格
- 功能正确性
- 测试覆盖率
- 文档完整性
- 性能影响

### 审查流程
1. 自动检查通过
2. 至少一名审查者批准
3. 所有讨论已解决
4. 合并代码

## 版本管理

### 版本号格式
使用语义化版本号: `MAJOR.MINOR.PATCH`
- MAJOR: 不兼容的API修改
- MINOR: 向下兼容的功能性新增
- PATCH: 向下兼容的问题修正

### 标签命名
- 版本标签: `v1.0.0`
- 预发布标签: `v1.0.0-rc.1`
- 开发版本: `v1.0.0-dev`

## 持续集成

### GitHub Actions
- 自动运行测试
- 代码质量检查
- 文档构建
- 包构建和检查

### 检查项目
- R CMD check
- 测试覆盖率
- 代码风格检查
- 文档完整性

## 最佳实践

### 提交频率
- 频繁提交，小步快跑
- 每次提交解决一个问题
- 保持提交信息清晰

### 分支管理
- 及时删除已合并分支
- 保持分支命名一致
- 避免长期分支

### 冲突解决
- 优先在本地解决冲突
- 使用合适的合并策略
- 保持代码历史清晰

## 工具配置

### Git配置
```bash
git config --global init.defaultBranch main
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 钩子脚本
- pre-commit: 代码格式检查
- pre-push: 测试运行
- commit-msg: 提交信息格式检查

