# 开发工具函数

#' Create R Package Development Standards Documentation
#'
#' This function automatically creates comprehensive R package development
#' standards documentation in a specified directory. It creates a complete
#' set of development guidelines, templates, and best practices.
#'
#' @author Songbiao Zhu \email{zhusongbiao@cimrbj.ac.cn}
#'
#' @param output_dir Character string for the output directory (default: "./dev/design")
#' @param project_name Character string for the project name (optional)
#' @param overwrite Logical, whether to overwrite existing files (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create standards documentation in default location
#' create_dev_standards()
#'
#' # Create with custom package name
#' create_dev_standards(package_name = "MyPackage")
#'
#' # Create in custom directory
#' create_dev_standards("./docs/standards")
#' }
create_dev_standards <- function(output_dir = "./dev/design", 
                                 package_name = NULL, 
                                 overwrite = FALSE) {
  # 参数验证
  if (is.null(output_dir) || (is.character(output_dir) && length(output_dir) == 1 && output_dir == "")) {
    stop("Parameter 'output_dir' is required and cannot be empty")
  }
  
  if (!is.character(output_dir) || length(output_dir) != 1) {
    stop("Parameter 'output_dir' must be a character vector of length 1")
  }
  
  # 确保输出目录存在
  ensure_directory(output_dir)
  
  # 生成各种文档
  generate_overview_doc(output_dir, package_name, overwrite)
  generate_coding_standards(output_dir, package_name, overwrite)
  generate_testing_standards(output_dir, package_name, overwrite)
  generate_documentation_standards(output_dir, package_name, overwrite)
  generate_git_workflow(output_dir, package_name, overwrite)
  generate_release_checklist(output_dir, package_name, overwrite)
  generate_templates(output_dir, package_name, overwrite)
  
  # 静默模式，不输出消息
  # message("R package development standards documentation generated successfully!")
  # message("Location: ", output_dir)
  # message("Files created:")
  # message("- 01_overview.md")
  # message("- 02_coding_standards.md")
  # message("- 03_testing_standards.md")
  # message("- 04_documentation_standards.md")
  # message("- 05_git_workflow.md")
  # message("- 06_release_checklist.md")
  # message("- templates/")
  
  invisible(NULL)
}

#' Generate Overview Documentation
#' @keywords internal
generate_overview_doc <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# R Package Development Standards Overview\n\n",
    if (!is.null(package_name)) paste0("## Package: ", package_name, "\n\n") else "",
    "## 概述\n\n",
    "本文档定义了R包开发的标准和最佳实践，确保代码质量、可维护性和一致性。\n\n",
    "## 核心原则\n\n",
    "1. **单一职责原则**: 每个函数只做一件事\n",
    "2. **接口一致性**: 函数参数和返回值保持一致的命名和结构\n",
    "3. **渐进式复杂度**: 从简单到复杂，逐步构建功能\n",
    "4. **错误处理**: 提供清晰的错误信息和处理机制\n",
    "5. **文档完整性**: 每个函数都有完整的文档和示例\n\n",
    "## 目录结构\n\n",
    "```\n",
    "package_name/\n",
    "├── R/                    # R源代码文件\n",
    "├── man/                  # 自动生成的帮助文档\n",
    "├── tests/                # 测试文件\n",
    "├── vignettes/            # 包文档和教程\n",
    "├── inst/                 # 安装时包含的文件\n",
    "├── data/                 # 包内置数据\n",
    "├── data-raw/             # 原始数据处理脚本\n",
    "├── docs/                 # 项目文档\n",
    "├── .github/              # GitHub配置\n",
    "├── DESCRIPTION           # 包描述文件\n",
    "├── NAMESPACE             # 命名空间文件\n",
    "├── LICENSE.md            # 开源许可证\n",
    "├── README.md             # 项目说明\n",
    "└── NEWS.md               # 版本更新日志\n",
    "```\n\n",
    "## 文件命名规范\n\n",
    "- R文件按功能模块编号: `01_package_management.R`, `05_project_management.R`\n",
    "- 测试文件: `test-function_name.R`\n",
    "- 文档文件: 使用描述性名称\n\n",
    "## 版本控制\n\n",
    "- 使用Git进行版本控制\n",
    "- 默认分支: `main`\n",
    "- 开发分支: `develop`\n",
    "- 功能分支: `feature/功能名称`\n",
    "- 修复分支: `bugfix/问题描述`\n\n",
    "## 质量保证\n\n",
    "- 所有代码必须通过R CMD check\n",
    "- 测试覆盖率 > 80%\n",
    "- 符合CRAN政策要求\n",
    "- 使用GitHub Actions进行CI/CD\n\n",
    "## 相关文档\n\n",
    "- [编码标准](02_coding_standards.md)\n",
    "- [测试标准](03_testing_standards.md)\n",
    "- [文档标准](04_documentation_standards.md)\n",
    "- [Git工作流](05_git_workflow.md)\n",
    "- [发布检查清单](06_release_checklist.md)\n"
  )
  
  write_if_not_exists(file.path(output_dir, "01_overview.md"), content, overwrite)
}

#' Generate Coding Standards Documentation
#' @keywords internal
generate_coding_standards <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# R包编码标准\n\n",
    "## 命名规范\n\n",
    "### 函数命名\n",
    "- 使用`snake_case`命名法\n",
    "- 动词开头，描述函数功能\n",
    "- 示例: `ensure_packages`, `setup_analysis_structure`, `export_to_excel`\n\n",
    "### 变量命名\n",
    "- 使用`snake_case`命名法\n",
    "- 描述性名称，避免缩写\n",
    "- 示例: `package_names`, `output_directory`, `data_frame`\n\n",
    "### 常量命名\n",
    "- 使用`UPPER_SNAKE_CASE`\n",
    "- 示例: `DEFAULT_FONT_SIZE`, `MAX_RETRY_ATTEMPTS`\n\n",
    "### 内部函数命名\n",
    "- 以`.`开头，表示内部函数\n",
    "- 示例: `.validate_parameters`, `.apply_style`\n\n",
    "## 代码结构\n\n",
    "### 函数结构\n",
    "```r\n",
    "# 分节注释\n",
    "#' 函数标题\n",
    "#'\n",
    "#' 函数描述\n",
    "#'\n",
    "#' @param param1 参数描述\n",
    "#' @param param2 参数描述\n",
    "#' @return 返回值描述\n",
    "#' @export\n",
    "#' @examples\n",
    "#' \\dontrun{\n",
    "#' # 使用示例\n",
    "#' }\n",
    "function_name <- function(param1, param2 = default_value) {\n",
    "  # 参数验证\n",
    "  if (missing(param1) || is.null(param1)) {\n",
    "    stop(\"Parameter 'param1' is required and cannot be empty\")\n",
    "  }\n",
    "  \n",
    "  # 主要逻辑\n",
    "  result <- process_data(param1, param2)\n",
    "  \n",
    "  # 返回结果\n",
    "  return(result)\n",
    "}\n",
    "```\n\n",
    "## 注释规范\n\n",
    "### 分节注释\n",
    "- 使用单行注释格式: `# 分节名称 ===`\n",
    "- 便于IDE显示和导航，支持代码折叠\n",
    "- 示例: `# 包管理函数 ===`, `# 参数验证 ===`\n\n",
    "### 行内注释\n",
    "- 解释复杂逻辑\n",
    "- 说明算法步骤\n",
    "- 避免显而易见的注释\n\n",
    "## 错误处理\n\n",
    "### 错误信息\n",
    "- 使用英文错误信息（符合CRAN标准）\n",
    "- 清晰描述问题\n",
    "- 提供解决建议\n\n",
    "### 错误类型\n",
    "- `stop()`: 严重错误，函数无法继续\n",
    "- `warning()`: 警告，函数可以继续但结果可能不准确\n",
    "- `message()`: 信息性消息\n\n",
    "## 性能优化\n\n",
    "### 向量化\n",
    "- 优先使用向量化操作\n",
    "- 避免循环，使用`apply`族函数\n",
    "- 使用`data.table`处理大数据\n\n",
    "### 内存管理\n",
    "- 及时清理大型对象\n",
    "- 使用`gc()`进行垃圾回收\n",
    "- 避免内存泄漏\n\n",
    "## 代码风格\n\n",
    "### 缩进\n",
    "- 使用2个空格缩进\n",
    "- 保持一致的缩进风格\n\n",
    "### 行长度\n",
    "- 每行不超过80个字符\n",
    "- 长行适当换行\n\n",
    "### 空格\n",
    "- 操作符前后加空格\n",
    "- 逗号后加空格\n",
    "- 函数调用括号内不加空格\n\n",
    "## 依赖管理\n\n",
    "### 包依赖\n",
    "- 在DESCRIPTION中明确声明依赖\n",
    "- 使用版本号限制依赖范围\n",
    "- 避免循环依赖\n\n",
    "### 导入策略\n",
    "- 优先使用`::`操作符\n",
    "- 避免`library()`和`require()`\n",
    "- 在NAMESPACE中明确导入\n"
  )
  
  write_if_not_exists(file.path(output_dir, "02_coding_standards.md"), content, overwrite)
}

#' Generate Testing Standards Documentation
#' @keywords internal
generate_testing_standards <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# R包测试标准\n\n",
    "## 测试框架\n\n",
    "使用`testthat`包进行单元测试和集成测试。\n\n",
    "## 测试文件组织\n\n",
    "```\n",
    "tests/\n",
    "├── testthat/              # 测试文件目录\n",
    "│   ├── test-function1.R   # 函数1的测试\n",
    "│   ├── test-function2.R   # 函数2的测试\n",
    "│   └── test-integration.R # 集成测试\n",
    "└── testthat.R             # 测试配置\n",
    "```\n\n",
    "## 测试命名规范\n\n",
    "- 测试文件: `test-function_name.R`\n",
    "- 测试描述: 描述测试场景\n",
    "- 测试组: 按功能模块分组\n\n",
    "## 测试类型\n\n",
    "### 单元测试\n",
    "- 测试单个函数\n",
    "- 验证输入输出\n",
    "- 测试边界条件\n\n",
    "### 集成测试\n",
    "- 测试函数组合\n",
    "- 验证工作流程\n",
    "- 测试数据流\n\n",
    "### 参数验证测试\n",
    "- 测试参数验证逻辑\n",
    "- 验证错误信息\n",
    "- 测试边界值\n\n",
    "## 测试覆盖率\n\n",
    "- 目标覆盖率: > 80%\n",
    "- 使用`covr`包测量覆盖率\n",
    "- 重点关注核心功能\n\n",
    "## 测试示例\n\n",
    "```r\n",
    "test_that(\"function_name works correctly\", {\n",
    "  # 准备测试数据\n",
    "  test_data <- data.frame(x = 1:5, y = letters[1:5])\n",
    "  \n",
    "  # 测试正常情况\n",
    "  result <- function_name(test_data)\n",
    "  expect_is(result, \"data.frame\")\n",
    "  expect_equal(nrow(result), 5)\n",
    "  \n",
    "  # 测试边界条件\n",
    "  empty_data <- data.frame()\n",
    "  expect_error(function_name(empty_data), \"Input data is empty\")\n",
    "  \n",
    "  # 测试参数验证\n",
    "  expect_error(function_name(NULL), \"Parameter 'data' is required\")\n",
    "})\n",
    "```\n\n",
    "## 测试最佳实践\n\n",
    "### 测试数据\n",
    "- 使用小型、代表性数据\n",
    "- 避免依赖外部数据\n",
    "- 使用`set.seed()`确保可重复性\n\n",
    "### 测试隔离\n",
    "- 每个测试独立运行\n",
    "- 避免测试间依赖\n",
    "- 清理测试环境\n\n",
    "### 错误测试\n",
    "- 测试错误情况\n",
    "- 验证错误信息\n",
    "- 测试异常输入\n\n",
    "## 持续集成\n\n",
    "- 使用GitHub Actions自动运行测试\n",
    "- 每次提交都运行测试\n",
    "- 测试失败阻止合并\n\n",
    "## 性能测试\n\n",
    "- 测试函数性能\n",
    "- 监控内存使用\n",
    "- 设置性能基准\n\n",
    "## 测试文档\n\n",
    "- 记录测试策略\n",
    "- 说明测试数据\n",
    "- 维护测试用例\n"
  )
  
  write_if_not_exists(file.path(output_dir, "03_testing_standards.md"), content, overwrite)
}

#' Generate Documentation Standards Documentation
#' @keywords internal
generate_documentation_standards <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# R包文档标准\n\n",
    "## 文档类型\n\n",
    "### 函数文档\n",
    "- 使用`roxygen2`生成\n",
    "- 包含参数、返回值、示例\n",
    "- 使用`@export`标记导出函数\n\n",
    "### 包级文档\n",
    "- 包概述和功能说明\n",
    "- 安装和使用指南\n",
    "- 示例和教程\n\n",
    "### 用户指南\n",
    "- README.md: 项目介绍\n",
    "- NEWS.md: 版本更新\n",
    "- vignettes: 详细教程\n\n",
    "## roxygen2标签\n\n",
    "### 必需标签\n",
    "```r\n",
    "#' @param parameter 参数描述\n",
    "#' @return 返回值描述\n",
    "#' @export\n",
    "```\n\n",
    "### 可选标签\n",
    "```r\n",
    "#' @title 函数标题\n",
    "#' @description 详细描述\n",
    "#' @details 更多细节\n",
    "#' @examples 使用示例\n",
    "#' @seealso 相关函数\n",
    "#' @keywords 关键词\n",
    "#' @author 作者信息\n",
    "#' @references 参考文献\n",
    "```\n\n",
    "## 文档示例\n\n",
    "```r\n",
    "#' Calculate summary statistics\n",
    "#'\n",
    "#' This function calculates various summary statistics for a numeric vector.\n",
    "#'\n",
    "#' @param x Numeric vector for which to calculate statistics\n",
    "#' @param na.rm Logical, whether to remove NA values (default: TRUE)\n",
    "#' @return A list containing mean, median, sd, min, and max\n",
    "#' @export\n",
    "#' @examples\n",
    "#' x <- c(1, 2, 3, 4, 5, NA)\n",
    "#' summary_stats(x)\n",
    "#' summary_stats(x, na.rm = FALSE)\n",
    "summary_stats <- function(x, na.rm = TRUE) {\n",
    "  # 函数实现\n",
    "}\n",
    "```\n\n",
    "## README.md标准\n\n",
    "### 必需内容\n",
    "- 包名称和简介\n",
    "- 安装说明\n",
    "- 快速开始示例\n",
    "- 主要功能列表\n",
    "- 许可证信息\n\n",
    "### 推荐内容\n",
    "- 详细使用说明\n",
    "- 贡献指南\n",
    "- 问题反馈\n",
    "- 更新日志\n\n",
    "## NEWS.md标准\n\n",
    "### 版本格式\n",
    "```\n",
    "## Version 1.0.0 (2024-01-01)\n",
    "\n",
    "### New Features\n",
    "* Added new function `function_name()`\n",
    "* Enhanced existing functionality\n",
    "\n",
    "### Bug Fixes\n",
    "* Fixed issue with parameter validation\n",
    "* Corrected error message\n",
    "\n",
    "### Documentation\n",
    "* Updated function documentation\n",
    "* Added new examples\n",
    "```\n\n",
    "## Vignettes标准\n\n",
    "### 内容要求\n",
    "- 包概述和安装\n",
    "- 主要功能演示\n",
    "- 实际应用案例\n",
    "- 高级用法说明\n\n",
    "### 格式要求\n",
    "- 使用R Markdown\n",
    "- 包含可执行代码\n",
    "- 清晰的章节结构\n",
    "- 适当的图表说明\n\n",
    "## 文档质量检查\n\n",
    "### 自动化检查\n",
    "- R CMD check\n",
    "- spell check\n",
    "- link check\n\n",
    "### 手动检查\n",
    "- 文档完整性\n",
    "- 示例可执行性\n",
    "- 信息准确性\n\n",
    "## 多语言支持\n\n",
    "### 中文文档\n",
    "- 注释可以使用中文\n",
    "- 确保UTF-8编码\n",
    "- 错误信息使用英文\n\n",
    "### 国际化\n",
    "- 考虑多语言用户\n",
    "- 提供英文文档\n",
    "- 使用标准术语\n"
  )
  
  write_if_not_exists(file.path(output_dir, "04_documentation_standards.md"), content, overwrite)
}

#' Generate Git Workflow Documentation
#' @keywords internal
generate_git_workflow <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# Git工作流标准\n\n",
    "## 分支策略\n\n",
    "### 主要分支\n",
    "- `main`: 生产分支，稳定版本\n",
    "- `develop`: 开发分支，集成新功能\n\n",
    "### 功能分支\n",
    "- `feature/功能名称`: 新功能开发\n",
    "- `bugfix/问题描述`: 错误修复\n",
    "- `hotfix/紧急修复`: 紧急修复\n\n",
    "## 提交规范\n\n",
    "### 提交信息格式\n",
    "```\n",
    "type(scope): subject\n",
    "\n",
    "body\n",
    "\n",
    "footer\n",
    "```\n\n",
    "### 类型说明\n",
    "- `feat`: 新功能\n",
    "- `fix`: 错误修复\n",
    "- `docs`: 文档更新\n",
    "- `style`: 代码格式调整\n",
    "- `refactor`: 代码重构\n",
    "- `test`: 测试相关\n",
    "- `chore`: 构建过程或辅助工具的变动\n\n",
    "### 示例\n",
    "```\n",
    "feat(package): add new export_to_excel function\n",
    "\n",
    "Add comprehensive Excel export functionality with formatting options.\n",
    "Includes header styles, table styles, and customizable colors.\n",
    "\n",
    "Closes #123\n",
    "```\n\n",
    "## 工作流程\n\n",
    "### 功能开发流程\n",
    "1. 从`develop`分支创建功能分支\n",
    "2. 在功能分支上开发\n",
    "3. 提交代码并推送到远程\n",
    "4. 创建Pull Request\n",
    "5. 代码审查\n",
    "6. 合并到`develop`分支\n\n",
    "### 发布流程\n",
    "1. 从`develop`分支创建发布分支\n",
    "2. 版本号更新和文档完善\n",
    "3. 测试和修复\n",
    "4. 合并到`main`和`develop`\n",
    "5. 创建版本标签\n\n",
    "## 代码审查\n\n",
    "### 审查要点\n",
    "- 代码质量和风格\n",
    "- 功能正确性\n",
    "- 测试覆盖率\n",
    "- 文档完整性\n",
    "- 性能影响\n\n",
    "### 审查流程\n",
    "1. 自动检查通过\n",
    "2. 至少一名审查者批准\n",
    "3. 所有讨论已解决\n",
    "4. 合并代码\n\n",
    "## 版本管理\n\n",
    "### 版本号格式\n",
    "使用语义化版本号: `MAJOR.MINOR.PATCH`\n",
    "- MAJOR: 不兼容的API修改\n",
    "- MINOR: 向下兼容的功能性新增\n",
    "- PATCH: 向下兼容的问题修正\n\n",
    "### 标签命名\n",
    "- 版本标签: `v1.0.0`\n",
    "- 预发布标签: `v1.0.0-rc.1`\n",
    "- 开发版本: `v1.0.0-dev`\n\n",
    "## 持续集成\n\n",
    "### GitHub Actions\n",
    "- 自动运行测试\n",
    "- 代码质量检查\n",
    "- 文档构建\n",
    "- 包构建和检查\n\n",
    "### 检查项目\n",
    "- R CMD check\n",
    "- 测试覆盖率\n",
    "- 代码风格检查\n",
    "- 文档完整性\n\n",
    "## 最佳实践\n\n",
    "### 提交频率\n",
    "- 频繁提交，小步快跑\n",
    "- 每次提交解决一个问题\n",
    "- 保持提交信息清晰\n\n",
    "### 分支管理\n",
    "- 及时删除已合并分支\n",
    "- 保持分支命名一致\n",
    "- 避免长期分支\n\n",
    "### 冲突解决\n",
    "- 优先在本地解决冲突\n",
    "- 使用合适的合并策略\n",
    "- 保持代码历史清晰\n\n",
    "## 工具配置\n\n",
    "### Git配置\n",
    "```bash\n",
    "git config --global init.defaultBranch main\n",
    "git config --global user.name \"Your Name\"\n",
    "git config --global user.email \"your.email@example.com\"\n",
    "```\n\n",
    "### 钩子脚本\n",
    "- pre-commit: 代码格式检查\n",
    "- pre-push: 测试运行\n",
    "- commit-msg: 提交信息格式检查\n"
  )
  
  write_if_not_exists(file.path(output_dir, "05_git_workflow.md"), content, overwrite)
}

#' Generate Release Checklist Documentation
#' @keywords internal
generate_release_checklist <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# R包发布检查清单\n\n",
    "## 发布前检查\n\n",
    "### 代码质量\n",
    "- [ ] 所有测试通过\n",
    "- [ ] 代码覆盖率 > 80%\n",
    "- [ ] 无警告或错误\n",
    "- [ ] 代码风格一致\n",
    "- [ ] 无TODO或FIXME注释\n\n",
    "### 文档完整性\n",
    "- [ ] 所有函数有文档\n",
    "- [ ] 示例代码可执行\n",
    "- [ ] README.md更新\n",
    "- [ ] NEWS.md更新\n",
    "- [ ] vignettes完整\n",
    "- [ ] 拼写检查通过\n\n",
    "### 包结构\n",
    "- [ ] DESCRIPTION文件正确\n",
    "- [ ] NAMESPACE文件正确\n",
    "- [ ] 许可证文件存在\n",
    "- [ ] 依赖关系正确\n",
    "- [ ] 导入导出正确\n\n",
    "## R CMD check\n\n",
    "### 本地检查\n",
    "```r\n",
    "devtools::check()\n",
    "devtools::check_win_devel()\n",
    "devtools::check_mac_release()\n",
    "rhub::check_for_cran()\n",
    "```\n\n",
    "### 检查项目\n",
    "- [ ] 无错误\n",
    "- [ ] 无警告\n",
    "- [ ] 无注释\n",
    "- [ ] 文档完整\n",
    "- [ ] 示例可执行\n\n",
    "## CRAN政策检查\n\n",
    "### 必需检查\n",
    "- [ ] 符合CRAN政策\n",
    "- [ ] 无非ASCII字符（除注释）\n",
    "- [ ] 包大小合理\n",
    "- [ ] 依赖包可用\n",
    "- [ ] 许可证兼容\n\n",
    "### 推荐检查\n",
    "- [ ] 使用标准许可证\n",
    "- [ ] 提供URL和BugReports\n",
    "- [ ] 包含作者信息\n",
    "- [ ] 版本号正确\n\n",
    "## 版本管理\n\n",
    "### 版本号更新\n",
    "- [ ] DESCRIPTION中的版本号\n",
    "- [ ] NEWS.md中的版本信息\n",
    "- [ ] 包级文档中的版本\n",
    "- [ ] 所有相关文档\n\n",
    "### 标签创建\n",
    "```bash\n",
    "git tag -a v1.0.0 -m \"Release version 1.0.0\"\n",
    "git push origin v1.0.0\n",
    "```\n\n",
    "## 发布流程\n\n",
    "### GitHub发布\n",
    "1. 创建Release\n",
    "2. 上传源代码包\n",
    "3. 编写发布说明\n",
    "4. 标记为最新版本\n\n",
    "### CRAN提交\n",
    "1. 构建源代码包\n",
    "2. 填写提交表单\n",
    "3. 上传包文件\n",
    "4. 等待审核结果\n\n",
    "## 发布后检查\n\n",
    "### 安装测试\n",
    "- [ ] 从CRAN安装成功\n",
    "- [ ] 从GitHub安装成功\n",
    "- [ ] 依赖包正确安装\n",
    "- [ ] 功能正常工作\n\n",
    "### 文档更新\n",
    "- [ ] 网站文档更新\n",
    "- [ ] 示例代码测试\n",
    "- [ ] 链接检查\n",
    "- [ ] 搜索功能正常\n\n",
    "## 回滚计划\n\n",
    "### 问题发现\n",
    "- 立即停止分发\n",
    "- 评估问题严重性\n",
    "- 制定修复计划\n\n",
    "### 修复发布\n",
    "- 快速修复问题\n",
    "- 增加补丁版本号\n",
    "- 重新发布\n\n",
    "## 长期维护\n\n",
    "### 定期检查\n",
    "- 依赖包更新\n",
    "- R版本兼容性\n",
    "- 用户反馈处理\n",
    "- 性能监控\n\n",
    "### 版本支持\n",
    "- 维护当前版本\n",
    "- 支持上一个版本\n",
    "- 计划下一个版本\n"
  )
  
  write_if_not_exists(file.path(output_dir, "06_release_checklist.md"), content, overwrite)
}

#' Generate Templates
#' @keywords internal
generate_templates <- function(output_dir, package_name, overwrite) {
  templates_dir <- file.path(output_dir, "templates")
  ensure_directory(templates_dir)
  
  # 函数模板
  function_template <- paste0(
    "# 函数模板\n\n",
    "#' Function Title\n",
    "#'\n",
    "#' Function description\n",
    "#'\n",
    "#' @param param1 Parameter description\n",
    "#' @param param2 Parameter description (default: value)\n",
    "#' @return Return value description\n",
    "#' @export\n",
    "#' @examples\n",
    "#' \\dontrun{\n",
    "#' # Usage example\n",
    "#' function_name(param1, param2)\n",
    "#' }\n",
    "function_name <- function(param1, param2 = default_value) {\n",
    "  # 参数验证\n",
    "  if (missing(param1) || is.null(param1)) {\n",
    "    stop(\"Parameter 'param1' is required and cannot be empty\")\n",
    "  }\n",
    "  \n",
    "  if (!is.character(param1) || length(param1) != 1) {\n",
    "    stop(\"Parameter 'param1' must be a character vector of length 1\")\n",
    "  }\n",
    "  \n",
    "  # 主要逻辑\n",
    "  result <- process_data(param1, param2)\n",
    "  \n",
    "  # 返回结果\n",
    "  return(result)\n",
    "}\n"
  )
  
  # 测试模板
  test_template <- paste0(
    "# 测试模板\n\n",
    "test_that(\"function_name works correctly\", {\n",
    "  # 准备测试数据\n",
    "  test_data <- data.frame(x = 1:5, y = letters[1:5])\n",
    "  \n",
    "  # 测试正常情况\n",
    "  result <- function_name(test_data)\n",
    "  expect_is(result, \"data.frame\")\n",
    "  expect_equal(nrow(result), 5)\n",
    "  \n",
    "  # 测试边界条件\n",
    "  empty_data <- data.frame()\n",
    "  expect_error(function_name(empty_data), \"Input data is empty\")\n",
    "  \n",
    "  # 测试参数验证\n",
    "  expect_error(function_name(NULL), \"Parameter 'data' is required\")\n",
    "})\n"
  )
  
  # 提交信息模板
  commit_template <- paste0(
    "# 提交信息模板\n\n",
    "type(scope): subject\n\n",
    "body\n\n",
    "footer\n\n",
    "# 类型说明:\n",
    "# feat: 新功能\n",
    "# fix: 错误修复\n",
    "# docs: 文档更新\n",
    "# style: 代码格式调整\n",
    "# refactor: 代码重构\n",
    "# test: 测试相关\n",
    "# chore: 构建过程或辅助工具的变动\n"
  )
  
  write_if_not_exists(file.path(templates_dir, "function_template.R"), function_template, overwrite)
  write_if_not_exists(file.path(templates_dir, "test_template.R"), test_template, overwrite)
  write_if_not_exists(file.path(templates_dir, "commit_template.txt"), commit_template, overwrite)
}

#' Create .gitignore file for R projects
#'
#' This function creates a standard .gitignore file for R projects,
#' including common R-specific files, build artifacts, and system files
#' that should be ignored by Git.
#'
#' @param project_path Character string for the project root directory (default: ".")
#' @param overwrite Logical, whether to overwrite existing file (default: FALSE)
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create .gitignore in current directory
#' create_gitignore()
#'
#' # Create .gitignore in specific directory
#' create_gitignore("~/my_project")
#'
#' # Overwrite existing file
#' create_gitignore(overwrite = TRUE)
#' }
create_gitignore <- function(project_path = ".", overwrite = FALSE, quiet = FALSE) {
  
  # Parameter validation
  if (!is.character(project_path) || length(project_path) != 1) {
    stop("Parameter 'project_path' must be a character vector of length 1")
  }
  
  if (!dir.exists(project_path)) {
    stop("Project directory does not exist")
  }
  
  # Standard .gitignore content for R projects
  gitignore_content <- c(
    "# R specific files",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    "*.Rproj",
    ".Rprofile",
    "",
    "# Package build files",
    "*.tar.gz",
    "*.zip",
    "*.tgz",
    "",
    "# Documentation",
    "docs/",
    "vignettes/*.html",
    "vignettes/*.pdf",
    "",
    "# Test files",
    "tests/testthat.Rcheck/",
    "",
    "# Data files",
    "data/*.rda",
    "data/*.rds",
    "data/*.csv",
    "data/*.xlsx",
    "",
    "# Output files",
    "output/*.pdf",
    "output/*.png",
    "output/*.jpg",
    "output/*.xlsx",
    "",
    "# Temporary files",
    "*.tmp",
    "*.temp",
    "*.log",
    "",
    "# OS specific files",
    ".DS_Store",
    "Thumbs.db",
    "desktop.ini",
    "",
    "# IDE files",
    ".vscode/",
    ".idea/",
    "*.swp",
    "*.swo",
    "",
    "# Package development",
    "pkgdown/",
    "docs/"
  )
  
  # File path
  gitignore_path <- file.path(project_path, ".gitignore")
  
  # Create .gitignore
  if (!file.exists(gitignore_path) || overwrite) {
    writeLines(gitignore_content, gitignore_path, useBytes = TRUE)
    if (!quiet) {
      message("Created .gitignore file")
    }
  } else {
    if (!quiet) {
      message(".gitignore file already exists (use overwrite=TRUE to replace)")
    }
  }
  
  invisible(NULL)
}

#' Create .Rbuildignore file for R packages
#'
#' This function creates a standard .Rbuildignore file for R packages,
#' specifying files and directories that should be excluded during
#' R package building process.
#'
#' @param project_path Character string for the project root directory (default: ".")
#' @param overwrite Logical, whether to overwrite existing file (default: FALSE)
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create .Rbuildignore in current directory
#' create_rbuildignore()
#'
#' # Create .Rbuildignore in specific directory
#' create_rbuildignore("~/my_package")
#'
#' # Overwrite existing file
#' create_rbuildignore(overwrite = TRUE)
#' }
create_rbuildignore <- function(project_path = ".", overwrite = FALSE, quiet = FALSE) {
  
  # Parameter validation
  if (!is.character(project_path) || length(project_path) != 1) {
    stop("Parameter 'project_path' must be a character vector of length 1")
  }
  
  if (!dir.exists(project_path)) {
    stop("Project directory does not exist")
  }
  
  # Standard .Rbuildignore content
  rbuildignore_content <- c(
    "LICENSE.md",
    "dev/",
    "examples/",
    "output/",
    "temp/",
    "*.tmp",
    "*.log"
  )
  
  # File path
  rbuildignore_path <- file.path(project_path, ".Rbuildignore")
  
  # Create .Rbuildignore
  if (!file.exists(rbuildignore_path) || overwrite) {
    writeLines(rbuildignore_content, rbuildignore_path, useBytes = TRUE)
    if (!quiet) {
      message("Created .Rbuildignore file")
    }
  } else {
    if (!quiet) {
      message(".Rbuildignore file already exists (use overwrite=TRUE to replace)")
    }
  }
  
  invisible(NULL)
}

#' Write file if it doesn't exist or overwrite is TRUE
#' @keywords internal
write_if_not_exists <- function(file_path, content, overwrite = FALSE) {
  if (file.exists(file_path) && !overwrite) {
    warning("File already exists: ", file_path, ". Use overwrite = TRUE to overwrite.")
    return()
  }
  
  writeLines(content, file_path, useBytes = TRUE)
} 

#' Create Data Analysis Project Standards Documentation
#'
#' This function creates comprehensive data analysis project standards
#' documentation in a specified directory. It creates a complete set of
#' guidelines, templates, and best practices specifically designed for
#' R data analysis projects.
#'
#' @author Songbiao Zhu \email{zhusongbiao@cimrbj.ac.cn}
#'
#' @param output_dir Character string for the output directory (default: "./dev/design")
#' @param project_name Character string for the project name (optional)
#' @param overwrite Logical, whether to overwrite existing files (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create project standards documentation in default location
#' create_project_standards()
#'
#' # Create with custom project name
#' create_project_standards(project_name = "MyAnalysisProject")
#'
#' # Create in custom directory
#' create_project_standards("./docs/project_standards")
#' }
create_project_standards <- function(output_dir = "./dev/design", 
                                    project_name = NULL, 
                                    overwrite = FALSE) {
  # 参数验证
  if (is.null(output_dir) || (is.character(output_dir) && length(output_dir) == 1 && output_dir == "")) {
    stop("Parameter 'output_dir' is required and cannot be empty")
  }
  
  if (!is.character(output_dir) || length(output_dir) != 1) {
    stop("Parameter 'output_dir' must be a character vector of length 1")
  }
  
  # 确保输出目录存在
  ensure_directory(output_dir)
  
  # 生成各种文档
  generate_project_overview(output_dir, project_name, overwrite)
  generate_data_workflow(output_dir, project_name, overwrite)
  generate_analysis_standards(output_dir, project_name, overwrite)
  generate_reproducibility_standards(output_dir, project_name, overwrite)
  generate_project_templates(output_dir, project_name, overwrite)
  
  invisible(NULL)
}

#' Generate Project Overview Documentation
#' @keywords internal
generate_project_overview <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# 数据分析项目开发规范概述\n\n",
    if (!is.null(package_name)) paste0("## 项目名称: ", package_name, "\n\n") else "",
    "## 概述\n\n",
    "本文档定义了R数据分析项目的开发标准和最佳实践，确保项目质量、可重现性和协作效率。\n\n",
    "## 核心原则\n\n",
    "1. **数据驱动**: 以数据为中心，确保数据质量和完整性\n",
    "2. **可重现性**: 确保分析结果可以完全重现\n",
    "3. **模块化**: 将分析过程分解为可管理的模块\n",
    "4. **文档化**: 详细记录每个分析步骤和决策\n",
    "5. **协作友好**: 便于团队成员理解和参与\n\n",
    "## 项目结构\n\n",
    "```\n",
    "project_name/\n",
    "├── data/\n",
    "│   ├── raw/              # 原始数据\n",
    "│   ├── processed/        # 处理后的数据\n",
    "│   └── external/         # 外部参考数据\n",
    "├── scripts/              # 分析脚本\n",
    "├── output/               # 输出结果\n",
    "├── config/               # 配置文件\n",
    "├── docs/                 # 项目文档\n",
    "├── dev/design/           # 开发规范文档\n",
    "├── .gitignore            # Git忽略文件\n",
    "└── README.md             # 项目说明\n",
    "```\n\n",
    "## 文件命名规范\n\n",
    "### 数据文件\n",
    "- 原始数据: `YYYYMMDD_数据来源_数据类型.csv`\n",
    "- 处理后数据: `YYYYMMDD_处理步骤_数据类型.rds`\n",
    "- 外部数据: `数据来源_版本_数据类型.csv`\n\n",
    "### 脚本文件\n",
    "- 数据清洗: `01_data_cleaning.R`\n",
    "- 数据探索: `02_data_exploration.R`\n",
    "- 模型构建: `03_model_building.R`\n",
    "- 结果分析: `04_results_analysis.R`\n\n",
    "### 输出文件\n",
    "- 图表: `YYYYMMDD_图表类型_描述.png`\n",
    "- 报告: `YYYYMMDD_报告类型_描述.html`\n",
    "- 数据: `YYYYMMDD_输出数据_描述.csv`\n\n",
    "## 版本控制\n\n",
    "- 使用Git进行版本控制\n",
    "- 提交信息格式: `type: description`\n",
    "- 定期提交，每次提交解决一个问题\n",
    "- 重要节点创建标签\n\n",
    "## 协作规范\n\n",
    "### 代码审查\n",
    "- 重要更改需要代码审查\n",
    "- 关注代码质量和逻辑正确性\n",
    "- 确保文档完整性\n\n",
    "### 沟通机制\n",
    "- 定期项目会议\n",
    "- 问题及时反馈\n",
    "- 决策过程记录\n\n",
    "## 质量保证\n\n",
    "- 数据质量检查\n",
    "- 代码逻辑验证\n",
    "- 结果合理性检查\n",
    "- 文档完整性检查\n\n",
    "## 相关文档\n\n",
    "- [数据工作流程](02_data_workflow.md)\n",
    "- [分析标准](03_analysis_standards.md)\n",
    "- [可重现性规范](04_reproducibility.md)\n"
  )
  
  write_if_not_exists(file.path(output_dir, "01_overview.md"), content, overwrite)
}

#' Generate Data Workflow Documentation
#' @keywords internal
generate_data_workflow <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# 数据工作流程规范\n\n",
    "## 数据目录使用规范\n\n",
    "### data/raw/ - 原始数据\n",
    "- **用途**: 存放未经处理的原始数据\n",
    "- **文件格式**: CSV, Excel, JSON, TXT等\n",
    "- **命名规范**: `YYYYMMDD_数据来源_数据类型.csv`\n",
    "- **管理原则**:\n",
    "  - 原始数据不可修改\n",
    "  - 保留数据来源信息\n",
    "  - 记录数据获取日期\n\n",
    "### data/processed/ - 处理后数据\n",
    "- **用途**: 存放经过清洗和处理的数据\n",
    "- **文件格式**: RDS, CSV, RData\n",
    "- **命名规范**: `YYYYMMDD_处理步骤_数据类型.rds`\n",
    "- **管理原则**:\n",
    "  - 记录处理步骤\n",
    "  - 保存处理脚本\n",
    "  - 版本控制\n\n",
    "### data/external/ - 外部参考数据\n",
    "- **用途**: 存放外部数据库、参考数据集\n",
    "- **文件格式**: 根据数据源确定\n",
    "- **命名规范**: `数据来源_版本_数据类型.csv`\n",
    "- **管理原则**:\n",
    "  - 记录数据来源\n",
    "  - 保存获取脚本\n",
    "  - 定期更新\n\n",
    "## 数据版本控制\n\n",
    "### 文件命名规范\n",
    "```\n",
    "# 原始数据\n",
    "20240101_hospital_patient_data.csv\n",
    "20240101_lab_test_results.csv\n",
    "\n",
    "# 处理后数据\n",
    "20240101_cleaned_patient_data.rds\n",
    "20240101_merged_clinical_data.rds\n",
    "\n",
    "# 外部数据\n",
    "icd10_codes_v2023.csv\n",
    "drug_database_v2.1.csv\n",
    "```\n\n",
    "### 数据变更记录\n",
    "- 记录每次数据更新\n",
    "- 说明变更原因\n",
    "- 记录影响范围\n",
    "- 更新数据字典\n\n",
    "## 数据质量检查\n\n",
    "### 完整性检查\n",
    "- 缺失值统计\n",
    "- 数据范围检查\n",
    "- 数据类型验证\n",
    "- 重复记录检查\n\n",
    "### 数据验证\n",
    "```r\n",
    "# 数据质量检查示例\n",
    "check_data_quality <- function(data) {\n",
    "  # 缺失值检查\n",
    "  missing_summary <- colSums(is.na(data))\n",
    "  \n",
    "  # 数据类型检查\n",
    "  data_types <- sapply(data, class)\n",
    "  \n",
    "  # 数据范围检查\n",
    "  numeric_cols <- sapply(data, is.numeric)\n",
    "  range_summary <- sapply(data[numeric_cols], range)\n",
    "  \n",
    "  return(list(\n",
    "    missing = missing_summary,\n",
    "    types = data_types,\n",
    "    ranges = range_summary\n",
    "  ))\n",
    "}\n",
    "```\n\n",
    "## 数据流程管理\n\n",
    "### 标准数据流程\n",
    "1. **数据获取** → data/raw/\n",
    "2. **数据清洗** → data/processed/\n",
    "3. **数据探索** → scripts/\n",
    "4. **数据分析** → scripts/\n",
    "5. **结果输出** → output/\n\n",
    "### 流程记录\n",
    "- 每个步骤创建独立脚本\n",
    "- 记录处理参数\n",
    "- 保存中间结果\n",
    "- 记录处理时间\n\n",
    "## 数据备份策略\n\n",
    "### 本地备份\n",
    "- 重要数据定期备份\n",
    "- 使用压缩格式节省空间\n",
    "- 保留多个版本\n\n",
    "### 云端备份\n",
    "- 使用Git LFS管理大文件\n",
    "- 云端存储重要数据\n",
    "- 定期同步\n\n",
    "## 数据字典模板\n\n",
    "### 变量说明\n",
    "- 变量名称\n",
    "- 数据类型\n",
    "- 取值范围\n",
    "- 缺失值编码\n",
    "- 变量说明\n\n",
    "### 示例数据字典\n",
    "```\n",
    "变量名 | 类型 | 范围 | 缺失值 | 说明\n",
    "-------|------|------|--------|------\n",
    "patient_id | 字符 | - | - | 患者唯一标识\n",
    "age | 数值 | 0-120 | 999 | 患者年龄\n",
    "gender | 字符 | M/F | - | 患者性别\n",
    "```\n"
  )
  
  write_if_not_exists(file.path(output_dir, "02_data_workflow.md"), content, overwrite)
}

#' Generate Analysis Standards Documentation
#' @keywords internal
generate_analysis_standards <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# 分析标准规范\n\n",
    "## 脚本组织规范\n\n",
    "### scripts/目录使用\n",
    "- **01_data_preparation.R**: 数据准备和清洗\n",
    "- **02_exploratory_analysis.R**: 探索性数据分析\n",
    "- **03_model_development.R**: 模型开发和训练\n",
    "- **04_model_evaluation.R**: 模型评估和验证\n",
    "- **05_results_analysis.R**: 结果分析和解释\n",
    "- **06_report_generation.R**: 报告生成\n\n",
    "### 脚本结构模板\n",
    "```r\n",
    "# ============================================================================\n",
    "# 脚本名称: 数据分析脚本\n",
    "# 作者: 姓名\n",
    "# 日期: YYYY-MM-DD\n",
    "# 描述: 脚本功能描述\n",
    "# ============================================================================\n",
    "\n",
    "# 加载必要的包\n",
    "library(dplyr)\n",
    "library(ggplot2)\n",
    "\n",
    "# 设置工作目录和参数\n",
    "set.seed(123)\n",
    "output_dir <- \"../output\"\n",
    "\n",
    "# 数据加载\n",
    "data <- readRDS(\"../data/processed/cleaned_data.rds\")\n",
    "\n",
    "# 主要分析\n",
    "# ... 分析代码 ...\n",
    "\n",
    "# 结果保存\n",
    "saveRDS(results, file.path(output_dir, \"analysis_results.rds\"))\n",
    "```\n\n",
    "## 代码注释标准\n\n",
    "### 分节注释\n",
    "- 使用 `# 分节名称 ===` 格式\n",
    "- 便于IDE导航和代码折叠\n",
    "- 示例: `# 数据加载 ===`, `# 模型训练 ===`\n\n",
    "### 行内注释\n",
    "- 解释复杂逻辑\n",
    "- 说明算法步骤\n",
    "- 记录重要决策\n",
    "- 避免显而易见的注释\n\n",
    "### 注释示例\n",
    "```r\n",
    "# 数据预处理 ===\n",
    "# 移除缺失值超过50%的变量\n",
    "missing_threshold <- 0.5\n",
    "data_clean <- data[, colMeans(is.na(data)) < missing_threshold]\n",
    "\n",
    "# 特征工程 ===\n",
    "# 创建年龄分组变量\n",
    "data_clean$age_group <- cut(data_clean$age, \n",
    "                           breaks = c(0, 18, 35, 50, 65, Inf),\n",
    "                           labels = c(\"<18\", \"18-35\", \"36-50\", \"51-65\", \">65\"))\n",
    "```\n\n",
    "## 结果输出规范\n\n",
    "### output/目录使用\n",
    "- **图表**: 保存为PNG、PDF格式\n",
    "- **数据**: 保存为CSV、RDS格式\n",
    "- **报告**: 保存为HTML、PDF格式\n",
    "- **模型**: 保存为RDS格式\n\n",
    "### 文件命名规范\n",
    "```\n",
    "# 图表文件\n",
    "20240101_correlation_plot.png\n",
    "20240101_distribution_histogram.pdf\n",
    "\n",
    "# 数据文件\n",
    "20240101_model_predictions.csv\n",
    "20240101_feature_importance.rds\n",
    "\n",
    "# 报告文件\n",
    "20240101_analysis_report.html\n",
    "20240101_model_summary.pdf\n",
    "```\n\n",
    "### 输出质量控制\n",
    "- 检查图表清晰度\n",
    "- 验证数据准确性\n",
    "- 确保格式一致性\n",
    "- 记录生成参数\n\n",
    "## 错误处理\n\n",
    "### 错误处理原则\n",
    "- 预期错误使用 `tryCatch()`\n",
    "- 意外错误使用 `stop()`\n",
    "- 警告信息使用 `warning()`\n",
    "- 信息提示使用 `message()`\n\n",
    "### 错误处理示例\n",
    "```r\n",
    "process_data <- function(data_file) {\n",
    "  tryCatch({\n",
    "    # 尝试读取数据\n",
    "    data <- read.csv(data_file)\n",
    "    \n",
    "    # 检查数据完整性\n",
    "    if (nrow(data) == 0) {\n",
    "      stop(\"数据文件为空\")\n",
    "    }\n",
    "    \n",
    "    return(data)\n",
    "  }, error = function(e) {\n",
    "    message(\"读取数据时出错: \", e$message)\n",
    "    return(NULL)\n",
    "  })\n",
    "}\n",
    "```\n\n",
    "## 代码风格规范\n\n",
    "### 命名规范\n",
    "- 变量名使用 `snake_case`\n",
    "- 函数名使用 `snake_case`\n",
    "- 常量使用 `UPPER_SNAKE_CASE`\n",
    "- 避免使用单字母变量名\n\n",
    "### 格式规范\n",
    "- 使用2个空格缩进\n",
    "- 操作符前后加空格\n",
    "- 逗号后加空格\n",
    "- 每行不超过80个字符\n\n",
    "### 代码示例\n",
    "```r\n",
    "# 好的代码风格\n",
    "calculate_summary_stats <- function(data, group_var) {\n",
    "  summary_stats <- data %>%\n",
    "    group_by(!!sym(group_var)) %>%\n",
    "    summarise(\n",
    "      mean_value = mean(value, na.rm = TRUE),\n",
    "      sd_value = sd(value, na.rm = TRUE),\n",
    "      n_obs = n()\n",
    "    )\n",
    "  \n",
    "  return(summary_stats)\n",
    "}\n",
    "\n",
    "# 避免的代码风格\n",
    "calc_summary <- function(d,g) {\n",
    "  s <- d %>% group_by(!!sym(g)) %>% summarise(m=mean(value,na.rm=T),s=sd(value,na.rm=T),n=n())\n",
    "  return(s)\n",
    "}\n",
    "```\n\n",
    "## 性能优化\n\n",
    "### 数据处理优化\n",
    "- 使用 `data.table` 处理大数据\n",
    "- 避免重复计算\n",
    "- 及时清理内存\n",
    "- 使用并行计算\n\n",
    "### 内存管理\n",
    "```r\n",
    "# 内存管理示例\n",
    "large_data <- read.csv(\"large_file.csv\")\n",
    "\n",
    "# 处理完成后清理\n",
    "rm(large_data)\n",
    "gc()\n",
    "```\n"
  )
  
  write_if_not_exists(file.path(output_dir, "03_analysis_standards.md"), content, overwrite)
}

#' Generate Reproducibility Standards Documentation
#' @keywords internal
generate_reproducibility_standards <- function(output_dir, package_name, overwrite) {
  content <- paste0(
    "# 可重现性规范\n\n",
    "## 环境管理\n\n",
    "### 使用renv进行包管理\n",
    "```r\n",
    "# 初始化renv\n",
    "renv::init()\n",
    "\n",
    "# 安装包\n",
    "renv::install(c(\"dplyr\", \"ggplot2\", \"caret\"))\n",
    "\n",
    "# 保存环境\n",
    "renv::snapshot()\n",
    "\n",
    "# 恢复环境\n",
    "renv::restore()\n",
    "```\n\n",
    "### 环境锁定\n",
    "- 使用 `renv.lock` 文件锁定包版本\n",
    "- 确保团队成员使用相同环境\n",
    "- 定期更新依赖包\n",
    "- 记录环境变更\n\n",
    "### 依赖管理\n",
    "```r\n",
    "# 检查包依赖\n",
    "renv::dependencies()\n",
    "\n",
    "# 更新包\n",
    "renv::update()\n",
    "\n",
    "# 清理未使用的包\n",
    "renv::clean()\n",
    "```\n\n",
    "## 随机种子设置\n\n",
    "### 统一设置随机种子\n",
    "```r\n",
    "# 在每个脚本开头设置\n",
    "set.seed(123)\n",
    "\n",
    "# 或者使用项目级别的种子\n",
    "PROJECT_SEED <- 123\n",
    "set.seed(PROJECT_SEED)\n",
    "```\n\n",
    "### 随机性控制策略\n",
    "- 在脚本开头设置种子\n",
    "- 记录使用的种子值\n",
    "- 避免在循环中重复设置种子\n",
    "- 使用固定的种子进行调试\n\n",
    "### 种子管理示例\n",
    "```r\n",
    "# 种子管理函数\n",
    "set_project_seed <- function(seed = 123) {\n",
    "  set.seed(seed)\n",
    "  message(\"设置项目随机种子: \", seed)\n",
    "}\n",
    "\n",
    "# 在脚本中使用\n",
    "set_project_seed(123)\n",
    "```\n\n",
    "## 结果验证\n\n",
    "### 结果一致性检查\n",
    "```r\n",
    "# 结果验证函数\n",
    "verify_results <- function(current_result, expected_result, tolerance = 1e-6) {\n",
    "  if (is.numeric(current_result) && is.numeric(expected_result)) {\n",
    "    return(all(abs(current_result - expected_result) < tolerance))\n",
    "  } else {\n",
    "    return(identical(current_result, expected_result))\n",
    "  }\n",
    "}\n",
    "\n",
    "# 使用示例\n",
    "model_result <- train_model(data)\n",
    "expected_accuracy <- 0.85\n",
    "is_consistent <- verify_results(model_result$accuracy, expected_accuracy)\n",
    "```\n\n",
    "### 输出文件管理\n",
    "- 使用时间戳命名文件\n",
    "- 保存生成参数\n",
    "- 记录文件大小和修改时间\n",
    "- 定期清理临时文件\n\n",
    "### 结果文档化\n",
    "```r\n",
    "# 结果记录函数\n",
    "record_results <- function(result, output_file) {\n",
    "  # 保存结果\n",
    "  saveRDS(result, output_file)\n",
    "  \n",
    "  # 记录元数据\n",
    "  metadata <- list(\n",
    "    timestamp = Sys.time(),\n",
    "    session_info = sessionInfo(),\n",
    "    parameters = result$parameters\n",
    "  )\n",
    "  \n",
    "  saveRDS(metadata, paste0(output_file, \".meta.rds\"))\n",
    "}\n",
    "```\n\n",
    "## 工作流程记录\n\n",
    "### 分析步骤记录\n",
    "```r\n",
    "# 步骤记录函数\n",
    "log_step <- function(step_name, parameters = NULL) {\n",
    "  log_entry <- list(\n",
    "    step = step_name,\n",
    "    timestamp = Sys.time(),\n",
    "    parameters = parameters\n",
    "  )\n",
    "  \n",
    "  # 保存到日志文件\n",
    "  log_file <- \"analysis_log.rds\"\n",
    "  if (file.exists(log_file)) {\n",
    "    log <- readRDS(log_file)\n",
    "  } else {\n",
    "    log <- list()\n",
    "  }\n",
    "  \n",
    "  log[[length(log) + 1]] <- log_entry\n",
    "  saveRDS(log, log_file)\n",
    "}\n",
    "\n",
    "# 使用示例\n",
    "log_step(\"数据清洗\", list(missing_threshold = 0.5))\n",
    "log_step(\"模型训练\", list(algorithm = \"random_forest\", n_trees = 100))\n",
    "```\n\n",
    "### 参数设置保存\n",
    "```r\n",
    "# 参数配置文件\n",
    "config <- list(\n",
    "  data_file = \"../data/raw/patient_data.csv\",\n",
    "  missing_threshold = 0.5,\n",
    "  random_seed = 123,\n",
    "  model_params = list(\n",
    "    n_trees = 100,\n",
    "    max_depth = 10\n",
    "  )\n",
    ")\n",
    "\n",
    "# 保存配置\n",
    "saveRDS(config, \"analysis_config.rds\")\n",
    "```\n\n",
    "### 执行日志\n",
    "```r\n",
    "# 日志记录\n",
    "log_execution <- function(message) {\n",
    "  timestamp <- format(Sys.time(), \"%Y-%m-%d %H:%M:%S\")\n",
    "  log_message <- paste0(\"[\", timestamp, \"] \", message, \"\\n\")\n",
    "  cat(log_message)\n",
    "  \n",
    "  # 写入日志文件\n",
    "  write(log_message, file = \"execution.log\", append = TRUE)\n",
    "}\n",
    "\n",
    "# 使用示例\n",
    "log_execution(\"开始数据清洗\")\n",
    "log_execution(\"数据清洗完成，处理了1000条记录\")\n",
    "```\n\n",
    "## 版本控制集成\n\n",
    "### Git集成\n",
    "- 提交代码和配置文件\n",
    "- 记录环境变更\n",
    "- 标签重要版本\n",
    "- 分支管理\n\n",
    "### 提交规范\n",
    "```\n",
    "# 提交信息格式\n",
    "feat: 添加新的数据清洗功能\n",
    "fix: 修复模型训练中的错误\n",
    "docs: 更新分析文档\n",
    "refactor: 重构数据处理代码\n",
    "```\n\n",
    "## 最佳实践\n\n",
    "### 环境隔离\n",
    "- 每个项目使用独立环境\n",
    "- 避免全局包污染\n",
    "- 定期清理环境\n\n",
    "### 文档同步\n",
    "- 代码和文档同步更新\n",
    "- 记录重要决策\n",
    "- 维护变更日志\n\n",
    "### 定期检查\n",
    "- 验证结果一致性\n",
    "- 检查环境完整性\n",
    "- 更新依赖包\n",
    "- 备份重要数据\n"
  )
  
  write_if_not_exists(file.path(output_dir, "04_reproducibility.md"), content, overwrite)
}

#' Generate Project Templates
#' @keywords internal
generate_project_templates <- function(output_dir, package_name, overwrite) {
  templates_dir <- file.path(output_dir, "templates")
  ensure_directory(templates_dir)
  
  # 数据字典模板
  data_dictionary_template <- paste0(
    "# 数据字典模板\n\n",
    "## 数据集信息\n",
    "- 数据集名称: [数据集名称]\n",
    "- 创建日期: [YYYY-MM-DD]\n",
    "- 数据来源: [数据来源]\n",
    "- 记录数量: [数量]\n",
    "- 变量数量: [数量]\n\n",
    "## 变量说明\n\n",
    "| 变量名 | 类型 | 取值范围 | 缺失值编码 | 说明 |\n",
    "|--------|------|----------|------------|------|\n",
    "| [变量名] | [字符/数值/日期] | [范围] | [编码] | [说明] |\n",
    "| [变量名] | [字符/数值/日期] | [范围] | [编码] | [说明] |\n",
    "| [变量名] | [字符/数值/日期] | [范围] | [编码] | [说明] |\n\n",
    "## 数据质量报告\n",
    "- 缺失值比例: [比例]\n",
    "- 异常值数量: [数量]\n",
    "- 重复记录: [数量]\n",
    "- 数据完整性: [完整性评分]\n\n",
    "## 数据更新记录\n",
    "| 日期 | 版本 | 变更内容 | 负责人 |\n",
    "|------|------|----------|--------|\n",
    "| [YYYY-MM-DD] | [版本号] | [变更描述] | [姓名] |\n"
  )
  
  # 分析报告模板
  analysis_report_template <- paste0(
    "# 数据分析报告模板\n\n",
    "## 项目信息\n",
    "- 项目名称: [项目名称]\n",
    "- 分析日期: [YYYY-MM-DD]\n",
    "- 分析人员: [姓名]\n",
    "- 报告版本: [版本号]\n\n",
    "## 执行摘要\n",
    "[简要描述分析目的、方法和主要发现]\n\n",
    "## 1. 研究背景\n",
    "### 1.1 研究目的\n",
    "[详细描述研究目的和问题]\n\n",
    "### 1.2 研究假设\n",
    "[列出研究假设]\n\n",
    "## 2. 数据描述\n",
    "### 2.1 数据来源\n",
    "[描述数据来源和收集方法]\n\n",
    "### 2.2 数据概览\n",
    "[描述数据基本特征]\n\n",
    "### 2.3 数据质量\n",
    "[描述数据质量检查结果]\n\n",
    "## 3. 分析方法\n",
    "### 3.1 分析策略\n",
    "[描述分析策略和方法]\n\n",
    "### 3.2 模型选择\n",
    "[描述模型选择和理由]\n\n",
    "## 4. 分析结果\n",
    "### 4.1 描述性统计\n",
    "[描述性统计结果]\n\n",
    "### 4.2 模型结果\n",
    "[模型分析结果]\n\n",
    "### 4.3 假设检验\n",
    "[假设检验结果]\n\n",
    "## 5. 结论和建议\n",
    "### 5.1 主要发现\n",
    "[总结主要发现]\n\n",
    "### 5.2 局限性\n",
    "[分析局限性]\n\n",
    "### 5.3 建议\n",
    "[提出建议]\n\n",
    "## 6. 附录\n",
    "### 6.1 代码清单\n",
    "[列出主要代码文件]\n\n",
    "### 6.2 数据字典\n",
    "[数据字典链接]\n\n",
    "### 6.3 参考文献\n",
    "[参考文献列表]\n"
  )
  
  # 脚本模板
  script_template <- paste0(
    "# ============================================================================\n",
    "# 脚本名称: [脚本名称]\n",
    "# 作者: [姓名]\n",
    "# 日期: [YYYY-MM-DD]\n",
    "# 描述: [脚本功能描述]\n",
    "# 输入: [输入文件]\n",
    "# 输出: [输出文件]\n",
    "# ============================================================================\n\n",
    "# 加载必要的包\n",
    "library(dplyr)\n",
    "library(ggplot2)\n",
    "library(readr)\n\n",
    "# 设置工作目录和参数\n",
    "set.seed(123)\n",
    "input_dir <- \"../data/processed\"\n",
    "output_dir <- \"../output\"\n\n",
    "# 确保输出目录存在\n",
    "if (!dir.exists(output_dir)) {\n",
    "  dir.create(output_dir, recursive = TRUE)\n",
    "}\n\n",
    "# 数据加载 ===\n",
    "data <- readRDS(file.path(input_dir, \"cleaned_data.rds\"))\n",
    "message(\"数据加载完成，共 \", nrow(data), \" 条记录\")\n\n",
    "# 数据预处理 ===\n",
    "# [数据预处理代码]\n\n",
    "# 主要分析 ===\n",
    "# [主要分析代码]\n\n",
    "# 结果保存 ===\n",
    "results <- list(\n",
    "  summary = summary_stats,\n",
    "  model = trained_model,\n",
    "  predictions = predictions\n",
    ")\n\n",
    "saveRDS(results, file.path(output_dir, \"analysis_results.rds\"))\n",
    "message(\"分析完成，结果已保存到 \", output_dir)\n"
  )
  
  # 配置文件模板
  config_template <- paste0(
    "# 项目配置文件\n",
    "# 日期: [YYYY-MM-DD]\n",
    "# 版本: [版本号]\n\n",
    "# 数据文件路径\n",
    "data_paths <- list(\n",
    "  raw_data = \"../data/raw\",\n",
    "  processed_data = \"../data/processed\",\n",
    "  external_data = \"../data/external\"\n",
    ")\n\n",
    "# 输出路径\n",
    "output_paths <- list(\n",
    "  figures = \"../output/figures\",\n",
    "  tables = \"../output/tables\",\n",
    "  reports = \"../output/reports\"\n",
    ")\n\n",
    "# 分析参数\n",
    "analysis_params <- list(\n",
    "  random_seed = 123,\n",
    "  missing_threshold = 0.5,\n",
    "  confidence_level = 0.95\n",
    ")\n\n",
    "# 模型参数\n",
    "model_params <- list(\n",
    "  algorithm = \"random_forest\",\n",
    "  n_trees = 100,\n",
    "  max_depth = 10,\n",
    "  min_samples_split = 5\n",
    ")\n\n",
    "# 保存配置\n",
    "saveRDS(list(\n",
    "  data_paths = data_paths,\n",
    "  output_paths = output_paths,\n",
    "  analysis_params = analysis_params,\n",
    "  model_params = model_params\n",
    "), \"project_config.rds\")\n"
  )
  
  write_if_not_exists(file.path(templates_dir, "data_dictionary_template.md"), data_dictionary_template, overwrite)
  write_if_not_exists(file.path(templates_dir, "analysis_report_template.md"), analysis_report_template, overwrite)
  write_if_not_exists(file.path(templates_dir, "script_template.R"), script_template, overwrite)
  write_if_not_exists(file.path(templates_dir, "config_template.R"), config_template, overwrite)
} 