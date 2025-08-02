# ============================================================================
# MassKitUtils - create_project_standards 函数演示脚本
# ============================================================================
# 本脚本演示如何使用 create_project_standards 函数创建数据分析项目规范文档

# 加载包
library(MassKitUtils)

cat("=== MassKitUtils create_project_standards 函数演示 ===\n\n")

# 示例1: 基本使用（默认设置）
cat("示例1: 基本使用（默认设置）\n")
cat("create_project_standards()\n")
cat("这将创建：\n")
cat("- 01_overview.md (项目概述)\n")
cat("- 02_data_workflow.md (数据工作流程)\n")
cat("- 03_analysis_standards.md (分析标准)\n")
cat("- 04_reproducibility.md (可重现性规范)\n")
cat("- templates/ (项目模板)\n\n")

# 示例2: 自定义项目名称
cat("示例2: 自定义项目名称\n")
cat("create_project_standards(project_name = \"MyAnalysisProject\")\n")
cat("这将在文档中包含项目名称信息\n\n")

# 示例3: 自定义输出目录
cat("示例3: 自定义输出目录\n")
cat("create_project_standards(\"./docs/project_standards\")\n")
cat("这将在指定目录创建规范文档\n\n")

# 示例4: 覆盖现有文件
cat("示例4: 覆盖现有文件\n")
cat("create_project_standards(overwrite = TRUE)\n")
cat("这将覆盖已存在的规范文档\n\n")

# 使用说明
cat("=== 使用说明 ===\n")
cat("1. 确保您在项目目录中（通过RStudio打开或手动设置工作目录）\n")
cat("2. 运行 create_project_standards() 函数\n")
cat("3. 函数会自动创建完整的项目规范文档\n")
cat("4. 查看生成的文档，了解项目开发规范\n\n")

cat("=== 生成的文档结构 ===\n")
cat("dev/design/\n")
cat("├── 01_overview.md              # 项目概述和基本原则\n")
cat("├── 02_data_workflow.md         # 数据工作流程规范\n")
cat("├── 03_analysis_standards.md    # 分析标准和代码规范\n")
cat("├── 04_reproducibility.md       # 可重现性和环境管理\n")
cat("└── templates/                  # 项目模板\n")
cat("    ├── data_dictionary_template.md    # 数据字典模板\n")
cat("    ├── analysis_report_template.md    # 分析报告模板\n")
cat("    ├── script_template.R              # 脚本模板\n")
cat("    └── config_template.R              # 配置文件模板\n\n")

cat("=== 文档内容特点 ===\n")
cat("1. 中文内容为主，适合国内数据分析师\n")
cat("2. 实用性强，包含具体示例和模板\n")
cat("3. 与 init_r_project() 创建的目录结构配合\n")
cat("4. 专注于数据分析项目的核心需求\n\n")

cat("=== 最佳实践 ===\n")
cat("1. 在项目开始时创建规范文档\n")
cat("2. 团队成员共同遵循规范\n")
cat("3. 定期更新和完善规范\n")
cat("4. 使用提供的模板提高效率\n\n")

cat("=== 演示完成 ===\n")
cat("现在您可以使用 create_project_standards() 函数创建数据分析项目规范文档了！\n") 