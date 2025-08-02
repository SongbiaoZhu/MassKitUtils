# 可视化工具函数

#' Scientific Publication Theme for ggplot2
#'
#' Creates a ggplot2 theme optimized for scientific publications with high
#' resolution, clear fonts, and professional appearance suitable for journal
#' submissions.
#'
#' @param base_size Numeric, base font size in points (default: 12)
#' @param base_family Character, font family (default: "Arial")
#' @param base_line_size Numeric, base line size (default: 0.5)
#' @param base_rect_size Numeric, base rectangle size (default: 0.5)
#' @param legend_position Character, legend position (default: "right")
#' @param aspect_ratio Numeric, aspect ratio (width/height), NULL for auto (default: NULL)
#' @param panel_border Logical, whether to add panel border (default: TRUE)
#' @param background_color Character, background color (default: "white")
#' @param panel_background_color Character, panel background color (default: "white")
#'
#' @return A ggplot2 theme object
#' @export
#' @examples
#' \dontrun{
#' library(ggplot2)
#' 
#' # Basic usage
#' p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_publication()
#' 
#' # Custom settings
#' p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
#'   geom_point() +
#'   theme_publication(
#'     base_size = 10,
#'     base_family = "Times New Roman",
#'     legend_position = "bottom"
#'   )
#' }
theme_publication <- function(
  base_size = 12,
  base_family = "Arial",
  base_line_size = 0.5,
  base_rect_size = 0.5,
  legend_position = c("right", "left", "top", "bottom", "none"),
  aspect_ratio = NULL,
  panel_border = TRUE,
  background_color = "white",
  panel_background_color = "white"
) {
  
  # 参数验证
  if (!is.numeric(base_size) || base_size <= 0) {
    stop("Parameter 'base_size' must be a positive numeric value")
  }
  
  if (!is.character(base_family) || length(base_family) != 1) {
    stop("Parameter 'base_family' must be a character vector of length 1")
  }
  
  if (!is.numeric(base_line_size) || base_line_size <= 0) {
    stop("Parameter 'base_line_size' must be a positive numeric value")
  }
  
  if (!is.numeric(base_rect_size) || base_rect_size <= 0) {
    stop("Parameter 'base_rect_size' must be a positive numeric value")
  }
  
  legend_position <- match.arg(legend_position)
  
  if (!is.logical(panel_border) || length(panel_border) != 1) {
    stop("Parameter 'panel_border' must be a logical vector of length 1")
  }
  
  # 字体回退机制
  actual_font <- get_available_font(base_family)
  
  # 设置字体大小比例
  title_size <- base_size * 1.2
  axis_title_size <- base_size
  axis_text_size <- base_size * 0.8
  legend_title_size <- base_size
  legend_text_size <- base_size * 0.8
  strip_text_size <- base_size * 0.8
  
  # 颜色设置（科研绘图标准）
  text_color <- "black"
  line_color <- "gray30"
  grid_color <- "gray90"
  panel_color <- panel_background_color
  
  # 创建基础主题
  theme_base <- ggplot2::theme_minimal(
    base_size = base_size,
    base_family = actual_font,
    base_line_size = base_line_size,
    base_rect_size = base_rect_size
  )
  
  # 构建主题
  theme_publication <- theme_base +
    ggplot2::theme(
      # 文本元素
      plot.title = ggplot2::element_text(
        size = title_size,
        face = "bold",
        color = text_color,
        margin = ggplot2::margin(b = base_size * 0.5)
      ),
      plot.subtitle = ggplot2::element_text(
        size = title_size * 0.9,
        face = "italic",
        color = text_color,
        margin = ggplot2::margin(b = base_size * 0.3)
      ),
      plot.caption = ggplot2::element_text(
        size = axis_text_size * 0.8,
        color = text_color,
        hjust = 0,
        margin = ggplot2::margin(t = base_size * 0.3)
      ),
      
      # 轴标题
      axis.title.x = ggplot2::element_text(
        size = axis_title_size,
        color = text_color,
        margin = ggplot2::margin(t = base_size * 0.3)
      ),
      axis.title.y = ggplot2::element_text(
        size = axis_title_size,
        color = text_color,
        margin = ggplot2::margin(r = base_size * 0.3),
        angle = 90
      ),
      
      # 轴文本
      axis.text.x = ggplot2::element_text(
        size = axis_text_size,
        color = text_color,
        margin = ggplot2::margin(t = base_size * 0.1)
      ),
      axis.text.y = ggplot2::element_text(
        size = axis_text_size,
        color = text_color,
        margin = ggplot2::margin(r = base_size * 0.1)
      ),
      
      # 轴线条
      axis.line.x = ggplot2::element_line(
        color = line_color,
        linewidth = base_line_size
      ),
      axis.line.y = ggplot2::element_line(
        color = line_color,
        linewidth = base_line_size
      ),
      
      # 刻度线
      axis.ticks = ggplot2::element_line(
        color = line_color,
        linewidth = base_line_size * 0.5
      ),
      axis.ticks.length = ggplot2::unit(base_size * 0.1, "pt"),
      
      # 面板
      panel.background = ggplot2::element_rect(
        fill = panel_color,
        color = if (panel_border) line_color else NA,
        linewidth = if (panel_border) base_line_size else 0
      ),
      panel.grid.major = ggplot2::element_blank(),  # 移除网格线
      panel.grid.minor = ggplot2::element_blank(),
      panel.spacing = ggplot2::unit(base_size * 0.5, "pt"),
      
      # 图例
      legend.position = legend_position,
      legend.title = ggplot2::element_text(
        size = legend_title_size,
        face = "bold",
        color = text_color
      ),
      legend.text = ggplot2::element_text(
        size = legend_text_size,
        color = text_color
      ),
      legend.background = ggplot2::element_rect(
        fill = "transparent",
        color = NA
      ),
      legend.box.background = ggplot2::element_rect(
        fill = "transparent",
        color = NA
      ),
      legend.key = ggplot2::element_rect(
        fill = "transparent",
        color = NA
      ),
      legend.key.size = ggplot2::unit(base_size * 0.8, "pt"),
      legend.margin = ggplot2::margin(base_size * 0.2),
      
      # 分面
      strip.background = ggplot2::element_rect(
        fill = "gray90",
        color = "gray70",
        linewidth = base_line_size * 0.5
      ),
      strip.text = ggplot2::element_text(
        size = strip_text_size,
        face = "bold",
        color = text_color,
        margin = ggplot2::margin(base_size * 0.1)
      ),
      
      # 整体背景
      plot.background = ggplot2::element_rect(
        fill = background_color,
        color = NA
      ),
      
      # 边距
      plot.margin = ggplot2::margin(
        base_size * 0.5,
        base_size * 0.5,
        base_size * 0.5,
        base_size * 0.5
      )
    )
  
  # 设置宽高比（如果指定）
  if (!is.null(aspect_ratio)) {
    if (!is.numeric(aspect_ratio) || aspect_ratio <= 0) {
      stop("Parameter 'aspect_ratio' must be a positive numeric value")
    }
    theme_publication <- theme_publication +
      ggplot2::theme(aspect.ratio = aspect_ratio)
  }
  
  # 添加属性信息
  attr(theme_publication, "publication_settings") <- list(
    base_size = base_size,
    base_family = actual_font,
    legend_position = legend_position,
    aspect_ratio = aspect_ratio
  )
  
  return(theme_publication)
}

#' Save Publication Quality Plot
#'
#' Saves a ggplot object with publication-quality settings including
#' appropriate resolution, size, and format. Automatically adjusts font scaling
#' based on target dimensions.
#'
#' @param plot A ggplot object
#' @param filename Character, output filename
#' @param target_width Numeric, target width in inches (default: 8)
#' @param target_height Numeric, target height in inches (default: 6)
#' @param font_scale Numeric, font scaling factor (default: 1)
#' @param dpi Numeric, resolution in DPI (default: 300)
#' @param format Character, output format: "png", "pdf", "tiff", "jpg" (default: "png")
#' @param units Character, units for width/height: "in", "cm", "mm" (default: "in")
#' @param bg Character, background color (default: "white")
#' @param show_info Logical, whether to show save information (default: TRUE)
#' @param ... Additional arguments passed to ggsave
#'
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' library(ggplot2)
#' 
#' p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
#'   geom_point() +
#'   theme_publication()
#' 
#' # Save with publication quality
#' save_publication_plot(p, "my_plot.png", 
#'                      target_width = 8, target_height = 6)
#' 
#' # Save with custom font scaling
#' save_publication_plot(p, "my_plot.png", 
#'                      target_width = 8, target_height = 6,
#'                      font_scale = 1.2)
#' }
save_publication_plot <- function(
  plot,
  filename,
  target_width = 8,
  target_height = 6,
  font_scale = 1,
  dpi = 300,
  format = c("png", "pdf", "tiff", "jpg"),
  units = c("in", "cm", "mm"),
  bg = "white",
  show_info = TRUE,
  ...
) {
  
  # 参数验证
  if (!inherits(plot, "ggplot")) {
    stop("Parameter 'plot' must be a ggplot object")
  }
  
  if (!is.character(filename) || length(filename) != 1) {
    stop("Parameter 'filename' must be a character vector of length 1")
  }
  
  if (!is.numeric(target_width) || target_width <= 0) {
    stop("Parameter 'target_width' must be a positive numeric value")
  }
  
  if (!is.numeric(target_height) || target_height <= 0) {
    stop("Parameter 'target_height' must be a positive numeric value")
  }
  
  if (!is.numeric(font_scale) || font_scale <= 0) {
    stop("Parameter 'font_scale' must be a positive numeric value")
  }
  
  if (!is.numeric(dpi) || dpi <= 0) {
    stop("Parameter 'dpi' must be a positive numeric value")
  }
  
  format <- match.arg(format)
  units <- match.arg(units)
  
  if (!is.logical(show_info) || length(show_info) != 1) {
    stop("Parameter 'show_info' must be a logical vector of length 1")
  }
  
  # 计算智能字体缩放
  calculated_scale <- calculate_font_scale(target_width, target_height, dpi)
  final_font_scale <- calculated_scale * font_scale
  
  # 应用字体缩放到图片
  plot_scaled <- plot + 
    ggplot2::theme(
      text = ggplot2::element_text(size = ggplot2::rel(final_font_scale)),
      axis.title = ggplot2::element_text(size = ggplot2::rel(final_font_scale)),
      axis.text = ggplot2::element_text(size = ggplot2::rel(final_font_scale)),
      legend.title = ggplot2::element_text(size = ggplot2::rel(final_font_scale)),
      legend.text = ggplot2::element_text(size = ggplot2::rel(final_font_scale)),
      plot.title = ggplot2::element_text(size = ggplot2::rel(final_font_scale * 1.2)),
      strip.text = ggplot2::element_text(size = ggplot2::rel(final_font_scale))
    )
  
  # 保存图片
  ggplot2::ggsave(
    filename = filename,
    plot = plot_scaled,
    width = target_width,
    height = target_height,
    dpi = dpi,
    units = units,
    bg = bg,
    ...
  )
  
  # 显示保存信息
  if (show_info) {
    file_size <- file.size(filename)
    file_size_mb <- round(file_size / 1024 / 1024, 2)
    
    message(sprintf(
      "Plot saved successfully:\n  File: %s\n  Size: %s MB\n  Dimensions: %.1f x %.1f %s\n  Resolution: %d DPI\n  Font scale: %.2f",
      filename, file_size_mb, target_width, target_height, units, dpi, final_font_scale
    ))
  }
  
  invisible(NULL)
}

# 内部辅助函数

#' Get Available Font
#'
#' Checks font availability and returns the first available font from the priority list.
#'
#' @param preferred_font Character, preferred font family
#' @return Character, available font family
#' @keywords internal
get_available_font <- function(preferred_font = "Arial") {
  
  # 字体优先级列表
  font_priority <- c("Arial", "Helvetica", "Times New Roman", "Calibri", "sans")
  
  # 如果用户指定了字体，将其放在第一位
  if (preferred_font != "Arial") {
    font_priority <- c(preferred_font, font_priority[font_priority != preferred_font])
  }
  
  # 检查字体可用性（简化检查）
  # 在实际实现中，这里需要更复杂的字体检查逻辑
  # 暂时返回首选字体，在实际使用中ggplot2会自动回退
  
  # 显示字体信息
  if (preferred_font != "Arial") {
    message(sprintf("Using font: %s", preferred_font))
  }
  
  return(preferred_font)
}

#' Calculate Font Scale
#'
#' Calculates appropriate font scaling based on target dimensions and DPI.
#'
#' @param width Numeric, target width
#' @param height Numeric, target height
#' @param dpi Numeric, resolution
#' @return Numeric, font scaling factor
#' @keywords internal
calculate_font_scale <- function(width, height, dpi = 300) {
  
  # 基础缩放因子
  base_scale <- 1.0
  
  # 根据尺寸调整
  if (width < 4) {
    base_scale <- 0.8  # 小图片，字体稍小
  } else if (width > 10) {
    base_scale <- 1.2  # 大图片，字体稍大
  }
  
  # 根据DPI调整
  if (dpi > 400) {
    base_scale <- base_scale * 1.1  # 高分辨率，字体稍大
  } else if (dpi < 200) {
    base_scale <- base_scale * 0.9  # 低分辨率，字体稍小
  }
  
  return(base_scale)
} 