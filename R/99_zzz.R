# Package loading configuration
# This file is loaded last during package loading

.onLoad <- function(libname, pkgname) {
  # Set package options
  options(MSCRUtils.verbose = TRUE)
  options(MSCRUtils.debug = FALSE)
  
  # Set default styles for Excel export
  options(MSCRUtils.default_header_style = "default")
  options(MSCRUtils.default_table_style = "default")
  options(MSCRUtils.default_font_size = 11)
  
  invisible(NULL)
}

.onUnload <- function(libpath) {
  # Clean up package options
  options(MSCRUtils.verbose = NULL)
  options(MSCRUtils.debug = NULL)
  options(MSCRUtils.default_header_style = NULL)
  options(MSCRUtils.default_table_style = NULL)
  options(MSCRUtils.default_font_size = NULL)
  
  invisible(NULL)
} 