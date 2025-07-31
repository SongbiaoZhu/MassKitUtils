# 多源包安装测试
# tests/testthat/test-multi-source-packages.R

test_that("install_if_missing handles CRAN packages correctly", {
  # 测试CRAN包安装
  expect_message(
    install_if_missing(c("utils", "stats")), 
    "All packages are already installed"
  )
  
  # 测试错误处理
  expect_error(install_if_missing(NULL))
  expect_error(install_if_missing(character(0)))
})

test_that("install_if_missing handles Bioconductor packages correctly", {
  # 测试Bioconductor包安装（这些包通常已安装）
  expect_message(
    install_if_missing(c("BiocManager"), bioc = TRUE), 
    "All packages are already installed"
  )
})

test_that("install_if_missing handles GitHub packages correctly", {
  # 测试GitHub包安装（需要devtools）
  expect_message(
    install_if_missing(github_packages = c("devtools" = "r-lib/devtools")), 
    "All GitHub packages are already installed"
  )
})

test_that("install_from_sources handles mixed installation correctly", {
  # 测试混合安装
  expect_message(
    install_from_sources(
      cran_packages = c("utils", "stats"),
      bioc_packages = c("BiocManager"),
      github_packages = c("devtools" = "r-lib/devtools")
    ),
    "Multi-source installation completed"
  )
})

test_that("install_from_sources validates parameters correctly", {
  # 测试参数验证
  expect_error(install_from_sources())
  expect_error(install_from_sources(cran_packages = NULL, bioc_packages = NULL, github_packages = NULL))
})

test_that("package installation handles dependencies correctly", {
  # 测试依赖处理
  expect_message(
    install_if_missing(c("utils"), dependencies = TRUE),
    "All packages are already installed"
  )
})

test_that("package installation handles quiet mode correctly", {
  # 测试静默模式
  expect_silent(
    install_if_missing(c("utils"), quiet = TRUE)
  )
})

test_that("GitHub package installation handles errors gracefully", {
  # 测试GitHub包安装错误处理
  expect_warning(
    install_if_missing(github_packages = c("nonexistent" = "user/nonexistent-repo"))
  )
})

test_that("Bioconductor installation handles BiocManager correctly", {
  # 测试BiocManager处理
  if (requireNamespace("BiocManager", quietly = TRUE)) {
    expect_message(
      install_if_missing(c("BiocManager"), bioc = TRUE),
      "All packages are already installed"
    )
  }
})

test_that("devtools installation for GitHub packages works correctly", {
  # 测试devtools安装
  if (requireNamespace("devtools", quietly = TRUE)) {
    expect_message(
      install_if_missing(github_packages = c("devtools" = "r-lib/devtools")),
      "All GitHub packages are already installed"
    )
  }
})

test_that("multi-source installation provides clear progress messages", {
  # 测试进度消息
  expect_message(
    install_from_sources(cran_packages = c("utils")),
    "Installing CRAN packages"
  )
})

test_that("package installation respects repository settings", {
  # 测试仓库设置
  custom_repos <- c(CRAN = "https://cran.rstudio.com/")
  expect_message(
    install_if_missing(c("utils"), repos = custom_repos),
    "All packages are already installed"
  )
}) 