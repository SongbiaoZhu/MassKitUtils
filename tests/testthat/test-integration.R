# Integration Tests
# tests/testthat/test-integration.R

test_that("完整工作流程测试", {
  # 准备测试数据
  test_dir <- tempfile("integration_test")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 步骤1: 设置分析目录结构
  expect_silent(setup_analysis_structure(quiet = TRUE))
  expect_true(dir.exists("data/raw"))
  expect_true(dir.exists("scripts"))
  expect_true(dir.exists("output"))
  
  # 步骤2: 确保输出目录存在
  output_dir <- "output"
  expect_silent(ensure_directory(output_dir))
  expect_true(dir.exists(output_dir))
  
  # 步骤3: 安装和加载必要的包
  test_packages <- c("dplyr", "readr")
  expect_silent(ensure_packages(test_packages, quiet = TRUE))
  load_status <- load_packages(test_packages, quiet = TRUE)
  expect_true(all(load_status))
  
  # 步骤4: 创建示例数据并导出
  sample_data <- data.frame(
    ID = 1:5,
    Name = paste("Test", 1:5),
    Value = rnorm(5),
    stringsAsFactors = FALSE
  )
  
  excel_file <- file.path(output_dir, "sample_data.xlsx")
  expect_silent(export_to_excel(sample_data, excel_file, quiet = TRUE))
  expect_true(file.exists(excel_file))
  
  # 步骤5: 创建开发标准文档
  dev_dir <- "dev"
  expect_silent(create_dev_standards(dev_dir, package_name = "integration_test"))
  expect_true(dir.exists(dev_dir))
  
  # 步骤6: 检查包版本
  version_info <- check_package_versions(test_packages)
  expect_true(is.data.frame(version_info))
  expect_equal(nrow(version_info), length(test_packages))
})

test_that("数据导出工作流程测试", {
  # 准备测试数据
  test_dir <- tempfile("export_workflow")
  dir.create(test_dir)
  
  # 创建多种类型的数据
  numeric_data <- data.frame(
    x = 1:10,
    y = rnorm(10),
    z = runif(10),
    stringsAsFactors = FALSE
  )
  
  mixed_data <- data.frame(
    ID = 1:5,
    Name = letters[1:5],
    Age = sample(20:65, 5),
    Salary = round(rnorm(5, 50000, 10000), 2),
    stringsAsFactors = FALSE
  )
  
  # 测试不同样式的导出
  styles <- list(
    basic = list(header_style = "default", table_style = "default"),
    colored = list(header_style = "colored", table_style = "striped"),
    minimal = list(header_style = "minimal", table_style = "minimal")
  )
  
  for (style_name in names(styles)) {
    style <- styles[[style_name]]
    file_name <- file.path(test_dir, paste0("data_", style_name, ".xlsx"))
    
    expect_silent(export_to_excel(numeric_data, file_name, 
                                 header_style = style$header_style,
                                 table_style = style$table_style,
                                 quiet = TRUE))
    expect_true(file.exists(file_name))
  }
  
  # 测试带摘要的导出
  summary_file <- file.path(test_dir, "data_with_summary.xlsx")
  expect_silent(export_to_excel(mixed_data, summary_file, add_summary = TRUE, quiet = TRUE))
  expect_true(file.exists(summary_file))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("包管理集成测试", {
  # 测试包管理功能的组合使用
  
  # 步骤1: 检查已安装的包
  test_packages <- c("testthat", "devtools")
  version_info <- check_package_versions(test_packages)
  expect_true(is.data.frame(version_info))
  
  # 步骤2: 确保包已安装
  expect_silent(ensure_packages(test_packages, quiet = TRUE))
  
  # 步骤3: 加载包
  load_status <- load_packages(test_packages, quiet = TRUE)
  expect_true(all(load_status))
  
  # 步骤4: 再次检查版本
  version_info_after <- check_package_versions(test_packages)
  expect_equal(nrow(version_info_after), length(test_packages))
  expect_true(all(version_info_after$Status == "Installed"))
})

test_that("文件操作集成测试", {
  # 准备测试数据
  test_dir <- tempfile("file_operations")
  
  # 确保测试目录不存在
  if (dir.exists(test_dir)) {
    unlink(test_dir, recursive = TRUE)
  }
  
  # 步骤1: 创建主目录
  expect_silent(ensure_directory(test_dir))
  expect_true(dir.exists(test_dir))
  
  # 步骤2: 创建嵌套目录结构
  nested_dirs <- c(
    file.path(test_dir, "data", "raw"),
    file.path(test_dir, "data", "processed"),
    file.path(test_dir, "output", "figures"),
    file.path(test_dir, "output", "tables"),
    file.path(test_dir, "docs", "reports")
  )
  
  for (dir_path in nested_dirs) {
    expect_silent(ensure_directory(dir_path))
    expect_true(dir.exists(dir_path))
  }
  
  # 步骤3: 创建ignore文件
  expect_silent(create_gitignore(test_dir, quiet = TRUE))
expect_silent(create_rbuildignore(test_dir, quiet = TRUE))
  expect_true(file.exists(file.path(test_dir, ".gitignore")))
  expect_true(file.exists(file.path(test_dir, ".Rbuildignore")))
  
  # 步骤4: 创建开发标准文档
  dev_dir <- file.path(test_dir, "dev")
  expect_silent(create_dev_standards(dev_dir))
  expect_true(dir.exists(dev_dir))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("错误处理集成测试", {
  # 测试各种错误情况的组合
  
  # 测试无效的项目创建（使用新函数）
  test_dir <- tempfile("error_test")
  dir.create(test_dir)
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 测试在不可写目录中的错误
  if (.Platform$OS.type != "windows") {
    Sys.chmod(".", "0444")
    expect_error(setup_analysis_structure(), "Current directory is not writable")
    Sys.chmod(".", "0755")
  }
  
  # 测试无效的目录创建
  if (.Platform$OS.type == "windows") {
    expect_error(ensure_directory("C:\\Windows\\System32\\test"), "Failed to create directory")
  } else {
    expect_error(ensure_directory("/root/test"), "Failed to create directory")
  }
  
  # 测试无效的包管理
  expect_error(ensure_packages(), "Parameter 'packages' is required and cannot be empty")
  expect_error(load_packages(), "Parameter 'packages' is required and cannot be empty")
  expect_error(check_package_versions(), "Parameter 'packages' is required and cannot be empty")
  
  # 测试无效的数据导出
  expect_error(export_to_excel(), "Parameter 'data' is required and cannot be empty")
  expect_error(export_to_excel(mtcars), "Parameter 'filename' is required and cannot be empty")
  
  # 测试无效的开发工具
  expect_error(create_dev_standards(NULL), "Parameter 'output_dir' is required and cannot be empty")
  expect_error(create_gitignore("/tmp/nonexistent_path_12345_xyz"), "Project directory does not exist")
})

test_that("性能测试", {
  # 测试大数据集的处理性能
  
  # 创建较大的数据集
  large_data <- data.frame(
    ID = 1:1000,
    Value1 = rnorm(1000),
    Value2 = runif(1000),
    Category = sample(letters[1:5], 1000, replace = TRUE),
    stringsAsFactors = FALSE
  )
  
  # 测试目录创建性能
  test_dir <- tempfile("performance_test")
  start_time <- Sys.time()
  ensure_directory(test_dir)
  end_time <- Sys.time()
  expect_true(as.numeric(difftime(end_time, start_time, units = "secs")) < 1)
  
  # 测试数据导出性能
  excel_file <- file.path(test_dir, "large_data.xlsx")
  start_time <- Sys.time()
  export_to_excel(large_data, excel_file, quiet = TRUE)
  end_time <- Sys.time()
  expect_true(as.numeric(difftime(end_time, start_time, units = "secs")) < 10)
  expect_true(file.exists(excel_file))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("内存管理测试", {
  # 测试内存使用情况
  
  # 创建多个大型对象
  large_objects <- list()
  for (i in 1:5) {
    large_objects[[i]] <- data.frame(
      ID = 1:500,
      Value = rnorm(500),
      stringsAsFactors = FALSE
    )
  }
  
  # 测试包管理功能的内存使用
  test_packages <- c("testthat", "devtools")
  expect_silent(ensure_packages(test_packages, quiet = TRUE))
  expect_silent(load_packages(test_packages, quiet = TRUE))
  expect_silent(check_package_versions(test_packages))
  
  # 清理大型对象
  rm(large_objects)
  gc()
})

test_that("并发操作测试", {
  # 测试多个操作的并发执行
  
  # 准备测试数据
  test_dirs <- paste0(tempfile("concurrent_"), 1:3)
  
  # 并发创建目录
  for (dir_path in test_dirs) {
    expect_silent(ensure_directory(dir_path))
    expect_true(dir.exists(dir_path))
  }
  
  # 并发设置分析结构
  for (i in seq_along(test_dirs[1:2])) {
    old_wd <- getwd()
    setwd(test_dirs[i])
    expect_silent(setup_analysis_structure(quiet = TRUE))
    expect_true(dir.exists("data/raw"))
    expect_true(dir.exists("scripts"))
    setwd(old_wd)
  }
  
  # 清理
  for (dir_path in test_dirs) {
    unlink(dir_path, recursive = TRUE)
  }
}) 