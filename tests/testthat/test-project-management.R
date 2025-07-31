# Project Management Tests
# tests/testthat/test-project-management.R

test_that("create_r_project 基本功能测试", {
  # 准备测试数据
  test_project_name <- "test_project"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 执行测试
  expect_message(create_r_project(test_project_name, test_path), "created successfully at")
  
  # 验证项目目录结构
  expect_true(dir.exists(test_project_path))
  expect_true(file.exists(file.path(test_project_path, "README.md")))
  expect_true(file.exists(file.path(test_project_path, ".gitignore")))
  expect_true(dir.exists(file.path(test_project_path, "R")))
  expect_true(dir.exists(file.path(test_project_path, "data")))
  expect_true(dir.exists(file.path(test_project_path, "docs")))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_r_project 参数验证测试", {
  # 测试缺失参数
  expect_error(create_r_project(), "Parameter 'project_name' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(create_r_project(NULL), "Parameter 'project_name' is required and cannot be empty")
  
  # 测试空字符串
  expect_error(create_r_project(""), "Parameter 'project_name' must be a non-empty character vector")
  
  # 测试非字符向量
  expect_error(create_r_project(123), "Parameter 'project_name' must be a non-empty character vector")
  expect_error(create_r_project(c("proj1", "proj2")), "Parameter 'project_name' must be a character vector of length 1")
})

test_that("create_r_project 路径验证测试", {
  # 测试无效路径
  expect_error(create_r_project("test", "/invalid/path/that/does/not/exist"), 
               "Specified path does not exist")
  
  # 测试NULL路径
  expect_error(create_r_project("test", NULL), "Parameter 'path' must be a character vector")
  
  # 测试非字符路径
  expect_error(create_r_project("test", 123), "Parameter 'path' must be a character vector")
})

test_that("create_r_project 项目已存在测试", {
  # 准备测试数据
  test_project_name <- "existing_project"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 创建项目
  expect_message(create_r_project(test_project_name, test_path), "created successfully at")
  
  # 测试重复创建
  expect_error(create_r_project(test_project_name, test_path), 
               "Project directory already exists")
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_r_project setup_env参数测试", {
  # 准备测试数据
  test_project_name <- "env_test_project"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 测试setup_env = TRUE
  expect_message(create_r_project(test_project_name, test_path, setup_env = TRUE), "created successfully at")
  expect_true(file.exists(file.path(test_project_path, ".Rprofile")))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
  
  # 测试setup_env = FALSE
  expect_message(create_r_project(test_project_name, test_path, setup_env = FALSE), "created successfully at")
  expect_false(file.exists(file.path(test_project_path, ".Rprofile")))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_r_project 目录结构完整性测试", {
  # 准备测试数据
  test_project_name <- "structure_test_project"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 创建项目
  expect_message(create_r_project(test_project_name, test_path), "created successfully at")
  
  # 验证所有必需的目录都存在
  required_dirs <- c("R", "data", "docs", "tests", "vignettes", "inst")
  for (dir_name in required_dirs) {
    expect_true(dir.exists(file.path(test_project_path, dir_name)), 
                info = paste("目录", dir_name, "应该存在"))
  }
  
  # 验证所有必需的文件都存在
  required_files <- c("README.md", ".gitignore", "DESCRIPTION", "NAMESPACE")
  for (file_name in required_files) {
    expect_true(file.exists(file.path(test_project_path, file_name)), 
                info = paste("文件", file_name, "应该存在"))
  }
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
})

test_that("create_r_project 文件内容验证测试", {
  # 准备测试数据
  test_project_name <- "content_test_project"
  test_path <- tempdir()
  test_project_path <- file.path(test_path, test_project_name)
  
  # 确保测试目录不存在
  if (dir.exists(test_project_path)) {
    unlink(test_project_path, recursive = TRUE)
  }
  
  # 创建项目
  expect_message(create_r_project(test_project_name, test_path), "created successfully at")
  
  # 验证README.md内容
  readme_content <- readLines(file.path(test_project_path, "README.md"))
  expect_true(any(grepl(test_project_name, readme_content)))
  
  # 验证DESCRIPTION内容
  desc_content <- readLines(file.path(test_project_path, "DESCRIPTION"))
  expect_true(any(grepl(test_project_name, desc_content)))
  
  # 验证.gitignore内容
  gitignore_content <- readLines(file.path(test_project_path, ".gitignore"))
  expect_true(any(grepl("\\.RData", gitignore_content)))
  expect_true(any(grepl("\\.Rhistory", gitignore_content)))
  
  # 清理
  unlink(test_project_path, recursive = TRUE)
}) 