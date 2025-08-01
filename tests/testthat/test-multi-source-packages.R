# 多源包安装测试
# tests/testthat/test-multi-source-packages.R

test_that("ensure_packages handles CRAN packages correctly", {
  # 测试CRAN包安装
  expect_message(
    ensure_packages(c("utils", "stats")), 
    "All packages are already installed"
  )
  
  # 测试错误处理
  expect_error(ensure_packages(NULL))
  expect_error(ensure_packages(character(0)))
})

test_that("ensure_packages handles Bioconductor packages correctly", {
  # 测试Bioconductor包安装（这些包通常已安装）
  expect_message(
    ensure_packages(c("BiocManager")), 
    "All packages are already installed"
  )
})



test_that("install_from_multiple_sources handles mixed installation correctly", {
  # 测试混合安装
  expect_message(
    install_from_multiple_sources(
      cran_packages = c("utils", "stats"),
      bioc_packages = c("BiocManager")
    ),
    "Multi-source installation completed"
  )
})

test_that("install_from_multiple_sources validates parameters correctly", {
  # 测试参数验证
  expect_error(install_from_multiple_sources())
  expect_error(install_from_multiple_sources(cran_packages = NULL, bioc_packages = NULL))
})

test_that("package installation handles dependencies correctly", {
  # 测试依赖处理
  expect_message(
    ensure_packages(c("utils"), dependencies = TRUE),
    "All packages are already installed"
  )
})

test_that("package installation handles quiet mode correctly", {
  # 测试静默模式
  expect_silent(
    ensure_packages(c("utils"), quiet = TRUE)
  )
})



test_that("Bioconductor installation handles BiocManager correctly", {
  # 测试BiocManager处理
  if (requireNamespace("BiocManager", quietly = TRUE)) {
    expect_message(
      ensure_packages(c("BiocManager")),
      "All packages are already installed"
    )
  }
})



test_that("multi-source installation provides clear progress messages", {
  # 测试进度消息
  expect_message(
    install_from_multiple_sources(cran_packages = c("utils")),
    "Installing CRAN packages"
  )
})

test_that("package installation respects repository settings", {
  # 测试仓库设置
  custom_repos <- c(CRAN = "https://cran.rstudio.com/")
  expect_message(
    ensure_packages(c("utils"), repos = custom_repos),
    "All packages are already installed"
  )
}) 