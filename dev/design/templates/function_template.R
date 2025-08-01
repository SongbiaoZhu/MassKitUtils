# 函数模板

#' Function Title
#'
#' Function description
#'
#' @param param1 Parameter description
#' @param param2 Parameter description (default: value)
#' @return Return value description
#' @export
#' @examples
#' \dontrun{
#' # Usage example
#' function_name(param1, param2)
#' }
function_name <- function(param1, param2 = default_value) {
  # 参数验证
  if (missing(param1) || is.null(param1)) {
    stop("Parameter 'param1' is required and cannot be empty")
  }
  
  if (!is.character(param1) || length(param1) != 1) {
    stop("Parameter 'param1' must be a character vector of length 1")
  }
  
  # 主要逻辑
  result <- process_data(param1, param2)
  
  # 返回结果
  return(result)
}

