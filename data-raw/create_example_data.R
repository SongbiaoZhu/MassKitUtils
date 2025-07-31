# Data generation script for MSCRUtils package
# This script creates example datasets for the package

# Create example employee data
example_employees <- data.frame(
  ID = 1:10,
  Name = c("John Smith", "Jane Doe", "Bob Johnson", "Alice Brown", "Charlie Wilson",
           "Diana Davis", "Edward Miller", "Fiona Garcia", "George Lee", "Helen Taylor"),
  Age = c(32, 28, 35, 29, 41, 26, 38, 31, 33, 27),
  Salary = c(55000, 52000, 65000, 48000, 72000, 45000, 68000, 54000, 58000, 49000),
  Department = c("IT", "HR", "Finance", "Marketing", "IT", "HR", "Finance", "Marketing", "IT", "HR"),
  stringsAsFactors = FALSE
)

# Create example sales data
example_sales <- data.frame(
  Date = as.Date(c("2024-01-01", "2024-01-02", "2024-01-03", "2024-01-04", "2024-01-05")),
  Product = c("Product A", "Product B", "Product A", "Product C", "Product B"),
  Quantity = c(10, 5, 15, 8, 12),
  Revenue = c(1000, 500, 1500, 800, 1200),
  stringsAsFactors = FALSE
)

# Save datasets
usethis::use_data(example_employees, overwrite = TRUE)
usethis::use_data(example_sales, overwrite = TRUE)

cat("Example datasets created successfully!\n") 