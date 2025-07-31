# MassKitUtils 1.0.0 - 初始发布

## 🎉 首次发布

MassKitUtils 是一个综合性的R开发工具包，提供包管理、项目创建、文件操作和数据导出等功能。

## ✨ 主要功能

### 包管理功能（增强版）
- `install_if_missing()`: 自动安装缺失的包（支持CRAN、Bioconductor、GitHub）
- `install_from_sources()`: 多源包混合安装
- `load_packages()`: 批量加载包并返回状态
- `check_package_versions()`: 检查包版本信息

### 项目管理功能
- `create_r_project()`: 创建标准化的R项目结构
- 自动生成项目目录结构（R/, data/, docs/, tests/, vignettes/, inst/）
- 自动创建README.md, .gitignore, DESCRIPTION, NAMESPACE文件

### 文件管理功能
- `ensure_directory()`: 智能创建目录结构
- 支持嵌套目录创建和特殊字符处理

### 数据导出功能
- `export_to_excel()`: 专业Excel数据导出
- 支持多种样式选项和自定义设置

### 开发工具功能
- `generate_dev_standards()`: 生成开发标准文档
- `create_ignore_files()`: 创建项目忽略文件

## 🔄 多源包安装功能

### 支持的包源
1. **CRAN包**: 使用标准的`install.packages()`函数
2. **Bioconductor包**: 自动安装BiocManager并使用`BiocManager::install()`
3. **GitHub包**: 自动安装devtools并使用`devtools::install_github()`

### 使用示例
```r
# CRAN包安装
install_if_missing(c("dplyr", "ggplot2"))

# Bioconductor包安装
install_if_missing(c("Biobase", "limma"), bioc = TRUE)

# GitHub包安装
install_if_missing(github_packages = c("rmarkdown" = "rstudio/rmarkdown"))

# 混合安装
install_from_sources(
  cran_packages = c("dplyr", "ggplot2"),
  bioc_packages = c("Biobase", "limma"),
  github_packages = c("rmarkdown" = "rstudio/rmarkdown")
)
```

## 📦 安装方法

```r
# 从GitHub安装
if (!require(devtools)) install.packages("devtools")
devtools::install_github("SongbiaoZhu/MassKitUtils")
```

## 🚀 快速开始

```r
library(MassKitUtils)

# 创建新项目
create_r_project("my_analysis")

# 安装依赖包（支持多源）
install_if_missing(c("dplyr", "ggplot2", "readr"))

# 导出数据到Excel
export_to_excel(mtcars, "output/results.xlsx")
```

## 📊 技术指标

- **代码行数**: ~1,600行
- **函数数量**: 16个主要函数
- **测试用例**: 60+个
- **文档**: 完整的roxygen2文档和vignette
- **包大小**: 40.6 KB

## 🔧 系统要求

- R >= 3.5.0
- 依赖包: openxlsx
- 支持Windows, macOS, Linux

## 📚 文档

详细使用说明请参考包内vignette:
```r
vignette("getting-started", package = "MassKitUtils")
```

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

MIT License

## 👨‍💻 维护者

- **维护者**: Songbiao Zhu
- **邮箱**: zhusongbiao@cimrbj.ac.cn
- **GitHub**: [SongbiaoZhu](https://github.com/SongbiaoZhu)
- **工作单位**: 中国医学科学院
- **专业领域**: 质谱分析、生物学、编程

---

**注意**: 这是初始版本，建议在生产环境使用前充分测试。
