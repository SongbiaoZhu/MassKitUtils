# 项目创建函数

#' Create a new analysis directory with standard structure
#'
#' This function creates a new analysis directory with a standardized structure
#' optimized for data analysis workflows, including common subdirectories for
#' data, scripts, output, and documentation.
#'
#' @param project_name Character string for the project name
#' @param path Character string for the project path (default: current working directory)
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Create analysis directory in current working directory
#' create_analysis_directory("my_analysis")
#'
#' # Create analysis directory in specific path
#' create_analysis_directory("my_analysis", path = "~/projects")
#'
#' # Create silently
#' create_analysis_directory("my_analysis", quiet = TRUE)
#' }
create_analysis_directory <- function(project_name, path = getwd(), quiet = FALSE) {
  # Parameter validation
  if (missing(project_name) || is.null(project_name)) {
    stop("Parameter 'project_name' is required and cannot be empty")
  }
  
  if (!is.character(project_name)) {
    stop("Parameter 'project_name' must be a non-empty character vector")
  }
  
  if (length(project_name) != 1) {
    stop("Parameter 'project_name' must be a character vector of length 1")
  }
  
  if (nchar(project_name) == 0) {
    stop("Parameter 'project_name' must be a non-empty character vector")
  }
  
  if (!is.character(path) || length(path) != 1) {
    stop("Parameter 'path' must be a character vector")
  }
  
  # Check if path exists
  if (!dir.exists(path)) {
    stop("Specified path does not exist")
  }
  
  # 创建项目目录
  project_path <- file.path(path, project_name)
  
  if (dir.exists(project_path)) {
    stop("Project directory already exists: ", project_path)
  }
  
  # 创建主项目目录
  dir.create(project_path, recursive = TRUE, showWarnings = FALSE)
  
  # 创建标准子目录结构
  subdirs <- c(
    "data/raw",           # 原始数据
    "data/processed",     # 处理后的数据
    "data/external",      # 外部参考数据（数据库、GSEA数据集等）
    "scripts",            # 分析脚本
    "output",             # 输出结果
    "config",             # 配置文件
    "docs"                # 文档
  )
  
  for (dir in subdirs) {
    dir.create(file.path(project_path, dir), recursive = TRUE, showWarnings = FALSE)
  }
  
  if (!quiet) {
    message("Analysis directory '", project_name, "' created successfully at: ", project_path)
    message("Standard directory structure has been created:")
    message("  - data/raw/        (原始数据)")
    message("  - data/processed/  (处理后的数据)")
    message("  - data/external/   (外部参考数据)")
    message("  - scripts/         (分析脚本)")
    message("  - output/          (输出结果)")
    message("  - config/          (配置文件)")
    message("  - docs/            (文档)")
  }
  
  invisible(NULL)
} 