# MassKitUtils 2.3.1 - 修复项目初始化函数

## 🐛 错误修复 (BUG FIXES)

### 项目初始化函数修复
- **修复 `init_r_project()` 函数**: 现在正确调用 `create_project_standards()` 而不是 `create_dev_standards()`
  - 修复了函数调用错误，确保数据分析项目使用正确的规范文档
  - 更新了参数名称，从 `package_name` 改为 `project_name`
  - 确保项目初始化功能与数据分析项目规范保持一致

---

# MassKitUtils 2.3.0 - 数据分析项目规范功能

## 🎉 新功能 (NEW FEATURES)

### 数据分析项目规范功能
- **新增 `create_project_standards()` 函数**: 创建专门针对数据分析项目的开发规范文档
  - 生成4个核心规范文档：项目概述、数据工作流程、分析标准、可重现性规范
  - 提供实用的项目模板：数据字典、分析报告、脚本、配置文件模板
  - 中文内容为主，适合国内数据分析师使用
  - 与 `init_r_project()` 创建的目录结构完美配合
  - 专注于数据分析项目的核心需求和最佳实践

### 功能特点
- **简单实用**: 专注于最核心、最常用的规范
- **中文友好**: 文档内容以中文为主，便于理解和使用
- **模板丰富**: 提供4个实用的项目模板
- **场景匹配**: 专门针对数据分析项目设计，区别于R包开发规范
- **易于扩展**: 模块化设计，便于后续添加更多规范

## 🛠️ 技术改进
- 新增完整的函数文档和示例
- 添加全面的单元测试覆盖
- 集成到现有的开发工具模块
- 保持与现有函数的一致性

## 📚 文档更新
- 新增 `examples/demo_project_standards.R` 演示脚本
- 更新包级文档，添加新函数引用
- 完整的函数文档和示例

## 🧪 测试
- 新增 `create_project_standards()` 函数的完整测试套件
- 测试覆盖基本功能、参数验证、文件内容验证、错误处理等

---

# MassKitUtils 2.2.0 - 项目初始化功能增强

## 🎉 新功能 (NEW FEATURES)

### 项目初始化功能
- **新增 `init_r_project()` 函数**: 一键创建标准化的R数据分析项目
  - 自动创建RStudio项目文件 (.Rproj)
  - 创建标准目录结构 (data/raw, scripts, output, 等)
  - 生成开发规范文档 (dev/design/)
  - 创建版本控制配置文件 (.gitignore)
  - 智能参数控制，支持自定义设置
  - 完整的项目验证和状态报告

### 功能特点
- **专注场景1**: 设计用于用户已在项目目录中的情况
- **自动项目名称**: 使用目录名作为项目名称，保持一致性
- **灵活配置**: 支持选择性创建各个组件
- **健壮错误处理**: 完善的参数验证和错误处理
- **详细反馈**: 提供完整的项目初始化状态信息

## 🛠️ 技术改进
- 集成 `here` 包进行路径管理
- 集成 `usethis` 包创建RStudio项目
- 调用现有函数 (`setup_analysis_structure`, `create_dev_standards`, `create_gitignore`)
- 完整的单元测试覆盖
- 详细的文档和示例

## 📚 文档更新
- 新增 `examples/demo_project_init.R` 演示脚本
- 更新包级文档，添加新函数引用
- 完整的函数文档和示例

## 🧪 测试
- 新增 `init_r_project()` 函数的完整测试套件
- 测试覆盖基本功能、参数验证、自定义设置、错误处理等

---

# MassKitUtils 2.1.0 - 项目管理功能重构

## 🚨 重大变更 (BREAKING CHANGES)

### 函数替换
- **移除 `create_analysis_directory()` 函数**: 不再支持创建带项目名称的目录
- **新增 `setup_analysis_structure()` 函数**: 在当前目录创建标准分析目录结构

### 设计理念变更
- **简化使用场景**: 更符合RStudio和Cursor的实际工作流程
- **无参数调用**: 直接在当前目录工作，无需指定项目名称和路径
- **支持覆盖选项**: 可以覆盖已存在的目录
- **静默模式**: 支持静默创建目录结构

## 🛠️ 技术改进
- 更新函数文档和示例
- 添加新的演示脚本 (`examples/demo_project_setup.R`)
- 完善参数验证和错误处理
- 移除旧函数的测试，添加新函数的完整测试覆盖

---

# MassKitUtils 2.0.0 - 重大重构版本

## 🚨 重大变更 (BREAKING CHANGES)

### 包名变更
- **包名从 `MSCRUtils` 更改为 `MassKitUtils`**
- 更新所有函数文档和示例中的包名引用

### 函数重构
- **`ensure_packages()`**: 增强多源包安装支持，自动检测CRAN和Bioconductor
- **`load_packages()`**: 新增函数，提供包加载的错误处理
- **`check_package_versions()`**: 新增函数，检查包版本和依赖
- **`install_from_multiple_sources()`**: 新增函数，支持从多个源安装包

### 项目管理功能
- **`setup_analysis_structure()`**: 重构项目目录创建功能
- **`create_dev_standards()`**: 新增开发标准文档生成功能
- **`create_gitignore()`**: 新增Git忽略文件创建功能
- **`create_rbuildignore()`**: 新增R包构建忽略文件创建功能

### 数据导出功能
- **`export_to_excel()`**: 重构Excel导出功能，支持多种样式和格式
- **`add_summary_sheet()`**: 新增汇总表添加功能
- **`apply_header_style()`**: 新增表头样式应用功能
- **`apply_table_style()`**: 新增表格样式应用功能

## 🛠️ 技术改进
- 更新所有函数文档，使用roxygen2格式
- 添加完整的单元测试覆盖
- 改进错误处理和参数验证
- 支持静默模式和详细输出模式
- 添加包级文档和示例

## 📚 文档更新
- 重写所有函数文档
- 添加包级文档 (`?MassKitUtils`)
- 创建演示脚本和示例
- 更新README.md和NEWS.md

## 🧪 测试
- 添加完整的testthat测试套件
- 测试覆盖所有主要功能
- 包含错误处理和边界情况测试

---

# MassKitUtils 1.0.0 - 初始版本

## 🎉 初始功能
- 基础包管理功能
- 简单的项目创建功能
- 基础数据导出功能

## 📚 文档
- 基础函数文档
- README.md

## 🧪 测试
- 基础功能测试
