# 可视化功能测试

test_that("theme_publication creates a valid theme object", {
  # 加载必要的包
  library(ggplot2)
  # 基本功能测试
  theme_obj <- theme_publication()
  expect_s3_class(theme_obj, "theme")
  expect_s3_class(theme_obj, "gg")
  
  # 检查属性
  settings <- attr(theme_obj, "publication_settings")
  expect_type(settings, "list")
  expect_equal(settings$base_size, 12)
  expect_equal(settings$legend_position, "right")
})

test_that("theme_publication parameter validation works", {
  # 参数验证测试
  expect_error(theme_publication(base_size = -1), "positive numeric value")
  expect_error(theme_publication(base_size = "invalid"), "positive numeric value")
  expect_error(theme_publication(base_family = c("Arial", "Helvetica")), "length 1")
  expect_error(theme_publication(legend_position = "invalid"), "should be one of")
  expect_error(theme_publication(panel_border = "TRUE"), "logical vector")
})

test_that("theme_publication custom parameters work", {
  # 自定义参数测试
  theme_obj <- theme_publication(
    base_size = 10,
    base_family = "Times New Roman",
    legend_position = "bottom",
    panel_border = FALSE
  )
  
  settings <- attr(theme_obj, "publication_settings")
  expect_equal(settings$base_size, 10)
  expect_equal(settings$legend_position, "bottom")
})

test_that("theme_publication aspect ratio works", {
  # 宽高比测试
  theme_obj <- theme_publication(aspect_ratio = 1.5)
  settings <- attr(theme_obj, "publication_settings")
  expect_equal(settings$aspect_ratio, 1.5)
  
  # 无效宽高比
  expect_error(theme_publication(aspect_ratio = -1), "positive numeric value")
})

test_that("save_publication_plot parameter validation works", {
  # 加载必要的包
  library(ggplot2)
  # 创建测试图片
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
  
  # 参数验证测试
  expect_error(save_publication_plot("not_a_plot", "test.png"), "ggplot object")
  expect_error(save_publication_plot(p, c("file1.png", "file2.png")), "length 1")
  expect_error(save_publication_plot(p, "test.png", target_width = -1), "positive numeric value")
  expect_error(save_publication_plot(p, "test.png", target_height = 0), "positive numeric value")
  expect_error(save_publication_plot(p, "test.png", font_scale = -1), "positive numeric value")
  expect_error(save_publication_plot(p, "test.png", dpi = 0), "positive numeric value")
  expect_error(save_publication_plot(p, "test.png", format = "invalid"), "should be one of")
  expect_error(save_publication_plot(p, "test.png", show_info = "TRUE"), "logical vector")
})

test_that("save_publication_plot saves files correctly", {
  # 加载必要的包
  library(ggplot2)
  # 创建测试图片
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
  
  # 测试文件保存
  test_file <- tempfile(fileext = ".png")
  expect_message(
    save_publication_plot(p, test_file, target_width = 4, target_height = 3),
    "Plot saved successfully"
  )
  
  # 检查文件是否存在
  expect_true(file.exists(test_file))
  
  # 清理
  unlink(test_file)
})

test_that("save_publication_plot different formats work", {
  # 加载必要的包
  library(ggplot2)
  # 创建测试图片
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
  
  # 测试不同格式
  formats <- c("png", "pdf", "tiff", "jpg")
  
  for (fmt in formats) {
    test_file <- tempfile(fileext = paste0(".", fmt))
    expect_silent(
      save_publication_plot(p, test_file, 
                           target_width = 4, target_height = 3, 
                           format = fmt, show_info = FALSE)
    )
    expect_true(file.exists(test_file))
    unlink(test_file)
  }
})

test_that("save_publication_plot font scaling works", {
  # 加载必要的包
  library(ggplot2)
  # 创建测试图片
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
  
  # 测试字体缩放
  test_file <- tempfile(fileext = ".png")
  expect_message(
    save_publication_plot(p, test_file, 
                         target_width = 4, target_height = 3,
                         font_scale = 1.5, show_info = TRUE),
    "Font scale:"
  )
  
  # 清理
  unlink(test_file)
})

test_that("get_available_font returns valid font", {
  # 字体检查测试
  font <- get_available_font("Arial")
  expect_type(font, "character")
  expect_equal(length(font), 1)
  
  # 自定义字体
  font <- get_available_font("Times New Roman")
  expect_equal(font, "Times New Roman")
})

test_that("calculate_font_scale returns valid scaling", {
  # 字体缩放计算测试
  scale <- calculate_font_scale(8, 6, 300)
  expect_type(scale, "double")
  expect_true(scale > 0)
  
  # 小尺寸
  scale_small <- calculate_font_scale(3, 2, 300)
  expect_true(scale_small < 1)
  
  # 大尺寸
  scale_large <- calculate_font_scale(12, 8, 300)
  expect_true(scale_large > 1)
  
  # 高DPI
  scale_high_dpi <- calculate_font_scale(8, 6, 600)
  expect_true(scale_high_dpi > scale)
})

test_that("theme_publication works with different geometries", {
  # 加载必要的包
  library(ggplot2)
  # 测试不同几何体
  p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) + 
    geom_point() + 
    theme_publication()
  
  p2 <- ggplot(mtcars, aes(x = factor(cyl), y = mpg)) + 
    geom_boxplot() + 
    theme_publication()
  
  p3 <- ggplot(mtcars, aes(x = wt, y = mpg)) + 
    geom_smooth() + 
    theme_publication()
  
  expect_s3_class(p1, "ggplot")
  expect_s3_class(p2, "ggplot")
  expect_s3_class(p3, "ggplot")
})

test_that("theme_publication works with facets", {
  # 加载必要的包
  library(ggplot2)
  # 测试分面
  p <- ggplot(mtcars, aes(x = wt, y = mpg)) + 
    geom_point() + 
    facet_wrap(~cyl) + 
    theme_publication()
  
  expect_s3_class(p, "ggplot")
})

test_that("theme_publication works with legends", {
  # 加载必要的包
  library(ggplot2)
  # 测试图例
  p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) + 
    geom_point() + 
    theme_publication(legend_position = "bottom")
  
  expect_s3_class(p, "ggplot")
  
  # 无图例
  p_no_legend <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) + 
    geom_point() + 
    theme_publication(legend_position = "none")
  
  expect_s3_class(p_no_legend, "ggplot")
}) 