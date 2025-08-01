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

# 混合安装
install_from_multiple_sources(
  cran_packages = c("dplyr", "ggplot2"),
  bioc_packages = c("Biobase", "limma")
)
```

## 📊 技术指标

- **代码行数**: ~1,600行
- **函数数量**: 16个主要函数
- **测试用例**: 60+个
- **文档**: 完整的roxygen2文档
- **包大小**: 40.6 KB

## 🔧 系统要求

- R >= 3.5.0
- 依赖包: openxlsx
- 支持Windows, macOS, Linux

## 📚 文档

详细使用说明请参考：
- 包内vignette: `vignette("getting-started", package = "MassKitUtils")`
- 函数帮助: `?function_name`

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

MIT License - 详见 [LICENSE.md](LICENSE.md)

## 👨‍💻 维护者

- **维护者**: Songbiao Zhu
- **邮箱**: zhusongbiao@cimrbj.ac.cn
- **GitHub**: [SongbiaoZhu](https://github.com/SongbiaoZhu)

---

**MassKitUtils** - 让R开发更简单、更高效！ 🎉
