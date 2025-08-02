# MSCRUtils 开发标准与规范

## 总体设计原则

### 核心设计理念

MSCRUtils遵循**简洁性、一致性、可扩展性**三大核心原则：

1. **简洁性**: 每个函数职责明确，接口简洁易用
2. **一致性**: 相似功能保持一致的参数结构和返回格式
3. **可扩展性**: 支持渐进式复杂度，满足不同用户需求

### 函数设计原则

#### 单一职责原则
每个函数只负责一个明确的功能，避免功能耦合。

```r
# 正确：职责明确
install_if_missing()        # 只负责安装缺失包
load_packages()            # 只负责加载包
export_to_excel()          # 只负责Excel导出

# 错误：功能耦合
do_everything()            # 包含安装、加载、处理、导出
```

#### 接口一致性原则
相似功能的函数保持一致的参数结构。

```r
# 所有导出函数遵循相同模式
export_to_excel(data, filename, ...)
export_to_csv(data, filename, ...)
export_to_json(data, filename, ...)

# 统一返回类型: 成功时返回invisible(NULL)，失败时抛出错误
```

#### 渐进式复杂度原则
提供从简单到复杂的多层次接口。

```r
# 第一层：极简接口（默认参数）
export_to_excel(mtcars, "cars.xlsx")

# 第二层：常用参数接口
export_to_excel(mtcars, "cars.xlsx", 
               header_style = "colored", 
               table_style = "striped")

# 第三层：完全自定义接口
export_to_excel(mtcars, "cars.xlsx",
               header_style = "colored",
               table_style = "striped",
               header_bg_color = "#4F81BD",
               font_size = 12,
               add_summary = TRUE)
```

## 编码规范

### 命名约定

#### 函数命名规范
按功能分类，使用一致的命名模式：

- **包管理函数**: `install_*`, `load_*`, `check_*` - 包管理相关
- **项目函数**: `create_*` - 创建项目结构
- **文件函数**: `ensure_*` - 文件系统操作
- **导出函数**: `export_to_*` - 数据导出
- **内部函数**: 以`.`开头，如`.validate_input()`, `.apply_style()`

#### 命名示例
```r
# 包管理函数
install_if_missing()
load_packages()
check_package_versions()

# 项目函数
create_r_project()

# 文件函数
ensure_directory()

# 导出函数
export_to_excel()

# 内部函数
.validate_input()
.apply_header_style()
.apply_table_style()
```

#### 变量和对象命名
- **变量**: snake_case，如`sample_data`, `output_path`, `header_style`
- **布尔变量**: 以`is_`, `has_`, `can_`开头
- **常量**: 全大写，如`DEFAULT_STYLES`, `REQUIRED_COLUMNS`
- **S4类名**: PascalCase，如`MSCRConnection`, `ExperimentConfig`
- **slot名**: snake_case，如`connection_string`, `query_results`

### 代码结构规范

#### 文件组织标准
```r
# 文件头部注释
#' @title 文件功能简述
#' @description 详细功能描述
#' @author MSCRUtils Development Team

# 依赖包导入
#' @import openxlsx
#' @importFrom utils install.packages installed.packages

# 常量定义
DEFAULT_STYLES <- c("default", "bold", "colored", "minimal")
REQUIRED_COLUMNS <- c("ProteinName", "PeptideSequence", "Intensity")

# 主要函数实现 =============================================================

# 辅助函数实现 =============================================================

# 内部函数实现 =============================================================
```

#### 函数结构模板
```r
#' Function title in English
#'
#' Detailed description of function purpose and behavior.
#'
#' @param param1 Type. Description of first parameter
#' @param param2 Type. Description of second parameter (default: value)
#' @return Return type and description
#' @export
#' @examples
#' \dontrun{
#' # Usage example
#' result <- function_name(param1, param2)
#' }
function_name <- function(
  # 第一层：必需参数
  required_param1,
  required_param2,
  
  # 第二层：常用参数（有合理默认值）
  common_param1 = default_value,
  common_param2 = TRUE,
  
  # 第三层：高级参数
  advanced_config = list(),
  
  # 第四层：系统参数
  verbose = TRUE,
  debug = FALSE
) {
  # 1. 参数验证
  .validate_input_parameters(...)
  
  # 2. 主要逻辑实现
  result <- .perform_main_logic(...)
  
  # 3. 结果验证和返回
  .validate_output(result)
  return(result)
}
```

#### 注释规范

**分节注释格式规范**

为了便于IDE（特别是Cursor）正确显示代码分节结构，必须使用以下标准格式：

**✅ 推荐格式（单行注释）**：
```r
# 包管理函数

#' Install packages if missing
#' @param packages Character vector of package names
#' @return Invisible NULL
#' @export
install_if_missing <- function(packages) {
  # 函数实现
}

# 数据导出函数

#' Export data to Excel
#' @param data Data frame to export
#' @param filename Output file name
#' @return Invisible NULL
#' @export
export_to_excel <- function(data, filename) {
  # 函数实现
}

# 内部辅助函数

# 更多函数定义...
```

**❌ 废弃格式（多行等号分隔）**：
```r
# ==============================================================================
# 包管理函数  
# ==============================================================================

# 这种格式不利于IDE显示节标题，已废弃，请勿使用
```

**分节注释命名规范**：
- 使用简洁、描述性的中文标题
- 功能相关的函数归入同一分节
- 常见分节包括：
  - `# 包管理函数`
  - `# 项目创建函数`
  - `# 文件管理函数`
  - `# 数据导出函数`
  - `# 内部辅助函数`

**行内注释规范**：
```r
# 检查包是否已安装
missing_packages <- packages[!packages %in% installed.packages()[,"Package"]]

# 创建工作簿并添加工作表
wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(wb, sheet_name)

# 应用表头样式
apply_header_style(wb, sheet_name, data, header_style, 
                  header_bg_color, header_font_color, font_size)
```

## 错误处理与验证规范

### 参数验证标准
```r
# 必需参数检查
if (missing(data) || is.null(data)) {
  stop("参数 'data' 是必需的，不能为空")
}

# 文件存在性检查
if (!file.exists(filename)) {
  stop(sprintf("文件不存在: %s", filename))
}

# 参数类型检查
if (!is.character(packages) || length(packages) == 0) {
  stop("参数 'packages' 必须是非空的字符向量")
}

# 参数值范围检查
if (!header_style %in% c("default", "bold", "colored", "minimal")) {
  stop(sprintf("不支持的样式类型: %s", header_style))
}
```

### 数据验证标准
```r
# 数据完整性检查
if (!is.data.frame(data)) {
  stop("参数 'data' 必须是数据框")
}

# 数据质量检查
if (nrow(data) == 0) {
  stop("输入数据为空，无法进行导出")
}

# 数据类型检查
if (!is.numeric(data$Intensity)) {
  warning("强度列不是数值类型，尝试转换")
  data$Intensity <- as.numeric(data$Intensity)
}
```

### 错误处理模板
```r
function_with_error_handling <- function(params...) {
  tryCatch({
    # 主要逻辑
    result <- main_processing_logic(...)
    return(result)
    
  }, error = function(e) {
    # 分类错误处理，提供友好的错误信息
    if (grepl("file not found", e$message)) {
      stop("文件操作失败：请检查文件路径是否正确\n详细错误: ", e$message)
    } else if (grepl("package not found", e$message)) {
      stop("包未找到：请先安装所需包\n详细错误: ", e$message)
    } else {
      stop("操作失败: ", e$message)
    }
  })
}
```

## 测试规范

### 单元测试结构
```r
# tests/testthat/test-package-management.R
test_that("install_if_missing 基本功能测试", {
  # 准备测试数据
  test_packages <- c("testthat", "devtools")
  
  # 执行测试
  expect_silent(install_if_missing(test_packages))
})

test_that("export_to_excel 基本功能测试", {
  # 准备测试数据
  test_data <- data.frame(x = 1:5, y = letters[1:5])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 执行测试
  expect_silent(export_to_excel(test_data, test_file))
  expect_true(file.exists(test_file))
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 错误处理测试", {
  # 测试缺失参数
  expect_error(export_to_excel(), "参数 'data' 是必需的")
  
  # 测试无效数据
  expect_error(export_to_excel(NULL, "test.xlsx"), "参数 'data' 必须是数据框")
})
```

### 集成测试规范
```r
# tests/testthat/test-integration.R
test_that("完整工作流程测试", {
  # 1. 安装和加载包
  install_if_missing(c("dplyr", "ggplot2"))
  load_status <- load_packages(c("dplyr", "ggplot2"))
  expect_true(all(load_status))
  
  # 2. 创建目录
  test_dir <- tempdir()
  ensure_directory(file.path(test_dir, "output"))
  
  # 3. 导出数据
  test_data <- mtcars
  output_file <- file.path(test_dir, "output", "test.xlsx")
  expect_silent(export_to_excel(test_data, output_file))
  expect_true(file.exists(output_file))
  
  # 清理
  unlink(file.path(test_dir, "output"), recursive = TRUE)
})
```

## 文档规范

### roxygen2文档标准
```r
#' Export data to Excel file with formatting options
#'
#' This function exports data frames to Excel files with comprehensive
#' formatting options including header styles, table styles, and
#' customizable colors and fonts.
#'
#' @param data Data frame to export
#' @param filename Character string for the output file name
#' @param sheet_name Character string for the worksheet name (default: "Data")
#' @param header_style Character string for header style. Options:
#'   \itemize{
#'     \item "default" - Gray background, centered, bold
#'     \item "bold" - Bold text only
#'     \item "colored" - Blue background, white text, centered
#'     \item "minimal" - Bold text only
#'   }
#' @param table_style Character string for table style. Options:
#'   \itemize{
#'     \item "default" - Top and bottom borders
#'     \item "bordered" - Full borders on all cells
#'     \item "striped" - Alternating row colors
#'     \item "minimal" - No borders
#'   }
#' @param header_bg_color Character string for header background color (hex code)
#' @param header_font_color Character string for header font color (hex code)
#' @param border_color Character string for border color (hex code)
#' @param font_size Numeric value for font size
#' @param auto_width Logical, whether to auto-adjust column widths (default: TRUE)
#' @param freeze_pane Logical, whether to freeze the first row (default: TRUE)
#' @param add_summary Logical, whether to add summary statistics (default: FALSE)
#' @param format_table Logical, whether to apply table formatting (default: TRUE)
#'
#' @return Invisible NULL
#'
#' @details
#' This function requires the openxlsx package to be installed. If the package
#' is not available, the function will stop with an error message.
#'
#' The function automatically creates output directories if they don't exist
#' and provides comprehensive error handling for various failure scenarios.
#'
#' @examples
#' \dontrun{
#' # Basic usage
#' export_to_excel(mtcars, "cars.xlsx")
#'
#' # With custom styling
#' export_to_excel(mtcars, "cars_styled.xlsx", 
#'                header_style = "colored", 
#'                table_style = "striped")
#'
#' # With summary sheet
#' export_to_excel(mtcars, "cars_with_summary.xlsx",
#'                add_summary = TRUE)
#' }
#'
#' @seealso \code{\link{install_if_missing}}, \code{\link{create_r_project}}
#' @export
```

### 包级文档标准
```r
#' MSCRUtils: Utility Functions for R Development and Data Export
#'
#' MSCRUtils provides a comprehensive set of utility functions for R package
#' management, project creation, file management, and data export.
#'
#' @section Key Features:
#' \itemize{
#'   \item Package management with automatic installation and loading
#'   \item Project creation with standardized directory structure
#'   \item File system operations with error handling
#'   \item Excel export with comprehensive formatting options
#' }
#'
#' @section Main Functions:
#' \itemize{
#'   \item \code{\link{install_if_missing}}: Install packages if missing
#'   \item \code{\link{load_packages}}: Load packages with error handling
#'   \item \code{\link{check_package_versions}}: Check package versions
#'   \item \code{\link{create_r_project}}: Create new R projects
#'   \item \code{\link{ensure_directory}}: Ensure directories exist
#'   \item \code{\link{export_to_excel}}: Export data to Excel
#' }
#'
#' @docType package
#' @name MSCRUtils-package
NULL
```

## Package开发工作目录管理

### 标准目录结构
```
MSCRUtils/
├── DESCRIPTION              # 包描述文件
├── NAMESPACE               # 命名空间文件
├── LICENSE                 # 开源许可证
├── README.md               # 项目说明文档
├── NEWS.md                 # 版本更新日志
├── .Rbuildignore          # R包构建忽略文件
├── .gitignore             # Git忽略文件
├── .github/               # GitHub配置
│   └── workflows/         # GitHub Actions工作流
├── R/                     # R源代码
│   ├── 01_package_management.R    # 包管理函数
│   ├── 05_project_management.R    # 项目创建函数
│   ├── 10_file_management.R       # 文件管理函数
│   ├── 15_data_export.R          # 数据导出函数
│   ├── 25_utility_functions.R     # 辅助函数
│   ├── 99_zzz.R                  # 包加载配置
│   └── MSCRUtils-package.R       # 包级文档
├── man/                   # 自动生成的帮助文档
├── tests/                 # 测试文件
│   ├── testthat/         # testthat测试
│   └── testthat.R        # 测试配置
├── inst/                  # 安装时包含的文件
│   └── extdata/          # 内置示例数据
├── data/                  # 包内置数据
├── data-raw/             # 原始数据处理脚本
├── vignettes/            # 包文档和教程
├── examples/             # 示例脚本
└── docs/                 # 项目文档
    └── development_standards.md  # 开发规范
```

### 文件命名规范
- **R文件**: 按功能模块编号，如`01_package_management.R`, `05_project_management.R`
- **测试文件**: `test-功能名.R`，如`test-package-management.R`
- **数据文件**: 描述性名称，如`example_data.rda`
- **文档文件**: 英文命名，如`development_standards.md`

### 开发环境配置
```r
# 开发环境必需包
install.packages(c(
  "devtools",     # 开发工具
  "usethis",      # 项目配置
  "testthat",     # 单元测试
  "roxygen2",     # 文档生成
  "pkgdown",      # 网站生成
  "lintr",        # 代码检查
  "styler",       # 代码格式化
  "covr"          # 覆盖率测试
))

# 项目初始化
usethis::create_package("MSCRUtils")
usethis::use_git()
usethis::use_github()
usethis::use_testthat()
usethis::use_roxygen_md()
usethis::use_pkgdown()
```

## Git版本控制规范

### Git基本配置
```bash
# 初始化Git仓库
git init

# 配置用户信息
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 配置中文文件名支持
git config --global core.quotepath false

# 配置换行符处理
git config --global core.autocrlf input  # Linux/Mac
git config --global core.autocrlf true   # Windows
```

### 提交规范

#### 提交信息格式
```
type(scope): subject

body

footer
```

类型包括：
- `feat`: 新功能
- `fix`: 错误修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建/工具相关

#### 提交示例
```bash
# 好的提交示例
git commit -m "feat(excel-export): add comprehensive Excel export function

- 支持多种表头和表格样式
- 添加自定义颜色和字体选项
- 支持自动列宽和冻结窗格
- 添加可选的摘要工作表
- 完善错误处理和参数验证

Related issues: #12"

# 简单修复
git commit -m "fix(validation): fix package name validation"

# 文档更新
git commit -m "docs(api): update export_to_excel function documentation"
```

### 分支管理策略

#### 主要分支
- `main`: 主分支，始终保持稳定可发布状态
- `develop`: 开发分支，集成最新开发功能
- `release/v1.0.0`: 发布准备分支
- `hotfix/critical-bug`: 紧急修复分支

#### 功能分支
- `feature/新功能名`: 功能开发分支
- `bugfix/问题描述`: 错误修复分支
- `improvement/改进描述`: 功能改进分支

#### 分支操作示例
```bash
# 创建并切换到功能分支
git checkout -b feature/maxquant-support

# 开发完成后推送分支
git push -u origin feature/maxquant-support

# 合并到develop分支
git checkout develop
git merge feature/maxquant-support

# 已合并的功能分支暂时保留，不立即删除
# git branch -d feature/maxquant-support
# git push origin --delete feature/maxquant-support
```

### 常用Git操作规范

#### 日常开发流程
```bash
# 1. 更新本地代码
git pull origin develop

# 2. 创建功能分支
git checkout -b feature/new-feature

# 3. 开发过程中频繁提交
git add .
git commit -m "feat(module): add basic framework for new feature"

# 4. 推送到远程分支
git push -u origin feature/new-feature

# 5. 开发完成后合并到develop
git checkout develop
git pull origin develop
git merge feature/new-feature
git push origin develop
```

#### 代码审查流程
```bash
# 1. 创建Pull Request前整理提交历史
git rebase -i HEAD~3  # 整理最近3次提交

# 2. 强制推送整理后的提交（谨慎使用）
git push --force-with-lease origin feature/new-feature

# 3. 审查通过后合并（使用squash merge）
git checkout develop
git merge --squash feature/new-feature
git commit -m "feat(feature): complete feature description"
```

#### 紧急修复流程
```bash
# 1. 从main分支创建hotfix分支
git checkout main
git checkout -b hotfix/critical-bug

# 2. 修复问题并提交
git add .
git commit -m "fix(critical): fix critical issue affecting production environment"

# 3. 同时合并到main和develop
git checkout main
git merge hotfix/critical-bug
git tag v1.0.1
git push origin main --tags

git checkout develop
git merge hotfix/critical-bug
git push origin develop
```

#### Git最佳实践
```bash
# 使用.gitignore忽略不必要的文件
echo "*.Rproj" >> .gitignore
echo ".Rproj.user/" >> .gitignore
echo ".RData" >> .gitignore
echo ".Rhistory" >> .gitignore

# 定期清理本地分支
git branch --merged | grep -v "\*\|main\|develop" | xargs -n 1 git branch -d

# 查看分支关系图
git log --oneline --graph --all

# 查看某个文件的修改历史
git log --follow -p -- R/01_package_management.R

# 临时保存工作区变更
git stash push -m "temp save: feature under development"
git stash pop
```

## 性能规范

### 内存使用优化
```r
# 推荐：使用data.table进行内存高效操作
library(data.table)
data <- fread("large_dataset.txt")
data[, log_intensity := log2(Intensity + 1)]

# 推荐：及时清理大对象
rm(large_intermediate_data)

# 推荐：使用引用修改避免复制
# 注意，引用的功能，作为高级开发版本才实现，避免错误
data[, processed := process_values(raw_values)]
```

### 计算效率优化
```r
# 推荐：向量化操作
data[, log_intensity := log2(Intensity + 1)]

# 不推荐：循环操作
for (i in 1:nrow(data)) {
  data$log_intensity[i] <- log2(data$Intensity[i] + 1)
}

# 推荐：data.table高效分组操作
summary_stats <- data[, .(
  mean_intensity = mean(Intensity, na.rm = TRUE),
  median_intensity = median(Intensity, na.rm = TRUE),
  n_observations = .N
), by = .(ProteinName, Condition)]

# 推荐：合理使用并行计算
library(parallel)
results <- mclapply(protein_list, process_protein, mc.cores = 4)
``` 