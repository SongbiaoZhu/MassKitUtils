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

#' Initialize R Project for Data Analysis
#'
#' Creates a standardized R project structure in the current working directory.
#' This function is designed to be run when you're already in your project
#' directory (e.g., opened in RStudio or Cursor). It automatically sets up
#' a complete project structure including RStudio project file, standard
#' directories, development standards documentation, and version control
#' configuration.
#'
#' @param rstudio Logical, whether to create RStudio project file (default: TRUE)
#' @param git Logical, whether to initialize git repository (default: FALSE)
#' @param create_dirs Logical, whether to create standard directory structure (default: TRUE)
#' @param create_standards Logical, whether to create development standards documentation (default: TRUE)
#' @param create_gitignore Logical, whether to create .gitignore file (default: TRUE)
#' @param standards_dir Character string for standards documentation directory (default: "dev/design")
#' @param overwrite Logical, whether to overwrite existing files (default: FALSE)
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @param show_instructions Logical, whether to show usage instructions (default: TRUE)
#' @return List containing project initialization results
#' @export
#' @examples
#' \dontrun{
#' # Quick setup with all defaults
#' init_r_project()
#'
#' # Custom setup without git and standards
#' init_r_project(
#'   git = FALSE,
#'   create_standards = FALSE,
#'   quiet = TRUE
#' )
#'
#' # Full setup with git initialization
#' init_r_project(
#'   git = TRUE,
#'   create_gitignore = TRUE,
#'   show_instructions = TRUE
#' )
#' }
init_r_project <- function(
  rstudio = TRUE,
  git = FALSE,
  create_dirs = TRUE,
  create_standards = TRUE,
  create_gitignore = TRUE,
  standards_dir = "dev/design",
  overwrite = FALSE,
  quiet = FALSE,
  show_instructions = TRUE
) {
  
  # === 1. 参数验证 ===
  if (!is.logical(rstudio) || length(rstudio) != 1) {
    stop("Parameter 'rstudio' must be a logical vector of length 1")
  }
  
  if (!is.logical(git) || length(git) != 1) {
    stop("Parameter 'git' must be a logical vector of length 1")
  }
  
  if (!is.logical(create_dirs) || length(create_dirs) != 1) {
    stop("Parameter 'create_dirs' must be a logical vector of length 1")
  }
  
  if (!is.logical(create_standards) || length(create_standards) != 1) {
    stop("Parameter 'create_standards' must be a logical vector of length 1")
  }
  
  if (!is.logical(create_gitignore) || length(create_gitignore) != 1) {
    stop("Parameter 'create_gitignore' must be a logical vector of length 1")
  }
  
  if (!is.character(standards_dir) || length(standards_dir) != 1) {
    stop("Parameter 'standards_dir' must be a character vector of length 1")
  }
  
  if (!is.logical(overwrite) || length(overwrite) != 1) {
    stop("Parameter 'overwrite' must be a logical vector of length 1")
  }
  
  if (!is.logical(quiet) || length(quiet) != 1) {
    stop("Parameter 'quiet' must be a logical vector of length 1")
  }
  
  if (!is.logical(show_instructions) || length(show_instructions) != 1) {
    stop("Parameter 'show_instructions' must be a logical vector of length 1")
  }
  
  # === 2. 环境准备 ===
  if (!quiet) {
    cat("=== 初始化R数据分析项目 ===\n")
  }
  
  # 检查并加载必要的包
  required_packages <- c("here", "usethis")
  missing_packages <- character(0)
  
  for (pkg in required_packages) {
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      missing_packages <- c(missing_packages, pkg)
    }
  }
  
  if (length(missing_packages) > 0) {
    if (!quiet) {
      cat("正在安装必要的包:", paste(missing_packages, collapse = ", "), "\n")
    }
    for (pkg in missing_packages) {
      install.packages(pkg, quiet = quiet)
    }
  }
  
  # 加载包
  library(here, quietly = TRUE)
  library(usethis, quietly = TRUE)
  
  # 验证当前目录可写
  current_dir <- getwd()
  if (!file.access(current_dir, 2) == 0) {
    stop("Current directory is not writable: ", current_dir)
  }
  
  # 自动获取项目名称（使用目录名）
  project_name <- basename(current_dir)
  
  if (!quiet) {
    cat("项目名称:", project_name, "\n")
    cat("项目路径:", current_dir, "\n\n")
  }
  
  # === 3. 创建RStudio项目 ===
  rstudio_created <- FALSE
  if (rstudio) {
    rproj_file <- paste0(project_name, ".Rproj")
    if (!file.exists(rproj_file)) {
      if (!quiet) {
        cat("正在创建RStudio项目文件...\n")
      }
      
      tryCatch({
        # 手动创建.Rproj文件，因为usethis::create_project在非空目录中可能失败
        rproj_content <- paste0(
          "Version: 1.0\n\n",
          "RestoreWorkspace: Default\n",
          "SaveWorkspace: Default\n",
          "AlwaysSaveHistory: Default\n\n",
          "EnableCodeIndexing: Yes\n",
          "UseSpacesForTab: Yes\n",
          "NumSpacesForTab: 2\n",
          "Encoding: UTF-8\n\n",
          "RnwWeave: Sweave\n",
          "LaTeX: pdf\n"
        )
        
        writeLines(rproj_content, rproj_file)
        rstudio_created <- TRUE
        if (!quiet) {
          cat("RStudio项目文件创建成功\n")
        }
      }, error = function(e) {
        if (!quiet) {
          warning("创建RStudio项目文件时出错: ", e$message)
        }
      })
    } else {
      if (!quiet) {
        cat("RStudio项目文件已存在，跳过创建\n")
      }
    }
  }
  
  # === 4. 创建目录结构 ===
  directories_created <- character(0)
  if (create_dirs) {
    if (!quiet) {
      cat("正在创建标准目录结构...\n")
    }
    
    tryCatch({
      setup_analysis_structure(quiet = quiet, overwrite = overwrite)
      directories_created <- c("data/raw", "data/processed", "data/external", 
                              "scripts", "output", "config", "docs")
      if (!quiet) {
        cat("标准目录结构创建成功\n")
      }
    }, error = function(e) {
      if (grepl("already exist", e$message)) {
        if (!quiet) {
          cat("目录已存在，跳过创建\n")
        }
      } else {
        stop(e)
      }
    })
  }
  
  # === 5. 创建开发规范文档 ===
  standards_created <- FALSE
  if (create_standards) {
    if (!quiet) {
      cat("正在创建开发规范文档...\n")
    }
    
    tryCatch({
      create_dev_standards(
        output_dir = standards_dir,
        package_name = project_name,
        overwrite = overwrite
      )
      standards_created <- TRUE
      if (!quiet) {
        cat("开发规范文档创建成功\n")
      }
    }, error = function(e) {
      if (grepl("already exist", e$message)) {
        if (!quiet) {
          cat("开发规范文档已存在，跳过创建\n")
        }
      } else {
        if (!quiet) {
          warning("创建开发规范文档时出错: ", e$message)
        }
      }
    })
  }
  
  # === 6. 创建.gitignore文件 ===
  gitignore_created <- FALSE
  if (create_gitignore) {
    if (!quiet) {
      cat("正在创建.gitignore文件...\n")
    }
    
    tryCatch({
      create_gitignore(
        project_path = ".",
        overwrite = overwrite,
        quiet = quiet
      )
      gitignore_created <- TRUE
      if (!quiet) {
        cat(".gitignore文件创建成功\n")
      }
    }, error = function(e) {
      if (grepl("already exist", e$message)) {
        if (!quiet) {
          cat(".gitignore文件已存在，跳过创建\n")
        }
      } else {
        if (!quiet) {
          warning("创建.gitignore文件时出错: ", e$message)
        }
      }
    })
  }
  
  # === 7. 验证项目结构 ===
  validation_passed <- TRUE
  validation_messages <- character(0)
  
  # 检查关键文件和目录
  required_items <- c(
    if (rstudio && rstudio_created) paste0(project_name, ".Rproj") else NULL,
    if (create_dirs && length(directories_created) > 0) c("data/raw", "scripts", "output") else NULL,
    if (create_standards && standards_created) standards_dir else NULL,
    if (create_gitignore && gitignore_created) ".gitignore" else NULL
  )
  required_items <- required_items[!is.null(required_items)]
  
  for (item in required_items) {
    if (!file.exists(item) && !dir.exists(item)) {
      validation_passed <- FALSE
      validation_messages <- c(validation_messages, paste("缺失:", item))
    }
  }
  
  # === 8. 显示项目信息和使用说明 ===
  if (!quiet) {
    cat("\n=== 项目初始化完成 ===\n")
    cat("项目名称:", project_name, "\n")
    cat("项目路径:", current_dir, "\n")
    cat("here() 包项目根目录:", here(), "\n")
    
    if (validation_passed) {
      cat("✅ 项目结构验证通过\n")
    } else {
      cat("⚠️  项目结构验证失败:\n")
      for (msg in validation_messages) {
        cat("  ", msg, "\n")
      }
    }
    
    if (show_instructions) {
      cat("\n=== 使用说明 ===\n")
      cat("1. 在RStudio中打开", project_name, ".Rproj 文件\n")
      cat("2. 使用 here() 包进行路径管理，例如：\n")
      cat("   - 数据文件: here('data', 'raw', 'filename.txt')\n")
      cat("   - 输出文件: here('output', 'result.png')\n")
      cat("3. 查看开发规范文档:", standards_dir, "\n")
      cat("4. 将分析脚本放在 scripts/ 目录中\n")
      cat("5. 将原始数据放在 data/raw/ 目录中\n")
      cat("6. 将输出结果保存在 output/ 目录中\n")
    }
  }
  
  # === 9. 返回结果 ===
  result <- list(
    success = validation_passed,
    project_path = current_dir,
    project_name = project_name,
    created_items = list(
      rstudio_project = rstudio_created,
      directories = directories_created,
      standards_docs = standards_created,
      gitignore = gitignore_created
    ),
    validation = list(
      passed = validation_passed,
      messages = validation_messages
    ),
    messages = c(
      "项目初始化完成",
      paste("请查看", standards_dir, "目录获取开发规范")
    )
  )
  
  invisible(result)
} 