# 包管理函数

#' Install packages if they are missing
#'
#' This function checks if specified packages are installed and installs
#' them automatically if they are missing. It supports packages from
#' CRAN, Bioconductor, and GitHub repositories.
#'
#' @param packages Character vector of package names to install
#' @param repos Repository URL (default: CRAN)
#' @param dependencies Logical, whether to install dependencies (default: TRUE)
#' @param quiet Logical, whether to suppress output (default: FALSE)
#' @param bioc Logical, whether to use Bioconductor (default: FALSE)
#' @param github_packages Named character vector for GitHub packages (format: c("package_name" = "username/repo"))
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Install CRAN packages if missing
#' install_if_missing(c("dplyr", "ggplot2"))
#'
#' # Install with custom repository
#' install_if_missing("devtools", repos = "https://cran.rstudio.com/")
#'
#' # Install Bioconductor packages
#' install_if_missing(c("Biobase", "limma"), bioc = TRUE)
#'
#' # Install GitHub packages
#' install_if_missing("devtools")  # First install devtools
#' install_if_missing(github_packages = c("tidyverse" = "tidyverse/tidyverse"))
#'
#' # Mixed installation
#' install_if_missing(
#'   packages = c("dplyr", "ggplot2"),
#'   bioc = TRUE,
#'   github_packages = c("rmarkdown" = "rstudio/rmarkdown")
#' )
#' }
install_if_missing <- function(packages = NULL, repos = getOption("repos"), 
                              dependencies = TRUE, quiet = FALSE, bioc = FALSE,
                              github_packages = NULL) {
  # Parameter validation
  if (is.null(packages) && is.null(github_packages)) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  # 处理CRAN和Bioconductor包
  if (!is.null(packages)) {
    if (!is.character(packages) || length(packages) == 0) {
      stop("Parameter 'packages' must be a non-empty character vector")
    }
    
    # 检查哪些包未安装
    missing_packages <- packages[!packages %in% installed.packages()[,"Package"]]
    
    if (length(missing_packages) > 0) {
      if (!quiet) {
        message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
      }
      
      # 安装Bioconductor包
      if (bioc) {
        if (!quiet) message("Installing Bioconductor packages...")
        
        # 检查BiocManager是否已安装
        if (!requireNamespace("BiocManager", quietly = TRUE)) {
          if (!quiet) message("Installing BiocManager...")
          install.packages("BiocManager", repos = repos, quiet = quiet)
        }
        
        # 使用BiocManager安装包
        BiocManager::install(missing_packages, dependencies = dependencies, quiet = quiet)
      } else {
        # 安装CRAN包
        if (!quiet) message("Installing CRAN packages...")
        utils::install.packages(missing_packages, repos = repos, 
                              dependencies = dependencies, quiet = quiet)
      }
      
      if (!quiet) {
        message("Package installation completed.")
      }
    } else {
      if (!quiet) {
        message("All packages are already installed.")
      }
    }
  }
  
  # 处理GitHub包
  if (!is.null(github_packages)) {
    if (!is.character(github_packages) || length(github_packages) == 0) {
      stop("Parameter 'github_packages' must be a non-empty character vector")
    }
    
    # 检查devtools是否已安装
    if (!requireNamespace("devtools", quietly = TRUE)) {
      if (!quiet) message("Installing devtools for GitHub package installation...")
      install.packages("devtools", repos = repos, quiet = quiet)
    }
    
    # 检查哪些GitHub包未安装
    github_pkg_names <- names(github_packages)
    missing_github_packages <- github_pkg_names[!github_pkg_names %in% installed.packages()[,"Package"]]
    
    if (length(missing_github_packages) > 0) {
      if (!quiet) {
        message("Installing missing GitHub packages: ", paste(missing_github_packages, collapse = ", "))
      }
      
      for (pkg_name in missing_github_packages) {
        repo <- github_packages[pkg_name]
        if (!quiet) message("Installing ", pkg_name, " from ", repo, "...")
        
        tryCatch({
          devtools::install_github(repo, quiet = quiet, dependencies = dependencies)
        }, error = function(e) {
          if (!quiet) {
            warning("Failed to install GitHub package '", pkg_name, "': ", e$message)
          }
        })
      }
      
      if (!quiet) {
        message("GitHub package installation completed.")
      }
    } else {
      if (!quiet) {
        message("All GitHub packages are already installed.")
      }
    }
  }
  
  invisible(NULL)
}

#' Install packages from multiple sources
#'
#' This function provides a convenient way to install packages from different
#' sources (CRAN, Bioconductor, GitHub) in a single call. It automatically
#' handles the installation of required tools (BiocManager, devtools) as needed.
#'
#' @param cran_packages Character vector of CRAN package names
#' @param bioc_packages Character vector of Bioconductor package names
#' @param github_packages Named character vector for GitHub packages (format: c("package_name" = "username/repo"))
#' @param repos Repository URL for CRAN (default: getOption("repos"))
#' @param dependencies Logical, whether to install dependencies (default: TRUE)
#' @param quiet Logical, whether to suppress output (default: FALSE)
#' @return Invisible NULL
#' @export
#' @examples
#' \dontrun{
#' # Install packages from different sources
#' install_from_sources(
#'   cran_packages = c("dplyr", "ggplot2", "readr"),
#'   bioc_packages = c("Biobase", "limma"),
#'   github_packages = c("rmarkdown" = "rstudio/rmarkdown")
#' )
#'
#' # Install only CRAN packages
#' install_from_sources(cran_packages = c("dplyr", "ggplot2"))
#'
#' # Install only Bioconductor packages
#' install_from_sources(bioc_packages = c("Biobase", "limma"))
#'
#' # Install only GitHub packages
#' install_from_sources(github_packages = c("tidyverse" = "tidyverse/tidyverse"))
#' }
install_from_sources <- function(cran_packages = NULL, bioc_packages = NULL, 
                                github_packages = NULL, repos = getOption("repos"),
                                dependencies = TRUE, quiet = FALSE) {
  # Parameter validation
  if (is.null(cran_packages) && is.null(bioc_packages) && is.null(github_packages)) {
    stop("At least one package source must be specified")
  }
  
  if (!quiet) {
    message("=== Multi-source Package Installation ===")
  }
  
  # 安装CRAN包
  if (!is.null(cran_packages)) {
          if (!quiet) message("\n1. Installing CRAN packages...")
    install_if_missing(packages = cran_packages, repos = repos, 
                      dependencies = dependencies, quiet = quiet, bioc = FALSE)
  }
  
  # 安装Bioconductor包
  if (!is.null(bioc_packages)) {
          if (!quiet) message("\n2. Installing Bioconductor packages...")
    install_if_missing(packages = bioc_packages, repos = repos, 
                      dependencies = dependencies, quiet = quiet, bioc = TRUE)
  }
  
  # 安装GitHub包
  if (!is.null(github_packages)) {
          if (!quiet) message("\n3. Installing GitHub packages...")
    install_if_missing(github_packages = github_packages, repos = repos, 
                      dependencies = dependencies, quiet = quiet)
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
load_packages <- function(packages, quiet = TRUE) {
  # Parameter validation
  if (missing(packages) || is.null(packages)) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  if (!is.character(packages) || length(packages) == 0) {
    stop("Parameter 'packages' must be a non-empty character vector")
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
check_package_versions <- function(packages, required_versions = NULL) {
  # Parameter validation
  if (missing(packages) || is.null(packages)) {
    stop("Parameter 'packages' is required and cannot be empty")
  }
  
  if (!is.character(packages) || length(packages) == 0) {
    stop("Parameter 'packages' must be a non-empty character vector")
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