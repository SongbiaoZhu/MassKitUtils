# MassKitUtils 可视化功能演示
# 演示 theme_publication() 和 save_publication_plot() 的使用

library(ggplot2)
library(MassKitUtils)

# 创建示例数据
set.seed(123)
demo_data <- data.frame(
  x = rnorm(100),
  y = rnorm(100),
  group = sample(c("A", "B", "C"), 100, replace = TRUE),
  category = sample(c("Type1", "Type2"), 100, replace = TRUE)
)

cat("=== MassKitUtils 可视化功能演示 ===\n\n")

# 1. 基础散点图
cat("1. 基础散点图\n")
p1 <- ggplot(demo_data, aes(x = x, y = y, color = group)) +
  geom_point(size = 2, alpha = 0.7) +
  labs(title = "Scatter Plot with Publication Theme",
       x = "X Variable", 
       y = "Y Variable",
       color = "Group") +
  theme_publication()

print(p1)
cat("基础散点图创建完成\n\n")

# 2. 自定义字体和设置
cat("2. 自定义字体和设置\n")
p2 <- ggplot(demo_data, aes(x = x, y = y, color = group)) +
  geom_point(size = 2) +
  labs(title = "Custom Font Settings",
       x = "X Variable", 
       y = "Y Variable") +
  theme_publication(
    base_size = 10,
    base_family = "Times New Roman",
    legend_position = "bottom",
    panel_border = FALSE
  )

print(p2)
cat("自定义设置图表创建完成\n\n")

# 3. 分面图
cat("3. 分面图\n")
p3 <- ggplot(demo_data, aes(x = x, y = y)) +
  geom_point(color = "#E64B35", size = 2) +
  facet_wrap(~category, labeller = label_both) +
  labs(title = "Faceted Plot",
       x = "X Variable", 
       y = "Y Variable") +
  theme_publication()

print(p3)
cat("分面图创建完成\n\n")

# 4. 箱线图
cat("4. 箱线图\n")
p4 <- ggplot(demo_data, aes(x = group, y = y, fill = group)) +
  geom_boxplot() +
  labs(title = "Box Plot by Group",
       x = "Group", 
       y = "Y Variable") +
  theme_publication(legend_position = "none")

print(p4)
cat("箱线图创建完成\n\n")

# 5. 保存高质量图片
cat("5. 保存高质量图片\n")

# 创建输出目录
if (!dir.exists("output")) {
  dir.create("output")
}

# 保存不同格式和尺寸的图片
cat("保存基础散点图...\n")
save_publication_plot(p1, "output/scatter_plot.png", 
                     target_width = 8, target_height = 6)

cat("保存小尺寸图片...\n")
save_publication_plot(p2, "output/small_plot.png", 
                     target_width = 3.5, target_height = 2.5)

cat("保存高分辨率图片...\n")
save_publication_plot(p3, "output/high_res_plot.png", 
                     target_width = 10, target_height = 8, dpi = 600)

cat("保存PDF格式...\n")
save_publication_plot(p4, "output/boxplot.pdf", 
                     target_width = 8, target_height = 6, format = "pdf")

cat("保存TIFF格式...\n")
save_publication_plot(p1, "output/scatter_plot.tiff", 
                     target_width = 8, target_height = 6, format = "tiff")

cat("\n=== 演示完成 ===\n")
cat("所有图片已保存到 output/ 目录\n")
cat("请检查以下文件：\n")
cat("- output/scatter_plot.png\n")
cat("- output/small_plot.png\n")
cat("- output/high_res_plot.png\n")
cat("- output/boxplot.pdf\n")
cat("- output/scatter_plot.tiff\n") 