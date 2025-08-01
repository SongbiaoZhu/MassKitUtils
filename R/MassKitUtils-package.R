#' MassKitUtils: Utility Functions for R Development and Data Export
#'
#' MassKitUtils provides a comprehensive set of utility functions for R package
#' management, project creation, file management, and data export.
#'
#' @author Songbiao Zhu \email{zhusongbiao@cimrbj.ac.cn}
#'
#' @section Key Features:
#' \itemize{
#'   \item Package management with automatic installation and loading
#'   \item Project creation with standardized directory structure
#'   \item File system operations with error handling
#'   \item Excel export with comprehensive formatting options
#' }
#'
#' @section Package Management:
#' \itemize{
#'   \item \code{\link{ensure_packages}}: Ensure packages are installed with intelligent source detection (CRAN/Bioconductor)
#'   \item \code{\link{load_packages}}: Load packages with error handling
#'   \item \code{\link{check_package_versions}}: Check package versions
#'   \item \code{\link{install_from_multiple_sources}}: Install packages from multiple sources (CRAN/Bioconductor)
#' }
#'
#' @section Project Management:
#' \itemize{
#'   \item \code{\link{setup_analysis_structure}}: Setup standard analysis directory structure in current directory
#' }
#'
#' @section File Management:
#' \itemize{
#'   \item \code{\link{ensure_directory}}: Ensure directory exists, create if it doesn't
#' }
#'
#' @section Data Export:
#' \itemize{
#'   \item \code{\link{export_to_excel}}: Export data to Excel with formatting options
#' }
#'
#' @section Development Tools:
#' \itemize{
#'   \item \code{\link{create_dev_standards}}: Create comprehensive R package development standards documentation
#'   \item \code{\link{create_gitignore}}: Create standard .gitignore file for R projects
#'   \item \code{\link{create_rbuildignore}}: Create standard .Rbuildignore file for R packages
#' }
#'

#' 
#' @examples
#' \dontrun{
#' # Package management
#' ensure_packages(c("dplyr", "ggplot2"))
#' load_packages(c("dplyr", "ggplot2"))
#' check_package_versions(c("dplyr", "ggplot2"))
#' 
#' # Project management
#' temp_dir <- tempdir()
#' setup_analysis_structure()
#' 
#' # File management
#' ensure_directory("output/figures")
#' 
#' # Data export
#' export_to_excel(mtcars, "cars.xlsx", 
#'                header_style = "colored", 
#'                table_style = "striped")
#' }
#' 
#' @keywords internal
"_PACKAGE" 