# 文件管理函数

#' Ensure directory exists, create if it doesn't
#'
#' This function checks if a directory exists and creates it if it doesn't.
#' It provides a convenient way to ensure output directories are available
#' before writing files.
#'
#' @param path Character string for the directory path
#' @param recursive Logical, whether to create parent directories (default: TRUE)
#' @param showWarnings Logical, whether to show warnings (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create single directory
#' ensure_directory("output")
#'
#' # Create nested directories
#' ensure_directory("output/figures/2023")
#'
#' # Create with warnings
#' ensure_directory("output", showWarnings = TRUE)
#' }
ensure_directory <- function(path, recursive = TRUE, showWarnings = FALSE) {
  # 参数验证
  if (missing(path) || is.null(path)) {
    stop("Parameter 'directory_path' is required and cannot be empty")
  }
  
  if (!is.character(path)) {
    stop("Parameter 'directory_path' must be a non-empty character vector")
  }
  
  if (length(path) != 1) {
    stop("Parameter 'directory_path' must be a character vector of length 1")
  }
  
  if (nchar(path) == 0) {
    stop("Parameter 'directory_path' must be a non-empty character vector")
  }
  
  # 检查路径是否已存在
  if (file.exists(path)) {
    if (!dir.exists(path)) {
      stop("Path exists and is not a directory")
    }
    # 目录已存在，不需要创建
  } else {
    # 目录不存在，创建它
    dir.create(path, recursive = recursive, showWarnings = showWarnings)
    if (dir.exists(path)) {
      # message("Directory created: ", path)
    } else {
      stop("Failed to create directory:", path)
    }
  }
  
  invisible(NULL)
} 