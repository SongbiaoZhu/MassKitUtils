# 数据导出函数

#' Export data to Excel file with formatting options
#'
#' This function exports data frames to Excel files with comprehensive
#' formatting options including header styles, table styles, and
#' customizable colors and fonts.
#'
#' @param data Data frame to export
#' @param filename Character string for the output file name
#' @param sheet_name Character string for the worksheet name (default: "Data")
#' @param header_style Character string for header style. Options:
#'   \itemize{
#'     \item "default" - Gray background, centered, bold
#'     \item "bold" - Bold text only
#'     \item "colored" - Blue background, white text, centered
#'     \item "minimal" - Bold text only
#'   }
#' @param table_style Character string for table style. Options:
#'   \itemize{
#'     \item "default" - Top and bottom borders
#'     \item "bordered" - Full borders on all cells
#'     \item "striped" - Alternating row colors
#'     \item "minimal" - No borders
#'   }
#' @param header_bg_color Character string for header background color (hex code)
#' @param header_font_color Character string for header font color (hex code)
#' @param border_color Character string for border color (hex code)
#' @param font_size Numeric value for font size
#' @param auto_width Logical, whether to auto-adjust column widths (default: TRUE)
#' @param freeze_pane Logical, whether to freeze the first row (default: TRUE)
#' @param add_summary Logical, whether to add summary statistics (default: FALSE)
#' @param format_table Logical, whether to apply table formatting (default: TRUE)
#'
#' @return Invisible NULL
#'
#' @details
#' This function requires the openxlsx package to be installed. If the package
#' is not available, the function will stop with an error message.
#'
#' The function automatically creates output directories if they don't exist
#' and provides comprehensive error handling for various failure scenarios.
#'
#' @examples
#' \dontrun{
#' # Basic usage
#' export_to_excel(mtcars, "cars.xlsx")
#'
#' # With custom styling
#' export_to_excel(mtcars, "cars_styled.xlsx", 
#'                header_style = "colored", 
#'                table_style = "striped")
#'
#' # With summary sheet
#' export_to_excel(mtcars, "cars_with_summary.xlsx",
#'                add_summary = TRUE)
#' }
#'
#' @seealso \code{\link{install_if_missing}}, \code{\link{create_r_project}}
#' @export
export_to_excel <- function(data, filename, sheet_name = "Data", 
                           header_style = "default",
                           table_style = "default",
                           header_bg_color = "#D3D3D3",
                           header_font_color = "#000000",
                           border_color = "#000000",
                           font_size = 11,
                           auto_width = TRUE,
                           freeze_pane = TRUE,
                           add_summary = FALSE,
                           format_table = TRUE,
                           quiet = FALSE) {
  
  # 参数验证
  if (missing(data) || is.null(data)) {
    stop("Parameter 'data' is required and cannot be empty")
  }
  
  if (!is.data.frame(data)) {
    stop("Parameter 'data' must be a data frame")
  }
  
  if (nrow(data) == 0) {
    stop("Input data is empty, cannot export")
  }
  
  if (missing(filename) || is.null(filename)) {
    stop("Parameter 'filename' is required and cannot be empty")
  }
  
  if (!is.character(filename) || length(filename) != 1) {
    stop("Parameter 'filename' must be a character vector of length 1")
  }
  
  if (nchar(filename) == 0) {
    stop("Parameter 'filename' is required and cannot be empty")
  }
  
  # 验证样式参数
  valid_header_styles <- c("default", "bold", "colored", "minimal")
  if (!header_style %in% valid_header_styles) {
    stop(sprintf("Unsupported header_style: %s. Valid options: %s", 
                header_style, paste(valid_header_styles, collapse = ", ")))
  }
  
  valid_table_styles <- c("default", "bordered", "striped", "minimal")
  if (!table_style %in% valid_table_styles) {
    stop(sprintf("Unsupported table_style: %s. Valid options: %s", 
                table_style, paste(valid_table_styles, collapse = ", ")))
  }
  
  # 检查openxlsx包是否可用
  if (!requireNamespace("openxlsx", quietly = TRUE)) {
    stop("openxlsx package is required. Please install using: install.packages('openxlsx')")
  }
  
  # 确保输出目录存在
  output_dir <- dirname(filename)
  if (output_dir != ".") {
    ensure_directory(output_dir)
  }
  
  # 创建工作簿
  wb <- openxlsx::createWorkbook()
  
  # 添加工作表
  openxlsx::addWorksheet(wb, sheet_name)
  
  # 写入数据
  openxlsx::writeData(wb, sheet_name, data)
  
  # 应用格式化（如果请求）
  if (format_table) {
    # 应用表头样式
    apply_header_style(wb, sheet_name, data, header_style, 
                      header_bg_color, header_font_color, font_size)
    
    # 应用表格样式
    apply_table_style(wb, sheet_name, data, table_style, 
                     border_color, font_size)
  }
  
  # 自动调整列宽
  if (auto_width) {
    openxlsx::setColWidths(wb, sheet_name, cols = 1:ncol(data), widths = "auto")
  }
  
  # 冻结首行
  if (freeze_pane) {
    openxlsx::freezePane(wb, sheet_name, firstRow = TRUE)
  }
  
  # 添加摘要（如果请求）
  if (add_summary) {
    add_summary_sheet(wb, data, sheet_name)
  }
  
  # 保存工作簿
  openxlsx::saveWorkbook(wb, filename, overwrite = TRUE)
  if (!quiet) {
    message("Excel file saved to: ", filename)
  }
  
  invisible(NULL)
}

# 内部辅助函数

#' Apply header style to Excel worksheet
#'
#' Internal function to apply header styling to Excel worksheets.
#'
#' @param wb Workbook object
#' @param sheet_name Character string for worksheet name
#' @param data Data frame
#' @param style Character string for style type
#' @param bg_color Character string for background color
#' @param font_color Character string for font color
#' @param font_size Numeric value for font size
#' @return Invisible NULL
apply_header_style <- function(wb, sheet_name, data, style, bg_color, font_color, font_size) {
  header_style <- switch(style,
    "default" = openxlsx::createStyle(
      fgFill = bg_color,
      halign = "center",
      valign = "center",
      textDecoration = "bold",
      fontSize = font_size,
      fontColour = font_color
    ),
    "bold" = openxlsx::createStyle(
      textDecoration = "bold",
      fontSize = font_size
    ),
    "colored" = openxlsx::createStyle(
      fgFill = "#4F81BD",
      halign = "center",
      textDecoration = "bold",
      fontSize = font_size,
      fontColour = "#FFFFFF"
    ),
    "minimal" = openxlsx::createStyle(
      textDecoration = "bold",
      fontSize = font_size
    ),
    # Default fallback
    openxlsx::createStyle(
      fgFill = bg_color,
      halign = "center",
      valign = "center",
      textDecoration = "bold",
      fontSize = font_size,
      fontColour = font_color
    )
  )
  
  openxlsx::addStyle(wb, sheet_name, header_style, rows = 1, cols = 1:ncol(data))
}

#' Apply table style to Excel worksheet
#'
#' Internal function to apply table styling to Excel worksheets.
#'
#' @param wb Workbook object
#' @param sheet_name Character string for worksheet name
#' @param data Data frame
#' @param style Character string for style type
#' @param border_color Character string for border color
#' @param font_size Numeric value for font size
#' @return Invisible NULL
apply_table_style <- function(wb, sheet_name, data, style, border_color, font_size) {
  if (nrow(data) == 0) return()
  
  table_style <- switch(style,
    "default" = openxlsx::createStyle(
      border = "TopBottom",
      borderColour = border_color,
      fontSize = font_size
    ),
    "bordered" = openxlsx::createStyle(
      border = "TopBottomLeftRight",
      borderColour = border_color,
      fontSize = font_size
    ),
    "striped" = list(
      even = openxlsx::createStyle(
        fgFill = "#F2F2F2",
        border = "TopBottom",
        borderColour = border_color,
        fontSize = font_size
      ),
      odd = openxlsx::createStyle(
        border = "TopBottom",
        borderColour = border_color,
        fontSize = font_size
      )
    ),
    "minimal" = openxlsx::createStyle(
      fontSize = font_size
    ),
    # Default fallback
    openxlsx::createStyle(
      border = "TopBottom",
      borderColour = border_color,
      fontSize = font_size
    )
  )
  
  # Apply styles to data rows
  if (style == "striped" && is.list(table_style)) {
    # Apply alternating row colors
    for (row in 2:(nrow(data) + 1)) {
      if (row %% 2 == 0) {
        openxlsx::addStyle(wb, sheet_name, table_style$even, rows = row, cols = 1:ncol(data))
      } else {
        openxlsx::addStyle(wb, sheet_name, table_style$odd, rows = row, cols = 1:ncol(data))
      }
    }
  } else {
    # Apply uniform style to all data rows
    for (row in 2:(nrow(data) + 1)) {
      openxlsx::addStyle(wb, sheet_name, table_style, rows = row, cols = 1:ncol(data))
    }
  }
}

#' Add summary sheet to Excel workbook
#'
#' Internal function to add a summary sheet with data statistics.
#'
#' @param wb Workbook object
#' @param data Data frame
#' @param main_sheet_name Character string for main worksheet name
#' @return Invisible NULL
add_summary_sheet <- function(wb, data, main_sheet_name) {
  # Create summary worksheet
  summary_sheet <- "Summary"
  openxlsx::addWorksheet(wb, summary_sheet)
  
  # Basic summary statistics
  summary_data <- data.frame(
    Metric = c("Number of Rows", "Number of Columns", "Column Names"),
    Value = c(
      as.character(nrow(data)),
      as.character(ncol(data)),
      paste(colnames(data), collapse = ", ")
    ),
    stringsAsFactors = FALSE
  )
  
  # Add column types
  col_types <- sapply(data, function(x) class(x)[1])
  type_summary <- data.frame(
    Column = names(col_types),
    Type = col_types,
    stringsAsFactors = FALSE
  )
  
  # Write summary data
  openxlsx::writeData(wb, summary_sheet, "Data Summary", startRow = 1, startCol = 1)
  openxlsx::writeData(wb, summary_sheet, summary_data, startRow = 3, startCol = 1)
  
  # Write column types
  openxlsx::writeData(wb, summary_sheet, "Column Types", startRow = 8, startCol = 1)
  openxlsx::writeData(wb, summary_sheet, type_summary, startRow = 10, startCol = 1)
  
  # Apply basic formatting
  header_style <- openxlsx::createStyle(
    fgFill = "#D3D3D3",
    textDecoration = "bold",
    fontSize = 12
  )
  
  openxlsx::addStyle(wb, summary_sheet, header_style, rows = 1, cols = 1)
  openxlsx::addStyle(wb, summary_sheet, header_style, rows = 8, cols = 1)
  
  # Auto-adjust column widths
  openxlsx::setColWidths(wb, summary_sheet, cols = 1:2, widths = "auto")
} 