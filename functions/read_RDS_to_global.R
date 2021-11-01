read_RDS_to_global <- function(file_path,
                               verbose = TRUE,
                               pos = 1) {
  # Check if path is accessible
  checkmate::assert_access(x = file_path, access = "r")
  
  
  readRDS(file = file_path) -> dta
  base_name <- basename(tools::file_path_sans_ext(file_path))
  assign(x = base_name,
         value = dta,
         envir = as.environment(pos))
  if (verbose) {
    msg <- paste("Created object:",
                 base_name,
                 "in global environment.",
                 collapse = " ")
    if (checkmate::allMissing(setdiff(base_name, ls(envir = as.environment(pos))))) {
      message(msg, appendLF = TRUE)
    } else {
      message(msg, appendLF = TRUE)
    }
  }
}