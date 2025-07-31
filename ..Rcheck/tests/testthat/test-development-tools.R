# Development Tools Tests
# tests/testthat/test-development-tools.R

test_that("generate_dev_standards 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(generate_dev_standards(test_dir))
  
  # 验证目录已创建
  expect_true(dir.exists(test_dir))
  
  # 验证必需文件已创建
  required_files <- c(
    "01_overview.md",
    "02_coding_standards.md", 
    "03_testing_standards.md",
    "04_documentation_standards.md",
    "05_git_workflow.md",
    "06_release_checklist.md"
  )
  
  for (file_name in required_files) {
    expect_true(file.exists(file.path(test_dir, file_name)), 
                info = paste("文件", file_name, "应该存在"))
  }
  
  # 验证templates目录已创建
  expect_true(dir.exists(file.path(test_dir, "templates")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("generate_dev_standards 参数验证测试", {
  # 测试缺失参数
  expect_error(generate_dev_standards(), "Parameter 'output_dir' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(generate_dev_standards(NULL), "Parameter 'output_dir' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(generate_dev_standards(123), "Parameter 'output_dir' must be a character vector")
  expect_error(generate_dev_standards(c("dir1", "dir2")), "Parameter 'output_dir' must be a character vector of length 1")
})

test_that("generate_dev_standards 包名参数测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_with_package")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  expect_silent(generate_dev_standards(test_dir, package_name = "TestPackage"))
  
  # 验证文件内容包含包名
  overview_content <- readLines(file.path(test_dir, "01_overview.md"))
  expect_true(any(grepl("TestPackage", overview_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("generate_dev_standards overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_overwrite")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 第一次生成
  generate_dev_standards(test_dir)
  
  # 第二次生成（不覆盖）
  expect_warning(generate_dev_standards(test_dir, overwrite = FALSE), 
                 "File already exists")
  
  # 第三次生成（覆盖）
  expect_silent(generate_dev_standards(test_dir, overwrite = TRUE))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("generate_dev_standards 模板文件测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_templates")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 执行测试
  generate_dev_standards(test_dir)
  
  # 验证模板文件已创建
  templates_dir <- file.path(test_dir, "templates")
  template_files <- c(
    "function_template.R",
    "test_template.R", 
    "commit_template.txt"
  )
  
  for (file_name in template_files) {
    expect_true(file.exists(file.path(templates_dir, file_name)), 
                info = paste("模板文件", file_name, "应该存在"))
  }
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_ignore_files 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("ignore_files")
  dir.create(test_dir)
  
  # 执行测试
  expect_silent(create_ignore_files(test_dir, quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(file.path(test_dir, ".gitignore")))
  expect_true(file.exists(file.path(test_dir, ".Rbuildignore")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_ignore_files 参数验证测试", {
  # 测试NULL参数
  expect_error(create_ignore_files(NULL), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试非字符向量
  expect_error(create_ignore_files(123), "Parameter 'project_path' must be a character vector of length 1")
  expect_error(create_ignore_files(c("dir1", "dir2")), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试不存在的目录
  expect_error(create_ignore_files("/this/path/definitely/does/not/exist/12345"), 
               "Project directory does not exist")
})

test_that("create_ignore_files 文件内容验证测试", {
  # 准备测试数据
  test_dir <- tempfile("ignore_files_content")
  dir.create(test_dir)
  
  # 执行测试
  create_ignore_files(test_dir, quiet = TRUE)
  
  # 验证.gitignore内容
  gitignore_content <- readLines(file.path(test_dir, ".gitignore"))
  expect_true(any(grepl("\\.RData", gitignore_content)))
  expect_true(any(grepl("\\.Rhistory", gitignore_content)))
  expect_true(any(grepl("\\.Ruserdata", gitignore_content)))
  
  # 验证.Rbuildignore内容
  rbuildignore_content <- readLines(file.path(test_dir, ".Rbuildignore"))
  expect_true(any(grepl("^LICENSE\\.md$", rbuildignore_content)))
  expect_true(any(grepl("^dev/", rbuildignore_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_ignore_files overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("ignore_files_overwrite")
  dir.create(test_dir)
  
  # 第一次创建
  create_ignore_files(test_dir, quiet = TRUE)
  
  # 第二次创建（不覆盖）
  expect_message(create_ignore_files(test_dir, overwrite = FALSE), 
                 "already exists")
  
  # 第三次创建（覆盖）
  expect_message(create_ignore_files(test_dir, overwrite = TRUE), 
                 "Created")
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_ignore_files 默认路径测试", {
  # 准备测试数据
  test_dir <- tempfile("ignore_files_default")
  dir.create(test_dir)
  
  # 保存当前工作目录
  original_wd <- getwd()
  
  # 切换到测试目录
  setwd(test_dir)
  
  # 执行测试（使用默认路径）
  expect_silent(create_ignore_files(quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(".gitignore"))
  expect_true(file.exists(".Rbuildignore"))
  
  # 恢复工作目录
  setwd(original_wd)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("write_if_not_exists 基本功能测试", {
  # 准备测试数据
  test_file <- tempfile("write_test")
  
  # 确保文件不存在
  if (file.exists(test_file)) {
    unlink(test_file)
  }
  
  # 执行测试
  expect_silent(write_if_not_exists(test_file, "test content"))
  
  # 验证文件已创建
  expect_true(file.exists(test_file))
  
  # 验证内容
  content <- readLines(test_file)
  expect_equal(content, "test content")
  
  # 清理
  unlink(test_file)
})

test_that("write_if_not_exists overwrite参数测试", {
  # 准备测试数据
  test_file <- tempfile("write_overwrite")
  
  # 确保文件不存在
  if (file.exists(test_file)) {
    unlink(test_file)
  }
  
  # 第一次写入
  write_if_not_exists(test_file, "original content")
  
  # 第二次写入（不覆盖）
  expect_warning(write_if_not_exists(test_file, "new content", overwrite = FALSE), 
                 "File already exists")
  
  # 验证内容未改变
  content <- readLines(test_file)
  expect_equal(content, "original content")
  
  # 第三次写入（覆盖）
  expect_silent(write_if_not_exists(test_file, "new content", overwrite = TRUE))
  
  # 验证内容已改变
  content <- readLines(test_file)
  expect_equal(content, "new content")
  
  # 清理
  unlink(test_file)
}) 