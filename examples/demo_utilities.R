# MSCRUtils Package Demo
# This script demonstrates the usage of various utility functions

# Load the package
library(MassKitUtils)

# 包管理示例 ===

cat("=== Package Management Examples ===\n")

# Install packages if missing (supports CRAN and Bioconductor)
cat("Installing packages if missing...\n")
ensure_packages(c("dplyr", "ggplot2", "readr"))

# Load packages with error handling
cat("Loading packages...\n")
load_status <- load_packages(c("dplyr", "ggplot2", "readr"))
print(load_status)

# Check package versions
cat("Checking package versions...\n")
version_info <- check_package_versions(c("dplyr", "ggplot2", "readr"))
print(version_info)

# 项目管理示例 ===

cat("\n=== Project Management Examples ===\n")

# Create a new R project (commented out to avoid creating during demo)
# create_analysis_directory("demo_analysis")

# 文件管理示例 ===

cat("\n=== File Management Examples ===\n")

# Ensure directory exists
cat("Creating output directory...\n")
ensure_directory("output/demo")

# 数据导出示例 ===

cat("\n=== Data Export Examples ===\n")

# Create sample data
sample_data <- data.frame(
  ID = 1:10,
  Name = paste("Person", 1:10),
  Age = sample(20:65, 10),
  Salary = round(rnorm(10, 50000, 10000), 2),
  Department = sample(c("IT", "HR", "Finance", "Marketing"), 10, replace = TRUE),
  stringsAsFactors = FALSE
)

cat("Sample data created:\n")
print(head(sample_data))

# Basic Excel export
cat("Exporting to Excel (basic)...\n")
export_to_excel(sample_data, "output/demo/basic_export.xlsx")

# Styled Excel export
cat("Exporting to Excel (styled)...\n")
export_to_excel(sample_data, "output/demo/styled_export.xlsx",
               header_style = "colored",
               table_style = "striped",
               add_summary = TRUE)

# Minimal style export
cat("Exporting to Excel (minimal)...\n")
export_to_excel(sample_data, "output/demo/minimal_export.xlsx",
               header_style = "minimal",
               table_style = "minimal",
               format_table = TRUE)



# 开发工具示例 ===

cat("\n=== Development Tools Examples ===\n")

# Create development standards documentation
cat("Creating development standards...\n")
create_dev_standards("./dev/design")
cat("Development standards documentation created in ./dev/design directory\n")

# Create ignore files
cat("Creating ignore files...\n")
create_gitignore()
create_rbuildignore()
cat("Ignore files created\n")

# 总结 ===

cat("\n=== Demo Summary ===\n")
cat("✓ Package management functions tested\n")
cat("✓ File management functions tested\n")
cat("✓ Data export functions tested\n")
cat("✓ Development tools functions tested\n")
cat("✓ Excel files created in output/demo/ directory\n")
cat("✓ Development standards created in ./dev/design directory\n")
cat("✓ Ignore files created\n")
cat("\nDemo completed successfully!\n") 