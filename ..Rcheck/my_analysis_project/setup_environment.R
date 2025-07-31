# Environment setup for my_analysis_project
# Run this script to install required packages

required_packages <- c(
  "dplyr",
  "ggplot2",
  "readr",
  "tidyr",
  "knitr",
  "rmarkdown"
)

# Install missing packages
install_if_missing(required_packages)

# Load packages
load_packages(required_packages)

cat("Environment setup completed!\n")

