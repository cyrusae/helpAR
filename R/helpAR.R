#turn the ipa column of our working table into a vector and return
#' Title
#'
#' @param res 
#'
#' @return
#' @export
#'
#' @examples
sendAR <- function(res) { 
  ### TODO: ...Where is 'or' coming from here? It worked in the original version but... what 
  setorder(res, or)
  vc <- res[[2]]
  vc
}

#replace anything that couldn't be identified as IPA with whatever the original input was
#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
fixAR <- function(x) {
  qc <- data.table(
    ar = x,
    ip = x
  )
  setkey(qc, ar)
  qc
}

#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
helpAR <- function(x) {
#  un <- unique(x) #TRY: wrapr safe drop-in `uniques` instead
  un <- wrapr::uniques(x = x)
  qc <- fixAR(un)
  res <- savAR(x)
  y <- makAR(parsAR(un))
  y <- y[is.na(ip), ip := qc[.(.SD), ip]][, i.ip := NULL]
  y <- res[is.na(ip), ip := y[.(.SD), ip]]
  yeet <- sendAR(y)
  yeet
}