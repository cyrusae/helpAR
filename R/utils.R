## Create constant tables

mARPA <- c("a", "@", "A", "c", "W", "x", "Y", "E", "R", "e", "I", "X", "i", "o", "O", "U", "u", "b", "C", "d", "D", "F", "L", "M", "N", "f", "g", "h", "J", "k", "l", "m", "n", "G", "p", "Q", "r", "s", "S", "t", "T", "v", "w", "H", "y", "z", "Z")
clARPA <- c("AA", "AE", "AH", "AO", "AW", "AX", "AY", "EH", "ER", "EY", "IH", "IX", "IY", "OW", "OY", "UH", "UW", "B", "CH", "D", "DH", "DX", "EL", "EM", "EN", "F", "G", "H", "JH", "K", "L", "M", "N", "NG", "P", "Q", "R", "S", "SH", "T", "TH", "V", "W", "WH", "J", "Z", "ZH")
lcARPA <- tolower(clARPA)

# Current stress kludge 

stress1 <- c("AA1", "AE1", "AH1", "AO1", "AW1", "AX1", "AY1", "EH1", "ER1", "EY1", "IH1", "IX1", "IY1", "OW1", "OY1", "UH1", "UW1")
stress1b <- tolower(stress1)
stress2 <- c("AA2", "AE2", "AH2", "AO2", "AW2", "AX2", "AY2", "EH2", "ER2", "EY2", "IH2", "IX2", "IY2", "OW2", "OY2", "UH2", "UW2")
stress2b <- tolower(stress2)
stress0 <- c("AA0", "AE0", "AH0", "AO0", "AW0", "AX0", "AY0", "EH0", "ER0", "EY0", "IH0", "IX0", "IY0", "OW0", "OY0", "UH0", "UW0")
stress0b <- tolower(stress0)

## TODO: Change stress handling to be regex-based

weirds <- c("AXR", "UX", "HH", "NX", "ENG")
loweirds <- tolower(weirds)
weIPA <- c("\u025A", "\u0289", "h", "\u027E\u0303", "\u014B\u030D")
unIPA <- c("\u0061", "\u00E6", "\u0250", "\u0254", "a\u028A", "\u0259", "a\u026A", "\u025B", "\u025d", "e\u026A", "\u026A", "\u0268", "i", "o\u028A", "\u0254\u026A", "\u028A", "u", "b", "\u02A7", "d", "\u00F0", "\u027E", "l\u0329", "m\u0329", "n\u0329", "f", "g", "h", "\u02A4", "k", "l", "m", "n", "\u014B", "p", "\u0294", "\u0279", "s", "\u0283", "t", "\u03B8", "v", "w", "\u028D", "y", "z", "\u0292")
vowIPA <- c("\u0061", "\u00E6", "\u0250", "\u0254", "a\u028A", "\u0259", "a\u026A", "\u025B", "\u025D", "e\u026A", "\u026A", "\u0268", "i", "o\u028A", "\u0254\u026A", "\u028A", "u")

arM <- data.table::data.table(
  ar = mARPA,
  ip = unIPA
)
data.table::setkey(arM, ar)

arC <- data.table::data.table(
  ar = clARPA,
  ip = unIPA
)
data.table::setkey(arC, ar)

arL <- data.table::data.table(
  ar = lcARPA,
  ip = unIPA
)
data.table::setkey(arL, ar)

alt1 <- data.table::data.table(
  ar = stress1,
  ip = vowIPA
)
data.table::setkey(alt1, ar)

alt2 <- data.table::data.table(
  ar = stress1b,
  ip = vowIPA
)
data.table::setkey(alt2, ar)

alt3 <- data.table(
  ar = stress2,
  ip = vowIPA
)
data.table::setkey(alt3, ar)

alt4 <- data.table::data.table(
  ar = stress2b,
  ip = vowIPA
)
data.table::setkey(alt4, ar)

alt5 <- data.table::data.table(
  ar = stress0,
  ip = vowIPA
)
data.table::setkey(alt5, ar)

alt6 <- data.table::data.table(
  ar = stress0b,
  ip = vowIPA
)
data.table::setkey(alt6, ar)

weird <- data.table::data.table(
  ar = weirds,
  ip = weIPA
)
data.table::setkey(weird, ar)

loweird <- data.table::data.table(
  ar = loweirds,
  ip = weIPA
)
data.table::setkey(loweird, ar)

#the actual translation heavy lifting happens here
#' Title
#'
#' @param dt 
#'
#' @return
#' @export
#'
#' @examples
makAR <- \(dt) {
  dt <- arM[dt]
  dt[is.na(ip), ip := arM[.(.SD), ip]]
  dt[is.na(ip), ip := arC[.(.SD), ip]]
  dt[is.na(ip), ip := arL[.(.SD), ip]]
  dt[is.na(ip), ip := alt1[.(.SD), ip]]
  dt[is.na(ip), ip := alt2[.(.SD), ip]]
  dt[is.na(ip), ip := alt3[.(.SD), ip]]
  dt[is.na(ip), ip := alt4[.(.SD), ip]]
  dt[is.na(ip), ip := alt5[.(.SD), ip]]
  dt[is.na(ip), ip := alt6[.(.SD), ip]]
  dt[is.na(ip), ip := weird[.(.SD), ip]]
  dt[is.na(ip), ip := loweird[.(.SD), ip]]
  dt
}