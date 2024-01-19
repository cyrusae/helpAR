
helpAR <- function(x, #TODO: make keeping original input optional vs allowing replacements
                   # keep = TRUE, 
                   ...) {
  wrapr::stop_if_dot_args(substitute(list(...)), 
                          'helpAR') #TODO: Verify that this is working as intended, haven't actually used it before!
#  stopifnot(isTRUEorFALSE(keep)) #no junk parameters
  
  stopifnot(is.list(x) || is.vector(x)) #need input to be parseable
  vec <- as.character(x) #coerce input to character
  
  input <- data.table::data.table( #working table
    rw = vec,
    ip = as.character(NA), #placeholder for IPA
    or = seq_along(x) #preserve original order
  )
  data.table::setkey(input, rw) 
  
  #draw out only relevant characters from input 
  pars <- vec %>.% gsub(pattern = '[^[:alpha:]@#]+',
                        replacement = '', 
                        x = ., 
                        perl = TRUE) %>.%
    wrapr::uniques(x = .)
  
  op <- data.table::data.table(
    rw = pars, #draw uniques from input
    ip = as.character(NA)
  )
  data.table::setkey(op, rw)
  
  y <- makAR(dt = op)
  
#  if (keep = TRUE) {
    y <- y[is.na(ip), ip := op[.(.SD), ip]][, i.ip := NULL]
#  }
  z <- input[is.na(ip), ip := y[.(.SD), ip]]
  data.table::setorder(z, or)
  
  yeet <- z[[2]]
}