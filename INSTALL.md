# MassKitUtils 安装说明

## 从GitHub安装

```r
# 安装devtools（如果还没有）
if (!require(devtools)) install.packages("devtools")

# 从GitHub安装MassKitUtils
devtools::install_github("SongbiaoZhu/MassKitUtils")
```

## 从本地文件安装

```r
# 安装本地构建的包
install.packages("MassKitUtils_1.0.0.tar.gz", repos = NULL, type = "source")
```

## 验证安装

```r
library(MassKitUtils)
ls("package:MassKitUtils")
```

## 查看文档

```r
# 查看包帮助
?MassKitUtils

# 查看vignette
vignette("getting-started", package = "MassKitUtils")
```

## 依赖包

MassKitUtils会自动安装以下依赖包：
- openxlsx (Excel文件处理)
- 其他R基础包

## 故障排除

如果安装遇到问题：
1. 确保R版本 >= 3.5.0
2. 更新devtools: `install.packages("devtools")`
3. 检查网络连接
4. 查看错误信息并解决依赖问题
