# MassKitUtils 2.0.0 - 重大重构版本

## 🚨 重大变更 (BREAKING CHANGES)

### 函数重命名
- `install_if_missing()` → `ensure_packages()`
- `generate_dev_standards()` → `create_dev_standards()`
- `install_from_sources()` → `install_from_multiple_sources()`

### 功能移除
- **移除GitHub包安装支持**：所有包管理函数不再支持从GitHub安装包
- **简化包管理架构**：专注于CRAN和Bioconductor的智能检测

### 架构改进
- 重新设计包管理函数参数结构
- 改进错误处理和返回值
- 添加完整的开发规范文档

## 🛠️ 技术改进
- 修复roxygen2弃用警告
- 更新所有文档和示例
- 完善测试覆盖

## ✨ 新增功能
- 添加完整的开发规范文档 (`dev/design/`)
- 改进函数命名一致性
- 增强代码可维护性

---

# MassKitUtils 1.0.0 - 首次发布

## 🎉 欢迎使用 MassKitUtils！

MassKitUtils 是一个综合性的R开发工具包，旨在简化R开发工作流程并提高生产力。

## ✨ 主要功能

### 📦 包管理功能（增强版）
- **多源包安装**: 支持CRAN、Bioconductor包安装
- **智能检测**: 自动检测包源（CRAN/Bioconductor），智能安装
- **批量操作**: 一次性安装和加载多个包
- **版本管理**: 检查包版本信息

### 🏗️ 项目管理功能
- **标准化分析目录创建**: 自动生成完整的分析目录结构
- **目录模板**: 包含R/, data/, docs/, tests/, vignettes/, inst/等标准目录
- **配置文件**: 自动创建README.md, .gitignore, DESCRIPTION, NAMESPACE

### 📁 文件管理功能
- **智能目录创建**: 支持嵌套目录和特殊字符处理
- **错误处理**: 完善的错误处理机制
- **跨平台兼容**: 支持Windows, macOS, Linux

### 📊 数据导出功能
- **专业Excel导出**: 支持多种样式选项
- **自定义设置**: 可自定义颜色、字体、表格样式
- **自动摘要**: 自动添加数据摘要信息

### 🛠️ 开发工具功能
- **开发标准生成**: 自动生成R包开发标准文档
- **忽略文件创建**: 分别创建标准的.gitignore和.Rbuildignore文件
- **智能文件写入**: 避免覆盖现有文件

## 🚀 快速开始

### 安装
```r
# 从GitHub安装
if (!require(devtools)) install.packages("devtools")
devtools::install_github("SongbiaoZhu/MassKitUtils")
```

### 基本使用
```r
library(MassKitUtils)

# 创建分析目录
create_analysis_directory("my_analysis")

# 安装依赖包（支持多源）
ensure_packages(c("dplyr", "ggplot2", "readr"))

# 导出数据到Excel
export_to_excel(mtcars, "output/results.xlsx")

# 创建开发标准
create_dev_standards("dev/")
```

## 🔄 多源包安装示例

```r
# CRAN包安装
ensure_packages(c("dplyr", "ggplot2"))

# Bioconductor包安装
# 注意：ensure_packages 会自动尝试从CRAN和Bioconductor安装包
ensure_packages(c("Biobase", "limma"))

# 多源混合安装
install_from_multiple_sources(
  cran_packages = c("dplyr", "ggplot2"),
  bioc_packages = c("Biobase", "limma")
)
```

## 📊 技术指标

| 指标 | 数值 | 状态 |
|------|------|------|
| 代码行数 | ~1,800行 | ✅ |
| 函数数量 | 16个 | ✅ |
| 测试用例 | 245+个 | ✅ |
| 文档页面 | 完整 | ✅ |
| 测试文件 | 8个 | ✅ |
| 包大小 | 40.6 KB | ✅ |

## 🔧 系统要求

- R >= 3.5.0
- 依赖包: openxlsx
- 支持Windows, macOS, Linux

## 📦 安装方法

### 从GitHub安装
```r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("SongbiaoZhu/MassKitUtils")
```

### 从本地文件安装
```r
install.packages("MassKitUtils_2.0.0.tar.gz", repos = NULL, type = "source")
```

## 🧪 测试覆盖

- **8个测试文件**: 系统化的测试结构
- **245+测试用例**: 全面的功能验证
- **多种测试类型**: 单元测试、集成测试、性能测试
- **错误处理测试**: 完善的边界条件测试

## 📚 文档

- **详细函数文档**: 完整的roxygen2文档
- **开发规范文档**: 完整的开发标准指南
- **最佳实践**: 包含使用建议和故障排除
- **安装说明**: 多种安装方式的支持

## 🔧 代码质量

- **代码规范**: 统一的编码风格
- **错误处理**: 智能的错误处理机制
- **参数验证**: 完善的输入验证
- **性能优化**: 高效的内存和计算管理

## 🎯 目标用户群体

- **R数据分析师**: 需要高效的数据处理工作流程
- **R包开发者**: 需要标准化的开发工具和流程
- **研究团队**: 需要协作和项目管理工具
- **数据科学项目管理者**: 需要项目标准化和文档管理
- **生物信息学研究者**: 需要Bioconductor包管理

## 📞 维护和支持

- **维护者**: Songbiao Zhu
- **邮箱**: zhusongbiao@cimrbj.ac.cn
- **GitHub**: [SongbiaoZhu](https://github.com/SongbiaoZhu)

## 📄 许可证

MIT License - 详见 [LICENSE.md](LICENSE.md)

## 🤝 贡献

欢迎提交Issue和Pull Request！

---

**MassKitUtils** - 让R开发更简单、更高效！ 🎉
