# Data Export Tests
# tests/testthat/test-data-export.R

test_that("export_to_excel 基本功能测试", {
  # 准备测试数据
  test_data <- data.frame(x = 1:5, y = letters[1:5])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 执行测试
  expect_silent(export_to_excel(test_data, test_file))
  expect_true(file.exists(test_file))
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 参数验证测试", {
  # 测试缺失参数
  expect_error(export_to_excel(), "参数 'data' 是必需的")
  expect_error(export_to_excel(mtcars), "参数 'filename' 是必需的")
  
  # 测试NULL参数
  expect_error(export_to_excel(NULL, "test.xlsx"), "参数 'data' 是必需的")
  expect_error(export_to_excel(mtcars, NULL), "参数 'filename' 是必需的")
  
  # 测试无效数据
  expect_error(export_to_excel(NULL, "test.xlsx"), "参数 'data' 必须是数据框")
  expect_error(export_to_excel(list(x = 1:5), "test.xlsx"), "参数 'data' 必须是数据框")
  
  # 测试空数据
  empty_df <- data.frame()
  expect_error(export_to_excel(empty_df, "test.xlsx"), "输入数据为空，无法进行导出")
  
  # 测试无效文件名
  expect_error(export_to_excel(mtcars, 123), "参数 'filename' 必须是长度为1的字符向量")
  expect_error(export_to_excel(mtcars, c("file1.xlsx", "file2.xlsx")), "参数 'filename' 必须是长度为1的字符向量")
})

test_that("export_to_excel 样式参数验证测试", {
  # 测试无效header_style
  expect_error(
    export_to_excel(mtcars, "test.xlsx", header_style = "invalid"),
    "不支持的header_style: invalid"
  )
  
  # 测试无效table_style
  expect_error(
    export_to_excel(mtcars, "test.xlsx", table_style = "invalid"),
    "不支持的table_style: invalid"
  )
  
  # 测试有效样式
  test_file <- tempfile(fileext = ".xlsx")
  expect_silent(export_to_excel(mtcars, test_file, header_style = "colored"))
  expect_silent(export_to_excel(mtcars, test_file, table_style = "striped"))
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 不同样式组合测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 测试不同header样式
  header_styles <- c("default", "bold", "colored", "minimal")
  for (style in header_styles) {
    expect_silent(export_to_excel(test_data, test_file, header_style = style))
  }
  
  # 测试不同table样式
  table_styles <- c("default", "bordered", "striped", "minimal")
  for (style in table_styles) {
    expect_silent(export_to_excel(test_data, test_file, table_style = style))
  }
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 高级选项测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_file <- tempfile(fileext = ".xlsx")
  
  # 测试添加摘要
  expect_silent(export_to_excel(test_data, test_file, add_summary = TRUE))
  
  # 测试不格式化表格
  expect_silent(export_to_excel(test_data, test_file, format_table = FALSE))
  
  # 测试自定义颜色
  expect_silent(export_to_excel(test_data, test_file, 
                               header_bg_color = "#FF0000",
                               header_font_color = "#FFFFFF",
                               border_color = "#0000FF"))
  
  # 清理
  unlink(test_file)
})

test_that("export_to_excel 目录创建测试", {
  test_data <- data.frame(x = 1:3, y = letters[1:3])
  test_dir <- tempfile("test_dir")
  test_file <- file.path(test_dir, "test.xlsx")
  
  # 测试自动创建目录
  expect_silent(export_to_excel(test_data, test_file))
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
  expect_error(
    export_to_excel(mtcars, "/invalid/path/test.xlsx"),
    "Failed to create directory"
  )
}) 