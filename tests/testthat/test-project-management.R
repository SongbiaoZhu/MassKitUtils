# tests/testthat/test-project-management.R

# 新增的 setup_analysis_structure 测试
test_that("setup_analysis_structure 基本功能测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_analysis_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 执行测试
  expect_message(setup_analysis_structure(), "Standard analysis directory structure created in")
  
  # 验证目录结构
  expected_subdirs <- c(
    "data/raw",
    "data/processed", 
    "data/external",
    "scripts",
    "output",
    "config",
    "docs"
  )
  
  for (subdir in expected_subdirs) {
    expect_true(dir.exists(subdir), 
                info = paste("Subdirectory", subdir, "should exist"))
  }
})

test_that("setup_analysis_structure 参数验证测试", {
  # 测试quiet参数
  expect_error(setup_analysis_structure(quiet = "invalid"), 
               "Parameter 'quiet' must be a logical vector of length 1")
  
  expect_error(setup_analysis_structure(quiet = c(TRUE, FALSE)), 
               "Parameter 'quiet' must be a logical vector of length 1")
  
  # 测试overwrite参数
  expect_error(setup_analysis_structure(overwrite = "invalid"), 
               "Parameter 'overwrite' must be a logical vector of length 1")
  
  expect_error(setup_analysis_structure(overwrite = c(TRUE, FALSE)), 
               "Parameter 'overwrite' must be a logical vector of length 1")
})

test_that("setup_analysis_structure 已存在目录测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_analysis_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 创建一些已存在的目录
  dir.create("data/raw", recursive = TRUE)
  dir.create("scripts", recursive = TRUE)
  
  # 测试不覆盖已存在的目录
  expect_error(setup_analysis_structure(overwrite = FALSE), 
               "The following directories already exist")
  
  # 测试覆盖已存在的目录
  expect_message(setup_analysis_structure(overwrite = TRUE), 
                 "Standard analysis directory structure created in")
  
  # 验证所有目录都存在
  expected_subdirs <- c(
    "data/raw",
    "data/processed", 
    "data/external",
    "scripts",
    "output",
    "config",
    "docs"
  )
  
  for (subdir in expected_subdirs) {
    expect_true(dir.exists(subdir), 
                info = paste("Subdirectory", subdir, "should exist"))
  }
})

test_that("setup_analysis_structure quiet参数测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_analysis_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 测试quiet = FALSE (默认)
  expect_message(setup_analysis_structure(quiet = FALSE), "Standard analysis directory structure created in")
  
  # 清理
  unlink(c("data", "scripts", "output", "config", "docs"), recursive = TRUE)
  
  # 测试quiet = TRUE
  expect_silent(setup_analysis_structure(quiet = TRUE))
})

test_that("setup_analysis_structure 目录权限测试", {
  # 测试在只读目录中的行为
  # 注意：这个测试可能在某些系统上失败，取决于权限设置
  skip_on_os("windows") # 在Windows上跳过，因为权限处理不同
  
  # 创建一个只读目录
  test_dir <- tempfile("test_analysis_")
  dir.create(test_dir, mode = "0444")
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    Sys.chmod(test_dir, "0755")
    unlink(test_dir, recursive = TRUE)
  })
  
  # 测试在不可写目录中的错误
  expect_error(setup_analysis_structure(), "Current directory is not writable")
}) 