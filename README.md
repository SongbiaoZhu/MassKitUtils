# MassKitUtils

![R](https://img.shields.io/badge/R-%3E%3D%203.5.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Version](https://img.shields.io/badge/Version-1.0.0-orange.svg)

MassKitUtils 是一个综合性的R开发工具包，提供包管理、项目创建、文件操作和数据导出等功能，旨在简化R开发工作流程并提高生产力。

## ✨ 主要功能

### 📦 包管理
- 自动安装缺失的包
- 批量加载包并返回状态
- 检查包版本信息

### 🏗️ 项目管理
- 创建标准化的R项目结构
- 自动生成目录结构和配置文件
- 支持环境设置选项

### 📁 文件管理
- 智能创建目录结构
- 支持嵌套目录和特殊字符
- 完善的错误处理机制

### 📊 数据导出
- 专业Excel数据导出
- 多种样式选项和自定义设置
- 自动添加数据摘要

### 🛠️ 开发工具
- 生成开发标准文档
- 创建项目忽略文件
- 智能文件写入

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

# 创建新项目
create_r_project("my_analysis")

# 安装依赖包
install_if_missing(c("dplyr", "ggplot2", "readr"))

# 导出数据到Excel
export_to_excel(mtcars, "output/results.xlsx")

# 生成开发标准
generate_dev_standards("dev/")
```

## 📚 文档

详细使用说明请参考：
- [安装说明](INSTALL.md)
- [发布说明](RELEASE_NOTES.md)
- [包内vignette](vignettes/getting-started.Rmd)

## 📊 技术指标

- **代码行数**: ~1,500行
- **函数数量**: 15个主要函数
- **测试用例**: 50+个
- **文档**: 完整的roxygen2文档

## 🔧 系统要求

- R >= 3.5.0
- 依赖包: openxlsx
- 支持Windows, macOS, Linux

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

本项目采用MIT许可证 - 详见 [LICENSE.md](LICENSE.md) 文件

## 📞 联系方式

如有问题或建议，请通过以下方式联系：
- 提交GitHub Issue
- 邮箱: zhusongbiao@cimrbj.ac.cn
- GitHub: [SongbiaoZhu](https://github.com/SongbiaoZhu)

---

**MassKitUtils** - 让R开发更简单、更高效！ 🎉
