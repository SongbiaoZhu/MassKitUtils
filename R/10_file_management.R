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
    stop("Parameter 'path' is required and cannot be empty")
  }
  
  if (!is.character(path) || length(path) != 1) {
    stop("Parameter 'path' must be a character vector of length 1")
  }
  
  if (!dir.exists(path)) {
    dir.create(path, recursive = recursive, showWarnings = showWarnings)
    if (dir.exists(path)) {
      cat("Directory created:", path, "\n")
    } else {
      stop("Failed to create directory:", path)
    }
  }
  
  invisible(NULL)
} 