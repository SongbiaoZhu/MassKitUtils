# Development Tools Tests
# tests/testthat/test-development-tools.R

test_that("create_dev_standards 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards")
  dir.create(test_dir)
  
  # 执行测试
  expect_silent(create_dev_standards(test_dir))
  
  # 验证文件已创建（函数直接在提供的目录中创建文件）
  expect_true(file.exists(file.path(test_dir, "01_overview.md")))
  expect_true(file.exists(file.path(test_dir, "06_release_checklist.md")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_dev_standards 参数验证测试", {
  # 测试NULL参数
  expect_error(create_dev_standards(NULL), "Parameter 'output_dir' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(create_dev_standards(123), "Parameter 'output_dir' must be a character vector of length 1")
  expect_error(create_dev_standards(c("dir1", "dir2")), "Parameter 'output_dir' must be a character vector of length 1")
  
  # 测试不存在的目录（ensure_directory会创建目录，所以不会抛出错误）
  # 只有在权限不足等情况下才会失败
  # expect_error(create_dev_standards("/this/path/definitely/does/not/exist/12345"), 
  #              "Output directory does not exist")
})

test_that("create_dev_standards 文件内容验证测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_content")
  dir.create(test_dir)
  
  # 执行测试
  create_dev_standards(test_dir)
  
  # 验证overview文件内容
  overview_content <- readLines(file.path(test_dir, "01_overview.md"))
  expect_true(any(grepl("开发的标准", overview_content)))
  
  # 验证checklist文件内容
  checklist_content <- readLines(file.path(test_dir, "06_release_checklist.md"))
  expect_true(any(grepl("发布检查清单", checklist_content)))
  expect_true(any(grepl("检查清单", checklist_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_dev_standards overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_overwrite")
  dir.create(test_dir)
  
  # 第一次创建
  create_dev_standards(test_dir)
  
  # 第二次创建（不覆盖）- 会产生警告
  expect_warning(create_dev_standards(test_dir, overwrite = FALSE))
  
  # 第三次创建（覆盖）- 静默执行
  expect_silent(create_dev_standards(test_dir, overwrite = TRUE))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_dev_standards 默认路径测试", {
  # 准备测试数据
  test_dir <- tempfile("dev_standards_default")
  dir.create(test_dir)
  
  # 保存当前工作目录
  original_wd <- getwd()
  
  # 切换到测试目录
  setwd(test_dir)
  
  # 执行测试（使用默认路径）
  expect_silent(create_dev_standards("./dev/design"))
  
  # 验证目录已创建
  expect_true(dir.exists("dev/design"))
  # 注意：checklists目录可能不存在，因为函数只创建design目录
  
  # 恢复工作目录
  setwd(original_wd)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

# create_gitignore 测试
test_that("create_gitignore 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("gitignore")
  dir.create(test_dir)
  
  # 执行测试
  expect_silent(create_gitignore(test_dir, quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(file.path(test_dir, ".gitignore")))
  expect_false(file.exists(file.path(test_dir, ".Rbuildignore")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_gitignore 参数验证测试", {
  # 测试NULL参数
  expect_error(create_gitignore(NULL), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试非字符向量
  expect_error(create_gitignore(123), "Parameter 'project_path' must be a character vector of length 1")
  expect_error(create_gitignore(c("dir1", "dir2")), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试不存在的目录
  expect_error(create_gitignore("/tmp/nonexistent_path_12345_xyz"), 
               "Project directory does not exist")
})

test_that("create_gitignore 文件内容验证测试", {
  # 准备测试数据
  test_dir <- tempfile("gitignore_content")
  dir.create(test_dir)
  
  # 执行测试
  create_gitignore(test_dir, quiet = TRUE)
  
  # 验证.gitignore内容
  gitignore_content <- readLines(file.path(test_dir, ".gitignore"))
  expect_true(any(grepl("\\.RData", gitignore_content)))
  expect_true(any(grepl("\\.Rhistory", gitignore_content)))
  expect_true(any(grepl("\\.Ruserdata", gitignore_content)))
  expect_true(any(grepl("\\.DS_Store", gitignore_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_gitignore overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("gitignore_overwrite")
  dir.create(test_dir)
  
  # 第一次创建
  create_gitignore(test_dir, quiet = TRUE)
  
  # 第二次创建（不覆盖）
  expect_message(create_gitignore(test_dir, overwrite = FALSE), 
                 "already exists")
  
  # 第三次创建（覆盖）
  expect_message(create_gitignore(test_dir, overwrite = TRUE), 
                 "Created")
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_gitignore 默认路径测试", {
  # 准备测试数据
  test_dir <- tempfile("gitignore_default")
  dir.create(test_dir)
  
  # 保存当前工作目录
  original_wd <- getwd()
  
  # 切换到测试目录
  setwd(test_dir)
  
  # 执行测试（使用默认路径）
  expect_silent(create_gitignore(quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(".gitignore"))
  
  # 恢复工作目录
  setwd(original_wd)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

# create_rbuildignore 测试
test_that("create_rbuildignore 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("rbuildignore")
  dir.create(test_dir)
  
  # 执行测试
  expect_silent(create_rbuildignore(test_dir, quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(file.path(test_dir, ".Rbuildignore")))
  expect_false(file.exists(file.path(test_dir, ".gitignore")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_rbuildignore 参数验证测试", {
  # 测试NULL参数
  expect_error(create_rbuildignore(NULL), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试非字符向量
  expect_error(create_rbuildignore(123), "Parameter 'project_path' must be a character vector of length 1")
  expect_error(create_rbuildignore(c("dir1", "dir2")), "Parameter 'project_path' must be a character vector of length 1")
  
  # 测试不存在的目录
  expect_error(create_rbuildignore("/tmp/nonexistent_path_12345_xyz"), 
               "Project directory does not exist")
})

test_that("create_rbuildignore 文件内容验证测试", {
  # 准备测试数据
  test_dir <- tempfile("rbuildignore_content")
  dir.create(test_dir)
  
  # 执行测试
  create_rbuildignore(test_dir, quiet = TRUE)
  
  # 验证.Rbuildignore内容
  rbuildignore_content <- readLines(file.path(test_dir, ".Rbuildignore"))
  expect_true(any(grepl("^LICENSE\\.md$", rbuildignore_content)))
  expect_true(any(grepl("^dev/", rbuildignore_content)))
  expect_true(any(grepl("^examples/", rbuildignore_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_rbuildignore overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("rbuildignore_overwrite")
  dir.create(test_dir)
  
  # 第一次创建
  create_rbuildignore(test_dir, quiet = TRUE)
  
  # 第二次创建（不覆盖）
  expect_message(create_rbuildignore(test_dir, overwrite = FALSE), 
                 "already exists")
  
  # 第三次创建（覆盖）
  expect_message(create_rbuildignore(test_dir, overwrite = TRUE), 
                 "Created")
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_rbuildignore 默认路径测试", {
  # 准备测试数据
  test_dir <- tempfile("rbuildignore_default")
  dir.create(test_dir)
  
  # 保存当前工作目录
  original_wd <- getwd()
  
  # 切换到测试目录
  setwd(test_dir)
  
  # 执行测试（使用默认路径）
  expect_silent(create_rbuildignore(quiet = TRUE))
  
  # 验证文件已创建
  expect_true(file.exists(".Rbuildignore"))
  
  # 恢复工作目录
  setwd(original_wd)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

# write_if_not_exists 测试
test_that("write_if_not_exists 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("write_test")
  dir.create(test_dir)
  test_file <- file.path(test_dir, "test.txt")
  test_content <- c("line1", "line2", "line3")
  
  # 执行测试
  expect_silent(write_if_not_exists(test_file, test_content))
  
  # 验证文件已创建
  expect_true(file.exists(test_file))
  
  # 验证内容
  file_content <- readLines(test_file)
  expect_equal(file_content, test_content)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("write_if_not_exists overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("write_overwrite")
  dir.create(test_dir)
  test_file <- file.path(test_dir, "test.txt")
  content1 <- c("original content")
  content2 <- c("new content")
  
  # 第一次写入
  write_if_not_exists(test_file, content1)
  
  # 第二次写入（不覆盖）
  expect_warning(write_if_not_exists(test_file, content2, overwrite = FALSE))
  
  # 验证内容未改变
  file_content <- readLines(test_file)
  expect_equal(file_content, content1)
  
  # 第三次写入（覆盖）
  expect_silent(write_if_not_exists(test_file, content2, overwrite = TRUE))
  
  # 验证内容已改变
  file_content <- readLines(test_file)
  expect_equal(file_content, content2)
  
  # 清理
  unlink(test_dir, recursive = TRUE)
}) 

# create_project_standards 测试
test_that("create_project_standards 基本功能测试", {
  # 准备测试数据
  test_dir <- tempfile("project_standards")
  dir.create(test_dir)
  
  # 执行测试
  expect_silent(create_project_standards(test_dir))
  
  # 验证文件已创建
  expect_true(file.exists(file.path(test_dir, "01_overview.md")))
  expect_true(file.exists(file.path(test_dir, "02_data_workflow.md")))
  expect_true(file.exists(file.path(test_dir, "03_analysis_standards.md")))
  expect_true(file.exists(file.path(test_dir, "04_reproducibility.md")))
  expect_true(dir.exists(file.path(test_dir, "templates")))
  
  # 验证模板文件
  expect_true(file.exists(file.path(test_dir, "templates", "data_dictionary_template.md")))
  expect_true(file.exists(file.path(test_dir, "templates", "analysis_report_template.md")))
  expect_true(file.exists(file.path(test_dir, "templates", "script_template.R")))
  expect_true(file.exists(file.path(test_dir, "templates", "config_template.R")))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_project_standards 参数验证测试", {
  # 测试NULL参数
  expect_error(create_project_standards(NULL), "Parameter 'output_dir' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(create_project_standards(123), "Parameter 'output_dir' must be a character vector of length 1")
  expect_error(create_project_standards(c("dir1", "dir2")), "Parameter 'output_dir' must be a character vector of length 1")
})

test_that("create_project_standards 文件内容验证测试", {
  # 准备测试数据
  test_dir <- tempfile("project_standards_content")
  dir.create(test_dir)
  
  # 执行测试
  create_project_standards(test_dir)
  
  # 验证overview文件内容
  overview_content <- readLines(file.path(test_dir, "01_overview.md"))
  expect_true(any(grepl("数据分析项目", overview_content)))
  
  # 验证data_workflow文件内容
  workflow_content <- readLines(file.path(test_dir, "02_data_workflow.md"))
  expect_true(any(grepl("数据工作流程", workflow_content)))
  
  # 验证analysis_standards文件内容
  analysis_content <- readLines(file.path(test_dir, "03_analysis_standards.md"))
  expect_true(any(grepl("分析标准", analysis_content)))
  
  # 验证reproducibility文件内容
  repro_content <- readLines(file.path(test_dir, "04_reproducibility.md"))
  expect_true(any(grepl("可重现性", repro_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_project_standards overwrite参数测试", {
  # 准备测试数据
  test_dir <- tempfile("project_standards_overwrite")
  dir.create(test_dir)
  
  # 第一次创建
  create_project_standards(test_dir)
  
  # 第二次创建（不覆盖）- 会产生警告
  expect_warning(create_project_standards(test_dir, overwrite = FALSE))
  
  # 第三次创建（覆盖）- 静默执行
  expect_silent(create_project_standards(test_dir, overwrite = TRUE))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("create_project_standards 项目名称参数测试", {
  # 准备测试数据
  test_dir <- tempfile("project_standards_name")
  dir.create(test_dir)
  
  # 执行测试
  create_project_standards(test_dir, project_name = "TestProject")
  
  # 验证文件内容包含项目名称
  overview_content <- readLines(file.path(test_dir, "01_overview.md"))
  expect_true(any(grepl("TestProject", overview_content)))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
}) 