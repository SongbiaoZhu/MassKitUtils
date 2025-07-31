# File Management Tests
# tests/testthat/test-file-management.R

test_that("ensure_directory 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("test_dir")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(ensure_directory(test_dir))
  
  # 验证目录已创建
  expect_true(dir.exists(test_dir))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 已存在目录测试", {
  # 准备测试数据
  test_dir <- tempfile("existing_dir")
  
  # 创建目录
  dir.create(test_dir, recursive = TRUE)
  
  # 测试已存在的目录
  expect_silent(ensure_directory(test_dir))
  
  # 验证目录仍然存在
  expect_true(dir.exists(test_dir))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 嵌套目录测试", {
  # 准备测试数据
  test_dir <- tempfile("nested_dir")
  nested_path <- file.path(test_dir, "level1", "level2", "level3")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(ensure_directory(nested_path))
  
  # 验证所有层级目录都已创建
  expect_true(dir.exists(test_dir))
  expect_true(dir.exists(file.path(test_dir, "level1")))
  expect_true(dir.exists(file.path(test_dir, "level1", "level2")))
  expect_true(dir.exists(nested_path))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 参数验证测试", {
  # 测试缺失参数
  expect_error(ensure_directory(), "Parameter 'directory_path' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(ensure_directory(NULL), "Parameter 'directory_path' is required and cannot be empty")
  
  # 测试空字符串
  expect_error(ensure_directory(""), "Parameter 'directory_path' must be a non-empty character vector")
  
  # 测试非字符向量
  expect_error(ensure_directory(123), "Parameter 'directory_path' must be a non-empty character vector")
  expect_error(ensure_directory(c("dir1", "dir2")), "Parameter 'directory_path' must be a character vector of length 1")
})

test_that("ensure_directory 权限测试", {
  # 测试无效路径（需要管理员权限的路径）
  # 在Windows上测试系统目录
  if (.Platform$OS.type == "windows") {
    system_dir <- "C:\\Windows\\System32\\test_dir"
    expect_error(ensure_directory(system_dir), "Failed to create directory")
  } else {
    # 在Unix系统上测试根目录
    root_dir <- "/root/test_dir"
    expect_error(ensure_directory(root_dir), "Failed to create directory")
  }
})

test_that("ensure_directory 特殊字符测试", {
  # 准备测试数据
  test_dir <- tempfile("special_chars")
  special_path <- file.path(test_dir, "test-dir_with spaces", "sub_dir")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(ensure_directory(special_path))
  
  # 验证目录已创建
  expect_true(dir.exists(special_path))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 相对路径测试", {
  # 准备测试数据
  test_dir <- "test_relative_dir"
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(ensure_directory(test_dir))
  
  # 验证目录已创建
  expect_true(dir.exists(test_dir))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 多次调用测试", {
  # 准备测试数据
  test_dir <- tempfile("multiple_calls")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 多次调用
  expect_silent(ensure_directory(test_dir))
  expect_silent(ensure_directory(test_dir))
  expect_silent(ensure_directory(test_dir))
  
  # 验证目录存在且只有一个
  expect_true(dir.exists(test_dir))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("ensure_directory 文件冲突测试", {
  # 准备测试数据
  test_file <- tempfile("file_conflict")
  
  # 创建文件
  writeLines("test content", test_file)
  
  # 尝试将文件路径作为目录创建
  expect_error(ensure_directory(test_file), "Path exists and is not a directory")
  
  # 清理
  unlink(test_file)
}) 