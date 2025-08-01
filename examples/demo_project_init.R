# ============================================================================
# MassKitUtils - init_r_project 函数演示脚本
# ============================================================================
# 本脚本演示如何使用 init_r_project 函数创建标准化的R数据分析项目

# 加载包
library(MassKitUtils)

cat("=== MassKitUtils init_r_project 函数演示 ===\n\n")

# 示例1: 基本使用（所有默认设置）
cat("示例1: 基本使用（所有默认设置）\n")
cat("init_r_project()\n")
cat("这将创建：\n")
cat("- RStudio项目文件 (.Rproj)\n")
cat("- 标准目录结构 (data/raw, scripts, output, 等)\n")
cat("- 开发规范文档 (dev/design/)\n")
cat("- .gitignore文件\n\n")

# 示例2: 自定义设置
cat("示例2: 自定义设置\n")
cat("init_r_project(\n")
cat("  git = TRUE,                    # 初始化git仓库\n")
cat("  create_standards = FALSE,      # 不创建开发规范文档\n")
cat("  quiet = TRUE                   # 静默模式\n")
cat(")\n\n")

# 示例3: 最小化设置
cat("示例3: 最小化设置\n")
cat("init_r_project(\n")
cat("  rstudio = FALSE,               # 不创建RStudio项目文件\n")
cat("  create_standards = FALSE,      # 不创建开发规范文档\n")
cat("  create_gitignore = FALSE,      # 不创建.gitignore文件\n")
cat("  create_dirs = TRUE             # 只创建目录结构\n")
cat(")\n\n")

# 示例4: 完整设置（推荐用于新项目）
cat("示例4: 完整设置（推荐用于新项目）\n")
cat("init_r_project(\n")
cat("  git = TRUE,                    # 初始化git仓库\n")
cat("  create_gitignore = TRUE,       # 创建.gitignore文件\n")
cat("  create_standards = TRUE,       # 创建开发规范文档\n")
cat("  show_instructions = TRUE       # 显示使用说明\n")
cat(")\n\n")

# 示例5: 静默模式（适合脚本中使用）
cat("示例5: 静默模式（适合脚本中使用）\n")
cat("result <- init_r_project(\n")
cat("  quiet = TRUE,                  # 静默模式\n")
cat("  show_instructions = FALSE      # 不显示使用说明\n")
cat(")\n")
cat("print(result)  # 查看返回结果\n\n")

# 示例6: 覆盖现有文件
cat("示例6: 覆盖现有文件\n")
cat("init_r_project(\n")
cat("  overwrite = TRUE,              # 覆盖现有文件\n")
cat("  create_standards = TRUE,       # 重新创建开发规范文档\n")
cat("  create_gitignore = TRUE        # 重新创建.gitignore文件\n")
cat(")\n\n")

# 使用说明
cat("=== 使用说明 ===\n")
cat("1. 确保您在项目目录中（通过RStudio打开或手动设置工作目录）\n")
cat("2. 运行 init_r_project() 函数\n")
cat("3. 函数会自动：\n")
cat("   - 检测当前目录作为项目根目录\n")
cat("   - 使用目录名作为项目名称\n")
cat("   - 创建完整的项目结构\n")
cat("   - 提供详细的使用说明\n\n")

cat("=== 项目结构 ===\n")
cat("创建的项目将包含以下结构：\n")
cat("project_name/\n")
cat("├── project_name.Rproj          # RStudio项目文件\n")
cat("├── .gitignore                  # Git忽略文件\n")
cat("├── data/\n")
cat("│   ├── raw/                    # 原始数据\n")
cat("│   ├── processed/              # 处理后的数据\n")
cat("│   └── external/               # 外部参考数据\n")
cat("├── scripts/                    # 分析脚本\n")
cat("├── output/                     # 输出结果\n")
cat("├── config/                     # 配置文件\n")
cat("├── docs/                       # 文档\n")
cat("└── dev/\n")
cat("    └── design/                 # 开发规范文档\n")
cat("        ├── 01_overview.md\n")
cat("        ├── 02_coding_standards.md\n")
cat("        ├── 03_testing_standards.md\n")
cat("        ├── 04_documentation_standards.md\n")
cat("        ├── 05_git_workflow.md\n")
cat("        ├── 06_release_checklist.md\n")
cat("        └── templates/\n\n")

cat("=== 最佳实践 ===\n")
cat("1. 在开始新项目时使用完整设置\n")
cat("2. 在现有项目中可以只创建缺失的部分\n")
cat("3. 使用 here() 包进行路径管理\n")
cat("4. 遵循开发规范文档中的标准\n")
cat("5. 定期提交代码到版本控制系统\n\n")

cat("=== 演示完成 ===\n")
cat("现在您可以使用 init_r_project() 函数创建标准化的R数据分析项目了！\n") 