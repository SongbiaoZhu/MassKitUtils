pkgname <- "MassKitUtils"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('MassKitUtils')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MassKitUtils")
### * MassKitUtils

flush(stderr()); flush(stdout())

### Name: MassKitUtils
### Title: MassKitUtils: Utility Functions for R Development and Data
###   Export
### Aliases: MassKitUtils

### ** Examples

# Package management
install_if_missing(c("dplyr", "ggplot2"))
load_packages(c("dplyr", "ggplot2"))
check_package_versions(c("dplyr", "ggplot2"))

# Project management
create_r_project("my_analysis_project")

# File management
ensure_directory("output/figures")

# Data export
export_to_excel(mtcars, "cars.xlsx", 
               header_style = "colored", 
               table_style = "striped")


## Not run: 
##D # Package management
##D install_if_missing(c("dplyr", "ggplot2"))
##D load_packages(c("dplyr", "ggplot2"))
##D check_package_versions(c("dplyr", "ggplot2"))
##D 
##D # Project management
##D temp_dir <- tempdir()
##D create_r_project("my_analysis_project", path = temp_dir)
##D 
##D # File management
##D ensure_directory("output/figures")
##D 
##D # Data export
##D export_to_excel(mtcars, "cars.xlsx", 
##D                header_style = "colored", 
##D                table_style = "striped")
## End(Not run)




cleanEx()
nameEx("check_package_versions")
### * check_package_versions

flush(stderr()); flush(stdout())

### Name: check_package_versions
### Title: Check package versions
### Aliases: check_package_versions

### ** Examples

## Not run: 
##D # Check versions
##D versions <- check_package_versions(c("dplyr", "ggplot2"))
##D print(versions)
##D 
##D # Check against required versions
##D required <- c("dplyr" = "1.0.0", "ggplot2" = "3.3.0")
##D versions <- check_package_versions(c("dplyr", "ggplot2"), required)
##D print(versions)
## End(Not run)



cleanEx()
nameEx("create_r_project")
### * create_r_project

flush(stderr()); flush(stdout())

### Name: create_r_project
### Title: Create a new R project with standard structure
### Aliases: create_r_project

### ** Examples

## Not run: 
##D # Create project in temporary directory
##D temp_dir <- tempdir()
##D create_r_project("my_analysis_project", path = temp_dir)
##D 
##D # Create project in specific path
##D create_r_project("my_analysis_project", path = "~/projects")
##D 
##D # Create without environment setup
##D create_r_project("my_analysis_project", path = temp_dir, setup_env = FALSE)
## End(Not run)



cleanEx()
nameEx("ensure_directory")
### * ensure_directory

flush(stderr()); flush(stdout())

### Name: ensure_directory
### Title: Ensure directory exists, create if it doesn't
### Aliases: ensure_directory

### ** Examples

## Not run: 
##D # Create single directory
##D ensure_directory("output")
##D 
##D # Create nested directories
##D ensure_directory("output/figures/2023")
##D 
##D # Create with warnings
##D ensure_directory("output", showWarnings = TRUE)
## End(Not run)



cleanEx()
nameEx("export_to_excel")
### * export_to_excel

flush(stderr()); flush(stdout())

### Name: export_to_excel
### Title: Export data to Excel file with formatting options
### Aliases: export_to_excel

### ** Examples

## Not run: 
##D # Basic usage
##D export_to_excel(mtcars, "cars.xlsx")
##D 
##D # With custom styling
##D export_to_excel(mtcars, "cars_styled.xlsx", 
##D                header_style = "colored", 
##D                table_style = "striped")
##D 
##D # With summary sheet
##D export_to_excel(mtcars, "cars_with_summary.xlsx",
##D                add_summary = TRUE)
## End(Not run)




cleanEx()
nameEx("generate_dev_standards")
### * generate_dev_standards

flush(stderr()); flush(stdout())

### Name: generate_dev_standards
### Title: Generate R Package Development Standards Documentation
### Aliases: generate_dev_standards

### ** Examples

## Not run: 
##D # Generate standards documentation in default location
##D generate_dev_standards()
##D 
##D # Generate with custom package name
##D generate_dev_standards(package_name = "MyPackage")
##D 
##D # Generate in custom directory
##D generate_dev_standards("./docs/standards")
## End(Not run)



cleanEx()
nameEx("install_from_sources")
### * install_from_sources

flush(stderr()); flush(stdout())

### Name: install_from_sources
### Title: Install packages from multiple sources
### Aliases: install_from_sources

### ** Examples

## Not run: 
##D # Install packages from different sources
##D install_from_sources(
##D   cran_packages = c("dplyr", "ggplot2", "readr"),
##D   bioc_packages = c("Biobase", "limma"),
##D   github_packages = c("rmarkdown" = "rstudio/rmarkdown")
##D )
##D 
##D # Install only CRAN packages
##D install_from_sources(cran_packages = c("dplyr", "ggplot2"))
##D 
##D # Install only Bioconductor packages
##D install_from_sources(bioc_packages = c("Biobase", "limma"))
##D 
##D # Install only GitHub packages
##D install_from_sources(github_packages = c("tidyverse" = "tidyverse/tidyverse"))
## End(Not run)



cleanEx()
nameEx("install_if_missing")
### * install_if_missing

flush(stderr()); flush(stdout())

### Name: install_if_missing
### Title: Install packages if they are missing
### Aliases: install_if_missing

### ** Examples

## Not run: 
##D # Install CRAN packages if missing
##D install_if_missing(c("dplyr", "ggplot2"))
##D 
##D # Install with custom repository
##D install_if_missing("devtools", repos = "https://cran.rstudio.com/")
##D 
##D # Install Bioconductor packages
##D install_if_missing(c("Biobase", "limma"), bioc = TRUE)
##D 
##D # Install GitHub packages
##D install_if_missing("devtools")  # First install devtools
##D install_if_missing(github_packages = c("tidyverse" = "tidyverse/tidyverse"))
##D 
##D # Mixed installation
##D install_if_missing(
##D   packages = c("dplyr", "ggplot2"),
##D   bioc = TRUE,
##D   github_packages = c("rmarkdown" = "rstudio/rmarkdown")
##D )
## End(Not run)



cleanEx()
nameEx("load_packages")
### * load_packages

flush(stderr()); flush(stdout())

### Name: load_packages
### Title: Load packages with error handling
### Aliases: load_packages

### ** Examples

## Not run: 
##D # Load packages quietly
##D status <- load_packages(c("dplyr", "ggplot2"), quiet = TRUE)
##D print(status)
##D 
##D # Load with verbose output
##D load_packages(c("dplyr", "ggplot2"), quiet = FALSE)
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
