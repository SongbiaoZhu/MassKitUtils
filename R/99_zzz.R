# Package loading configuration
# This file is loaded last during package loading

.onLoad <- function(libname, pkgname) {
  # Set package options
  options(MassKitUtils.verbose = TRUE)
  options(MassKitUtils.debug = FALSE)
  
  # Set default styles for Excel export
  options(MassKitUtils.default_header_style = "default")
  options(MassKitUtils.default_table_style = "default")
  options(MassKitUtils.default_font_size = 11)
  
  invisible(NULL)
}

.onUnload <- function(libpath) {
  # Clean up package options
  options(MassKitUtils.verbose = NULL)
  options(MassKitUtils.debug = NULL)
  options(MassKitUtils.default_header_style = NULL)
  options(MassKitUtils.default_table_style = NULL)
  options(MassKitUtils.default_font_size = NULL)
  
  invisible(NULL)
} 