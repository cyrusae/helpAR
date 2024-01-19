t <- file.choose()
test <- data.table::fread(file = t)
keep <- subset(test, select = c('following_phone', 'previous_phone', 'phone_label'))
keep1 <- wrapr::uniques(keep)
data.table::fwrite(x = keep1, file = 'data/test_dne.csv')

