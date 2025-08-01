# 测试模板

test_that("function_name works correctly", {
  # 准备测试数据
  test_data <- data.frame(x = 1:5, y = letters[1:5])
  
  # 测试正常情况
  result <- function_name(test_data)
  expect_is(result, "data.frame")
  expect_equal(nrow(result), 5)
  
  # 测试边界条件
  empty_data <- data.frame()
  expect_error(function_name(empty_data), "Input data is empty")
  
  # 测试参数验证
  expect_error(function_name(NULL), "Parameter 'data' is required")
})

