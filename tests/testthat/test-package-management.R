# Package Management Tests
# tests/testthat/test-package-management.R

test_that("ensure_packages 基本功能测试", {
  # 准备测试数据
  test_packages <- c("testthat", "devtools")
  
  # 执行测试 - 这些包应该已经安装
  expect_message(ensure_packages(test_packages), "All packages are already installed")
})

test_that("ensure_packages 参数验证测试", {
  # 测试缺失参数
  expect_error(ensure_packages(), "Parameter 'packages' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(ensure_packages(NULL), "Parameter 'packages' is required and cannot be empty")
  
  # 测试空向量
  expect_error(ensure_packages(character(0)), "Parameter 'packages' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(ensure_packages(1:5), "Parameter 'packages' must be a character vector")
})

test_that("load_packages 基本功能测试", {
  # 准备测试数据
  test_packages <- c("testthat", "devtools")
  
  # 执行测试
  result <- load_packages(test_packages, quiet = TRUE)
  
  # 验证结果
  expect_true(is.logical(result))
  expect_equal(length(result), length(test_packages))
  expect_true(all(result))
})

test_that("load_packages 参数验证测试", {
  # 测试缺失参数
  expect_error(load_packages(), "Parameter 'packages' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(load_packages(NULL), "Parameter 'packages' is required and cannot be empty")
  
  # 测试空向量
  expect_error(load_packages(character(0)), "Parameter 'packages' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(load_packages(1:5), "Parameter 'packages' must be a character vector")
})

test_that("check_package_versions 基本功能测试", {
  # 准备测试数据
  test_packages <- c("testthat", "devtools")
  
  # 执行测试
  result <- check_package_versions(test_packages)
  
  # 验证结果
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), length(test_packages))
  expect_equal(colnames(result), c("Package", "Installed_Version", "Required_Version", "Status"))
  expect_true(all(result$Status %in% c("Installed", "Not Installed")))
})

test_that("check_package_versions 版本比较测试", {
  # 准备测试数据
  test_packages <- c("testthat")
  required_versions <- c("testthat" = "1.0.0")  # 使用一个很低的版本号
  
  # 执行测试
  result <- check_package_versions(test_packages, required_versions)
  
  # 验证结果
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), length(test_packages))
  expect_true("Required_Version" %in% colnames(result))
  expect_true("Status" %in% colnames(result))
})

test_that("check_package_versions 参数验证测试", {
  # 测试缺失参数
  expect_error(check_package_versions(), "Parameter 'packages' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(check_package_versions(NULL), "Parameter 'packages' is required and cannot be empty")
  
  # 测试空向量
  expect_error(check_package_versions(character(0)), "Parameter 'packages' is required and cannot be empty")
  
  # 测试非字符向量
  expect_error(check_package_versions(1:5), "Parameter 'packages' must be a character vector")
}) 