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

# init_r_project 函数测试
test_that("init_r_project 基本功能测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_init_project_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 执行测试
  result <- init_r_project(quiet = TRUE, show_instructions = FALSE)
  
  # 验证返回值
  expect_true(is.list(result))
  expect_true(result$success)
  expect_equal(normalizePath(result$project_path), normalizePath(test_dir))
  expect_equal(result$project_name, basename(test_dir))
  
  # 验证创建的项目结构
  expect_true(file.exists(paste0(basename(test_dir), ".Rproj")))
  expect_true(dir.exists("data/raw"))
  expect_true(dir.exists("scripts"))
  expect_true(dir.exists("output"))
  expect_true(dir.exists("dev/design"))
  expect_true(file.exists(".gitignore"))
})

test_that("init_r_project 参数验证测试", {
  # 测试各种参数验证
  expect_error(init_r_project(rstudio = "invalid"), 
               "Parameter 'rstudio' must be a logical vector of length 1")
  
  expect_error(init_r_project(git = c(TRUE, FALSE)), 
               "Parameter 'git' must be a logical vector of length 1")
  
  expect_error(init_r_project(create_dirs = "invalid"), 
               "Parameter 'create_dirs' must be a logical vector of length 1")
  
  expect_error(init_r_project(create_standards = c(TRUE, FALSE)), 
               "Parameter 'create_standards' must be a logical vector of length 1")
  
  expect_error(init_r_project(create_gitignore = "invalid"), 
               "Parameter 'create_gitignore' must be a logical vector of length 1")
  
  expect_error(init_r_project(standards_dir = c("dir1", "dir2")), 
               "Parameter 'standards_dir' must be a character vector of length 1")
  
  expect_error(init_r_project(overwrite = "invalid"), 
               "Parameter 'overwrite' must be a logical vector of length 1")
  
  expect_error(init_r_project(quiet = c(TRUE, FALSE)), 
               "Parameter 'quiet' must be a logical vector of length 1")
  
  expect_error(init_r_project(show_instructions = "invalid"), 
               "Parameter 'show_instructions' must be a logical vector of length 1")
})

test_that("init_r_project 自定义设置测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_init_project_custom_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 测试最小化设置
  result <- init_r_project(
    rstudio = FALSE,
    create_standards = FALSE,
    create_gitignore = FALSE,
    quiet = TRUE,
    show_instructions = FALSE
  )
  
  # 验证返回值
  expect_true(result$success)
  expect_false(result$created_items$rstudio_project)
  expect_false(result$created_items$standards_docs)
  expect_false(result$created_items$gitignore)
  
  # 验证只创建了目录结构
  expect_true(dir.exists("data/raw"))
  expect_true(dir.exists("scripts"))
  expect_true(dir.exists("output"))
  expect_false(file.exists(".Rproj"))
  expect_false(dir.exists("dev/design"))
  expect_false(file.exists(".gitignore"))
})

test_that("init_r_project 已存在文件处理测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_init_project_existing_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 创建一些已存在的文件和目录
  dir.create("data/raw", recursive = TRUE)
  file.create(".gitignore")
  
  # 测试不覆盖现有文件
  result <- init_r_project(
    overwrite = FALSE,
    quiet = TRUE,
    show_instructions = FALSE
  )
  
  # 验证函数正常运行
  expect_true(result$success)
  
  # 测试覆盖现有文件
  result2 <- init_r_project(
    overwrite = TRUE,
    quiet = TRUE,
    show_instructions = FALSE
  )
  
  expect_true(result2$success)
})

test_that("init_r_project 静默模式测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_init_project_quiet_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 测试静默模式
  expect_silent({
    result <- init_r_project(
      quiet = TRUE,
      show_instructions = FALSE
    )
  })
  
  expect_true(result$success)
})

test_that("init_r_project 返回值结构测试", {
  # 创建临时测试目录
  test_dir <- tempfile("test_init_project_return_")
  dir.create(test_dir)
  
  # 切换到测试目录
  old_wd <- getwd()
  setwd(test_dir)
  on.exit({
    setwd(old_wd)
    unlink(test_dir, recursive = TRUE)
  })
  
  # 执行测试
  result <- init_r_project(quiet = TRUE, show_instructions = FALSE)
  
  # 验证返回值结构
  expect_true(is.list(result))
  expect_true("success" %in% names(result))
  expect_true("project_path" %in% names(result))
  expect_true("project_name" %in% names(result))
  expect_true("created_items" %in% names(result))
  expect_true("validation" %in% names(result))
  expect_true("messages" %in% names(result))
  
  # 验证created_items结构
  expect_true(is.list(result$created_items))
  expect_true("rstudio_project" %in% names(result$created_items))
  expect_true("directories" %in% names(result$created_items))
  expect_true("standards_docs" %in% names(result$created_items))
  expect_true("gitignore" %in% names(result$created_items))
  
  # 验证validation结构
  expect_true(is.list(result$validation))
  expect_true("passed" %in% names(result$validation))
  expect_true("messages" %in% names(result$validation))
  
  # 验证数据类型
  expect_true(is.logical(result$success))
  expect_true(is.character(result$project_path))
  expect_true(is.character(result$project_name))
  expect_true(is.list(result$created_items))
  expect_true(is.list(result$validation))
  expect_true(is.character(result$messages))
}) 