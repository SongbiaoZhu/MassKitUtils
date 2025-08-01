# 项目创建函数

#' Setup standard analysis directory structure in current directory
#'
#' This function creates a standardized directory structure for data analysis
#' in the current working directory. It's designed for use when you're already
#' in your project directory (e.g., opened in RStudio or Cursor) and just need
#' to create the standard subdirectory structure.
#'
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @param overwrite Logical, whether to overwrite existing directories (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Setup analysis structure in current directory
#' setup_analysis_structure()
#'
#' # Setup silently
#' setup_analysis_structure(quiet = TRUE)
#'
#' # Setup and overwrite existing directories
#' setup_analysis_structure(overwrite = TRUE)
#' }
setup_analysis_structure <- function(quiet = FALSE, overwrite = FALSE) {
  # 参数验证
  if (!is.logical(quiet) || length(quiet) != 1) {
    stop("Parameter 'quiet' must be a logical vector of length 1")
  }
  
  if (!is.logical(overwrite) || length(overwrite) != 1) {
    stop("Parameter 'overwrite' must be a logical vector of length 1")
  }
  
  # 获取当前工作目录
  current_dir <- getwd()
  
  # 检查当前目录是否可写
  if (!file.access(current_dir, 2) == 0) {
    stop("Current directory is not writable: ", current_dir)
  }
  
  # 定义标准子目录结构
  subdirs <- c(
    "data/raw",           # 原始数据
    "data/processed",     # 处理后的数据
    "data/external",      # 外部参考数据（数据库、GSEA数据集等）
    "scripts",            # 分析脚本
    "output",             # 输出结果
    "config",             # 配置文件
    "docs"                # 文档
  )
  
  # 检查已存在的目录
  existing_dirs <- character(0)
  for (dir in subdirs) {
    if (dir.exists(file.path(current_dir, dir))) {
      existing_dirs <- c(existing_dirs, dir)
    }
  }
  
  # 如果存在目录且不允许覆盖，则停止
  if (length(existing_dirs) > 0 && !overwrite) {
    stop("The following directories already exist: ", 
         paste(existing_dirs, collapse = ", "), 
         ". Use overwrite = TRUE to overwrite them.")
  }
  
  # 创建目录结构
  created_dirs <- character(0)
  for (dir in subdirs) {
    dir_path <- file.path(current_dir, dir)
    if (!dir.exists(dir_path) || overwrite) {
      dir.create(dir_path, recursive = TRUE, showWarnings = FALSE)
      created_dirs <- c(created_dirs, dir)
    }
  }
  
  if (!quiet) {
    if (length(created_dirs) > 0) {
      message("Standard analysis directory structure created in: ", current_dir)
      message("Created directories:")
      for (dir in created_dirs) {
        message("  - ", dir)
      }
    } else {
      message("All standard directories already exist in: ", current_dir)
    }
    
    message("\nStandard directory structure:")
    message("  - data/raw/        (raw data)")
    message("  - data/processed/  (processed data)")
    message("  - data/external/   (external reference data)")
    message("  - scripts/         (analysis scripts)")
    message("  - output/          (output results)")
    message("  - config/          (configuration files)")
    message("  - docs/            (documentation)")
  }
  
  invisible(NULL)
} 