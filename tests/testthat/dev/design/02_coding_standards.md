# R包编码标准

## 命名规范

### 函数命名
- 使用`snake_case`命名法
- 动词开头，描述函数功能
- 示例: `ensure_packages`, `setup_analysis_structure`, `export_to_excel`

### 变量命名
- 使用`snake_case`命名法
- 描述性名称，避免缩写
- 示例: `package_names`, `output_directory`, `data_frame`

### 常量命名
- 使用`UPPER_SNAKE_CASE`
- 示例: `DEFAULT_FONT_SIZE`, `MAX_RETRY_ATTEMPTS`

### 内部函数命名
- 以`.`开头，表示内部函数
- 示例: `.validate_parameters`, `.apply_style`

## 代码结构

### 函数结构
```r
# 分节注释
#' 函数标题
#'
#' 函数描述
#'
#' @param param1 参数描述
#' @param param2 参数描述
#' @return 返回值描述
#' @export
#' @examples
#' \dontrun{
#' # 使用示例
#' }
function_name <- function(param1, param2 = default_value) {
  # 参数验证
  if (missing(param1) || is.null(param1)) {
    stop("Parameter 'param1' is required and cannot be empty")
  }
  
  # 主要逻辑
  result <- process_data(param1, param2)
  
  # 返回结果
  return(result)
}
```

## 注释规范

### 分节注释
- 使用单行注释格式: `# 分节名称 ===`
- 便于IDE显示和导航，支持代码折叠
- 示例: `# 包管理函数 ===`, `# 参数验证 ===`

### 行内注释
- 解释复杂逻辑
- 说明算法步骤
- 避免显而易见的注释

## 错误处理

### 错误信息
- 使用英文错误信息（符合CRAN标准）
- 清晰描述问题
- 提供解决建议

### 错误类型
- `stop()`: 严重错误，函数无法继续
- `warning()`: 警告，函数可以继续但结果可能不准确
- `message()`: 信息性消息

## 性能优化

### 向量化
- 优先使用向量化操作
- 避免循环，使用`apply`族函数
- 使用`data.table`处理大数据

### 内存管理
- 及时清理大型对象
- 使用`gc()`进行垃圾回收
- 避免内存泄漏

## 代码风格

### 缩进
- 使用2个空格缩进
- 保持一致的缩进风格

### 行长度
- 每行不超过80个字符
- 长行适当换行

### 空格
- 操作符前后加空格
- 逗号后加空格
- 函数调用括号内不加空格

## 依赖管理

### 包依赖
- 在DESCRIPTION中明确声明依赖
- 使用版本号限制依赖范围
- 避免循环依赖

### 导入策略
- 优先使用`::`操作符
- 避免`library()`和`require()`
- 在NAMESPACE中明确导入

