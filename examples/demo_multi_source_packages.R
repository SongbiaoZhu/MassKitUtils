# 多源包安装演示脚本
# examples/demo_multi_source_packages.R

library(MassKitUtils)

cat("=== MassKitUtils 多源包安装演示 ===\n\n")

# 1. CRAN包安装演示
cat("1. CRAN包安装演示\n")
cat("安装基础数据分析包...\n")
install_if_missing(c("dplyr", "ggplot2", "readr", "tidyr"))

# 2. Bioconductor包安装演示
cat("\n2. Bioconductor包安装演示\n")
cat("安装生物信息学包...\n")
install_if_missing(c("BiocManager", "Biobase"), bioc = TRUE)

# 3. GitHub包安装演示
cat("\n3. GitHub包安装演示\n")
cat("安装GitHub上的包...\n")
install_if_missing(github_packages = c("devtools" = "r-lib/devtools"))

# 4. 混合安装演示
cat("\n4. 混合安装演示\n")
cat("同时安装来自不同来源的包...\n")
install_from_sources(
  cran_packages = c("magrittr", "stringr"),
  bioc_packages = c("BiocManager"),
  github_packages = c("devtools" = "r-lib/devtools")
)

# 5. 包版本检查演示
cat("\n5. 包版本检查演示\n")
cat("检查已安装包的版本...\n")
versions <- check_package_versions(c("dplyr", "ggplot2", "devtools"))
print(versions)

# 6. 包加载演示
cat("\n6. 包加载演示\n")
cat("加载包并检查状态...\n")
load_status <- load_packages(c("dplyr", "ggplot2"), quiet = FALSE)
print(load_status)

# 7. 错误处理演示
cat("\n7. 错误处理演示\n")
cat("尝试安装不存在的包...\n")
tryCatch({
  install_if_missing(github_packages = c("nonexistent" = "user/nonexistent-repo"))
}, warning = function(w) {
  cat("捕获到警告:", w$message, "\n")
})

# 8. 静默模式演示
cat("\n8. 静默模式演示\n")
cat("使用静默模式安装包...\n")
install_if_missing(c("utils"), quiet = TRUE)
cat("静默安装完成\n")

# 9. 自定义仓库演示
cat("\n9. 自定义仓库演示\n")
cat("使用自定义CRAN镜像...\n")
custom_repos <- c(CRAN = "https://cran.rstudio.com/")
install_if_missing(c("utils"), repos = custom_repos)

# 10. 依赖处理演示
cat("\n10. 依赖处理演示\n")
cat("安装包及其依赖...\n")
install_if_missing(c("dplyr"), dependencies = TRUE)

cat("\n=== 多源包安装演示完成 ===\n")
cat("MSCRUtils 支持从以下来源安装包：\n")
cat("- CRAN: 使用 install.packages()\n")
cat("- Bioconductor: 自动安装BiocManager并使用BiocManager::install()\n")
cat("- GitHub: 自动安装devtools并使用devtools::install_github()\n")
cat("- 混合安装: 使用 install_from_sources() 一次性安装来自不同来源的包\n\n")

cat("主要功能特点：\n")
cat("✓ 自动检查包是否已安装\n")
cat("✓ 自动安装必要的工具（BiocManager, devtools）\n")
cat("✓ 完善的错误处理机制\n")
cat("✓ 支持静默模式\n")
cat("✓ 支持自定义仓库\n")
cat("✓ 支持依赖管理\n")
cat("✓ 清晰的进度消息\n") 