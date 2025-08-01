# 包管理函数

#' Ensure packages are installed with intelligent source detection
#'
#' This function intelligently installs packages by automatically detecting
#' whether they are available from CRAN or Bioconductor. It first tries CRAN,
#' and if that fails, it tries Bioconductor.
#'
#' @param packages Character vector of package names to ensure are installed
#' @param repos Character vector of CRAN repository URLs (default: getOption("repos"))
#' @param dependencies Logical, whether to install dependencies (default: TRUE)
#' @param quiet Logical, whether to suppress messages (default: FALSE)
#' @return Invisible list with installation results
#' @export
#' @examples
#' \dontrun{
#' # Install packages with automatic source detection
#' ensure_packages(c("dplyr", "ggplot2", "Biobase", "limma"))
#'
#' # Silent installation
#' ensure_packages(c("dplyr", "ggplot2"), quiet = TRUE)
#'
#' # Without dependencies
#' ensure_packages(c("dplyr"), dependencies = FALSE)
#' }
ensure_packages <- function(packages = NULL, repos = getOption("repos"), 
                           dependencies = TRUE, quiet = FALSE) {
  
  # 参数验证
  if (is.null(packages) || length(packages) == 0) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  if (!is.character(packages)) {
    stop("Parameter 'packages' must be a character vector")
  }
  
  # 检查哪些包未安装
  missing_packages <- packages[!packages %in% installed.packages()[,"Package"]]
  
  if (length(missing_packages) == 0) {
    if (!quiet) message("All packages are already installed.")
    return(invisible(list(success = character(0), failed = character(0))))
  }
  
  if (!quiet) {
    message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
  }
  
  # 安装结果跟踪
  installation_results <- list(
    success = character(0),
    failed = character(0)
  )
  
  # 对每个缺失的包进行智能安装
  for (pkg in missing_packages) {
    # 先尝试CRAN
    cran_success <- try_install_cran(pkg, repos, dependencies, quiet)
    
    if (cran_success) {
      installation_results$success <- c(installation_results$success, pkg)
      next
    }
    
    # 如果CRAN失败，尝试Bioconductor
    bioc_success <- try_install_bioc(pkg, dependencies, quiet)
    
    if (bioc_success) {
      installation_results$success <- c(installation_results$success, pkg)
    } else {
      installation_results$failed <- c(installation_results$failed, pkg)
    }
  }
  
  # 输出安装结果摘要
  if (!quiet) {
    if (length(installation_results$success) > 0) {
      message("Successfully installed: ", paste(installation_results$success, collapse = ", "))
    }
    
    if (length(installation_results$failed) > 0) {
      warning("Failed to install: ", paste(installation_results$failed, collapse = ", "))
    }
  }
  
  # 返回安装结果
  invisible(installation_results)
}

#' Try to install a package from CRAN
#' @keywords internal
try_install_cran <- function(pkg, repos, dependencies, quiet) {
  tryCatch({
    if (!quiet) message("Trying to install '", pkg, "' from CRAN...")
    
    # 尝试安装
    utils::install.packages(pkg, repos = repos, 
                          dependencies = dependencies, 
                          quiet = quiet)
    
    # 验证安装是否成功
    if (pkg %in% installed.packages()[,"Package"]) {
      if (!quiet) message("Successfully installed '", pkg, "' from CRAN")
      return(TRUE)
    } else {
      return(FALSE)
    }
  }, error = function(e) {
    if (!quiet) message("Failed to install '", pkg, "' from CRAN: ", e$message)
    return(FALSE)
  })
}

#' Try to install a package from Bioconductor
#' @keywords internal
try_install_bioc <- function(pkg, dependencies, quiet) {
  tryCatch({
    if (!quiet) message("Trying to install '", pkg, "' from Bioconductor...")
    
    # 检查BiocManager是否已安装
    if (!requireNamespace("BiocManager", quietly = TRUE)) {
      if (!quiet) message("Installing BiocManager...")
      utils::install.packages("BiocManager", quiet = quiet)
    }
    
    # 尝试安装Bioconductor包
    BiocManager::install(pkg, dependencies = dependencies, quiet = quiet)
    
    # 验证安装是否成功
    if (pkg %in% installed.packages()[,"Package"]) {
      if (!quiet) message("Successfully installed '", pkg, "' from Bioconductor")
      return(TRUE)
    } else {
      return(FALSE)
    }
  }, error = function(e) {
    if (!quiet) message("Failed to install '", pkg, "' from Bioconductor: ", e$message)
    return(FALSE)
  })
}



#' Install packages from multiple sources
#'
#' This function provides a convenient way to install packages from different
#' sources (CRAN, Bioconductor) in a single call. It automatically
#' handles the installation of required tools (BiocManager) as needed.
#'
#' @param cran_packages Character vector of CRAN package names
#' @param bioc_packages Character vector of Bioconductor package names
#' @param repos Repository URL for CRAN (default: getOption("repos"))
#' @param dependencies Logical, whether to install dependencies (default: TRUE)
#' @param quiet Logical, whether to suppress output (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Install packages from different sources
#' install_from_multiple_sources(
#'   cran_packages = c("dplyr", "ggplot2", "readr"),
#'   bioc_packages = c("Biobase", "limma")
#' )
#'
#' # Install only CRAN packages
#' install_from_multiple_sources(cran_packages = c("dplyr", "ggplot2"))
#'
#' # Install only Bioconductor packages
#' install_from_multiple_sources(bioc_packages = c("Biobase", "limma"))
#' }
install_from_multiple_sources <- function(cran_packages = NULL, bioc_packages = NULL, 
                                repos = getOption("repos"),
                                dependencies = TRUE, quiet = FALSE) {
  # Parameter validation
  if (is.null(cran_packages) && is.null(bioc_packages)) {
    stop("At least one package source must be specified")
  }
  
  if (!quiet) {
    message("=== Multi-source Package Installation ===")
  }
  
  # 安装CRAN包
  if (!is.null(cran_packages)) {
    if (!quiet) message("\n1. Installing CRAN packages...")
    ensure_packages(packages = cran_packages, repos = repos, 
                    dependencies = dependencies, quiet = quiet)
  }
  
  # 安装Bioconductor包
  if (!is.null(bioc_packages)) {
    if (!quiet) message("\n2. Installing Bioconductor packages...")
    # 直接使用BiocManager安装Bioconductor包
    for (pkg in bioc_packages) {
      try_install_bioc(pkg, dependencies, quiet)
    }
  }
  
  if (!quiet) {
    message("\n=== Multi-source installation completed ===")
  }
  
  invisible(NULL)
}

#' Load packages with error handling
#'
#' This function loads packages with comprehensive error handling and
#' returns a status vector indicating which packages were successfully loaded.
#'
#' @param packages Character vector of package names to load
#' @param quiet Logical, whether to suppress messages (default: TRUE)
#' @return Logical vector indicating which packages were successfully loaded
#' @export
#' @examples
#' \dontrun{
#' # Load packages quietly
#' status <- load_packages(c("dplyr", "ggplot2"), quiet = TRUE)
#' print(status)
#'
#' # Load with verbose output
#' load_packages(c("dplyr", "ggplot2"), quiet = FALSE)
#' }
load_packages <- function(packages = NULL, quiet = TRUE) {
  # Parameter validation
  if (is.null(packages) || length(packages) == 0) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  if (!is.character(packages)) {
    stop("Parameter 'packages' must be a character vector")
  }
  
  loaded_status <- logical(length(packages))
  names(loaded_status) <- packages
  
  for (i in seq_along(packages)) {
    pkg <- packages[i]
    tryCatch({
      if (quiet) {
        suppressMessages(suppressWarnings(library(pkg, character.only = TRUE)))
      } else {
        library(pkg, character.only = TRUE)
      }
      loaded_status[i] <- TRUE
    }, error = function(e) {
      if (!quiet) {
        warning("Failed to load package '", pkg, "': ", e$message)
      }
      loaded_status[i] <- FALSE
    })
  }
  
  if (!quiet) {
    failed_packages <- packages[!loaded_status]
    if (length(failed_packages) > 0) {
      warning("Failed to load packages: ", paste(failed_packages, collapse = ", "))
    }
  }
  
  return(loaded_status)
}

#' Check package versions
#'
#' This function checks the installed versions of specified packages and
#' optionally compares them with required versions to determine if updates
#' are needed.
#'
#' @param packages Character vector of package names to check
#' @param required_versions Named character vector of required versions (optional)
#' @return Data frame with package names and their versions
#' @export
#' @examples
#' \dontrun{
#' # Check versions
#' versions <- check_package_versions(c("dplyr", "ggplot2"))
#' print(versions)
#'
#' # Check against required versions
#' required <- c("dplyr" = "1.0.0", "ggplot2" = "3.3.0")
#' versions <- check_package_versions(c("dplyr", "ggplot2"), required)
#' print(versions)
#' }
check_package_versions <- function(packages = NULL, required_versions = NULL) {
  # Parameter validation
  if (is.null(packages) || length(packages) == 0) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  if (!is.character(packages)) {
    stop("Parameter 'packages' must be a character vector")
  }
  
  # 获取已安装包信息
  installed_packages <- installed.packages()
  
  # 创建结果数据框
  result <- data.frame(
    Package = packages,
    Installed_Version = NA_character_,
    Required_Version = NA_character_,
    Status = "Not Installed",
    stringsAsFactors = FALSE
  )
  
  for (i in seq_along(packages)) {
    pkg <- packages[i]
    
    if (pkg %in% installed_packages[, "Package"]) {
      result$Installed_Version[i] <- installed_packages[pkg, "Version"]
      result$Status[i] <- "Installed"
    }
    
    # 检查是否指定了必需版本
    if (!is.null(required_versions) && pkg %in% names(required_versions)) {
      result$Required_Version[i] <- required_versions[pkg]
      
      # 如果两个版本都可用，则比较版本
      if (!is.na(result$Installed_Version[i])) {
        installed_ver <- result$Installed_Version[i]
        required_ver <- result$Required_Version[i]
        
        if (utils::compareVersion(installed_ver, required_ver) >= 0) {
          result$Status[i] <- "OK"
        } else {
          result$Status[i] <- "Update Required"
        }
      }
    }
  }
  
  return(result)
} 