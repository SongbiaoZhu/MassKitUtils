#!/usr/bin/env Rscript
# ============================================================================
# GitHub发布脚本
# ============================================================================
# 此脚本帮助将MassKitUtils包发布到GitHub

# 检查必要的包
required_packages <- c("devtools", "usethis")
missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]

if (length(missing_packages) > 0) {
  cat("正在安装必要的包:", paste(missing_packages, collapse = ", "), "\n")
  install.packages(missing_packages)
}

library(devtools)
library(usethis)

# 配置GitHub仓库
cat("=== GitHub发布配置 ===\n")

# 设置GitHub用户名和仓库名
github_username <- "SongbiaoZhu"
repo_name <- "MassKitUtils"

cat("GitHub用户名:", github_username, "\n")
cat("仓库名:", repo_name, "\n")

# 检查当前目录是否为R包
if (!file.exists("DESCRIPTION")) {
  stop("当前目录不是R包目录，请确保在MassKitUtils包根目录下运行此脚本")
}

# 读取包信息
desc <- read.dcf("DESCRIPTION")
package_name <- desc[1, "Package"]
version <- desc[1, "Version"]

cat("包名:", package_name, "\n")
cat("版本:", version, "\n")

# 检查Git状态
cat("\n=== 检查Git状态 ===\n")
system("git status")

# 检查远程仓库
cat("\n=== 检查远程仓库 ===\n")
remote_output <- system("git remote -v", intern = TRUE)
if (length(remote_output) == 0) {
  cat("未配置远程仓库，正在添加GitHub远程仓库...\n")
  
  # 添加GitHub远程仓库
  remote_url <- paste0("https://github.com/", github_username, "/", repo_name, ".git")
  system(paste("git remote add origin", remote_url))
  cat("已添加远程仓库:", remote_url, "\n")
} else {
  cat("当前远程仓库配置:\n")
  cat(paste(remote_output, collapse = "\n"), "\n")
}

# 推送代码到GitHub
cat("\n=== 推送代码到GitHub ===\n")
cat("正在推送main分支...\n")
system("git push -u origin main")

# 推送标签
cat("正在推送标签...\n")
system("git push origin --tags")

cat("\n=== 发布完成 ===\n")
cat("您的包已成功推送到GitHub!\n")
cat("GitHub仓库地址: https://github.com/", github_username, "/", repo_name, "\n", sep = "")

# 提供安装指令
cat("\n=== 安装指令 ===\n")
cat("用户可以使用以下命令安装您的包:\n")
cat("devtools::install_github('", github_username, "/", repo_name, "')\n", sep = "")

# 检查是否需要创建GitHub Release
cat("\n=== GitHub Release ===\n")
cat("建议您在GitHub网页上创建Release:\n")
cat("1. 访问: https://github.com/", github_username, "/", repo_name, "/releases\n", sep = "")
cat("2. 点击 'Create a new release'\n")
cat("3. 选择标签: v", version, "\n", sep = "")
cat("4. 填写发布标题和描述\n")
cat("5. 上传构建的包文件（可选）\n")

# 构建包文件（可选）
cat("\n=== 构建包文件 ===\n")
cat("是否要构建包文件用于发布? (y/n): ")
response <- readline()

if (tolower(response) %in% c("y", "yes", "是")) {
  cat("正在构建包文件...\n")
  
  # 构建源码包
  system("R CMD build .")
  
  # 构建二进制包（Windows）
  if (.Platform$OS.type == "windows") {
    system("R CMD INSTALL --build .")
  }
  
  cat("包文件构建完成！\n")
  cat("您可以将这些文件上传到GitHub Release中。\n")
}

cat("\n=== 发布流程完成 ===\n")
cat("恭喜！MassKitUtils包已成功发布到GitHub。\n") 