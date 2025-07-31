# Data Export Tests
# tests/testthat/test-data-export.R

test_that("export_to_excel 基本功能测试", {
  # 准备测试数据
  test_data <- data.frame(x = 1:5, y = letters[1:5])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 执行测试
  expect_message(export_to_excel(test_data, test_file), "Excel file saved to")
  expect_true(file.exists(test_file))
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 参数验证测试", {
  # 测试缺失参数
  expect_error(export_to_excel(), "Parameter 'data' is required and cannot be empty")
  expect_error(export_to_excel(mtcars), "Parameter 'filename' is required and cannot be empty")
  
  # 测试NULL参数
  expect_error(export_to_excel(NULL, "test.xlsx"), "Parameter 'data' is required and cannot be empty")
  expect_error(export_to_excel(mtcars, NULL), "Parameter 'filename' is required and cannot be empty")
  
  # 测试无效数据
  expect_error(export_to_excel(NULL, "test.xlsx"), "Parameter 'data' is required and cannot be empty")
  expect_error(export_to_excel(list(x = 1:5), "test.xlsx"), "Parameter 'data' must be a data frame")
  
  # 测试空数据
  empty_df <- data.frame()
  expect_error(export_to_excel(empty_df, "test.xlsx"), "Input data is empty, cannot export")
  
  # 测试无效文件名
  expect_error(export_to_excel(mtcars, 123), "Parameter 'filename' must be a character vector of length 1")
  expect_error(export_to_excel(mtcars, c("file1.xlsx", "file2.xlsx")), "Parameter 'filename' must be a character vector of length 1")
})

test_that("export_to_excel 样式参数验证测试", {
  # 测试无效header_style
  expect_error(
    export_to_excel(mtcars, "test.xlsx", header_style = "invalid"),
    "Unsupported header_style: invalid"
  )
  
  # 测试无效table_style
  expect_error(
    export_to_excel(mtcars, "test.xlsx", table_style = "invalid"),
    "Unsupported table_style: invalid"
  )
  
  # 测试有效样式
  test_file <- tempfile(fileext = ".xlsx")
  expect_message(export_to_excel(mtcars, test_file, header_style = "colored"), "Excel file saved to")
  expect_message(export_to_excel(mtcars, test_file, table_style = "striped"), "Excel file saved to")
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 不同样式组合测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 测试不同header样式
  header_styles <- c("default", "bold", "colored", "minimal")
  for (style in header_styles) {
    expect_message(export_to_excel(test_data, test_file, header_style = style), "Excel file saved to")
  }
  
  # 测试不同table样式
  table_styles <- c("default", "bordered", "striped", "minimal")
  for (style in table_styles) {
    expect_message(export_to_excel(test_data, test_file, table_style = style), "Excel file saved to")
  }
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 高级选项测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 测试添加摘要
  expect_message(export_to_excel(test_data, test_file, add_summary = TRUE), "Excel file saved to")
  
  # 测试不格式化表格
  expect_message(export_to_excel(test_data, test_file, format_table = FALSE), "Excel file saved to")
  
  # 测试自定义颜色
  expect_message(export_to_excel(test_data, test_file, 
                               header_bg_color = "#FF0000",
                               header_font_color = "#FFFFFF",
                               border_color = "#0000FF"), "Excel file saved to")
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 目录创建测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_dir <- tempfile("test_dir")
  test_file <- file.path(test_dir, "test.xlsx")
  
  # 测试自动创建目录
  expect_message(export_to_excel(test_data, test_file), "Excel file saved to")
  expect_true(dir.exists(test_dir))
  expect_true(file.exists(test_file))
  
  # 清理
  unlink(test_dir, recursive = TRUE)
})

test_that("export_to_excel 错误处理测试", {
  # 测试openxlsx包不可用的情况
  # 这个测试需要模拟openxlsx包不可用的情况
  # 在实际环境中，我们无法轻易移除已安装的包
  # 所以这里只测试其他错误情况
  
  # 测试无效的文件路径
  # 这个测试可能不会失败，因为函数会自动创建目录
  # 所以我们测试一个真正无效的路径
  expect_error(
    export_to_excel(mtcars, ""),
    "Parameter 'filename' is required and cannot be empty"
  )
}) 