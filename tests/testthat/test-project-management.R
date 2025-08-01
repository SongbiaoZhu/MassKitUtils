# tests/testthat/test-project-management.R

test_that("create_analysis_directory 基本功能测试", {
  # 准备测试数据
  test_project_name <- "test_analysis"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 执行测试
  expect_message(create_analysis_directory(test_project_name, test_path), "created successfully at")
  
  # 验证项目目录结构
  expect_true(dir.exists(test_project_path))
  expect_true(dir.exists(file.path(test_project_path, "data")))
  expect_true(dir.exists(file.path(test_project_path, "data/raw")))
  expect_true(dir.exists(file.path(test_project_path, "data/processed")))
  expect_true(dir.exists(file.path(test_project_path, "data/external")))
  expect_true(dir.exists(file.path(test_project_path, "scripts")))
  expect_true(dir.exists(file.path(test_project_path, "output")))
  expect_true(dir.exists(file.path(test_project_path, "config")))
  expect_true(dir.exists(file.path(test_project_path, "docs")))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_analysis_directory 参数验证测试", {
  # 测试缺失参数
  expect_error(create_analysis_directory(), "Parameter 'project_name' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(create_analysis_directory(NULL), "Parameter 'project_name' is required and cannot be empty")
  
  # 测试空字符串
  expect_error(create_analysis_directory(""), "Parameter 'project_name' must be a non-empty character vector")
  
  # 测试非字符向量
  expect_error(create_analysis_directory(123), "Parameter 'project_name' must be a non-empty character vector")
  expect_error(create_analysis_directory(c("proj1", "proj2")), "Parameter 'project_name' must be a character vector of length 1")
})

test_that("create_analysis_directory 路径验证测试", {
  # 测试无效路径
  expect_error(create_analysis_directory("test", "/tmp/nonexistent_path_12345_xyz"), 
               "Specified path does not exist")
  
  # 测试NULL路径
  expect_error(create_analysis_directory("test", NULL), "Parameter 'path' must be a character vector")
  
  # 测试非字符路径
  expect_error(create_analysis_directory("test", 123), "Parameter 'path' must be a character vector")
})

test_that("create_analysis_directory 项目已存在测试", {
  # 准备测试数据
  test_project_name <- "existing_analysis"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 创建项目
  expect_message(create_analysis_directory(test_project_name, test_path), "created successfully at")
  
  # 测试重复创建
  expect_error(create_analysis_directory(test_project_name, test_path), 
               "Project directory already exists")
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_analysis_directory quiet参数测试", {
  # 准备测试数据
  test_project_name <- "quiet_test_analysis"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 测试quiet = FALSE (默认)
  expect_message(create_analysis_directory(test_project_name, test_path, quiet = FALSE), "created successfully at")
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
  
  # 测试quiet = TRUE
  expect_silent(create_analysis_directory(test_project_name, test_path, quiet = TRUE))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_analysis_directory 目录结构完整性测试", {
  # 准备测试数据
  test_project_name <- "structure_test_analysis"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 执行测试
  expect_message(create_analysis_directory(test_project_name, test_path), "created successfully at")
  
  # 验证所有必需的目录都存在
  expected_dirs <- c(
    "data/raw",
    "data/processed", 
    "data/external",
    "scripts",
    "output",
    "config",
    "docs"
  )
  
  for (dir in expected_dirs) {
    expect_true(dir.exists(file.path(test_project_path, dir)), 
                info = paste("Directory should exist:", dir))
  }
  
  # 验证没有创建不必要的文件
  expect_false(file.exists(file.path(test_project_path, "README.md")))
  expect_false(file.exists(file.path(test_project_path, ".gitignore")))
  expect_false(file.exists(file.path(test_project_path, ".Rprofile")))
  expect_false(file.exists(file.path(test_project_path, "DESCRIPTION")))
  expect_false(file.exists(file.path(test_project_path, "NAMESPACE")))
  expect_false(file.exists(file.path(test_project_path, "setup_environment.R")))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_analysis_directory 消息输出测试", {
  # 准备测试数据
  test_project_name <- "message_test_analysis"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 测试消息输出 - 只调用一次函数
  expect_message(create_analysis_directory(test_project_name, test_path), "created successfully at")
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
}) 