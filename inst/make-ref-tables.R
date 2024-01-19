mixed <- data.table::data.table(ar = mARPA, ip = unIPA)
upper <- data.table::data.table(ar = clARPA, ip = unIPA)
data.table::setnames(timit, new = c('ar', 'ip'))
data.table::fwrite(x = mixed, file = 'data/mixed.csv')
data.table::fwrite(x = upper[, ar := toupper(ar)], file = 'data/upper.csv')
data.table::fwrite(x = upper[, ar := tolower(ar)], file = 'data/lower.csv')
#data.table::fwrite(x = timit[, ar := toupper(ar)], file = 'data/timit.csv')
#data.table::fread(file = 'data/TIMIT.csv', encoding = 'UTF-8')


t <- wrapr::build_frame('ar', 'ip' |
                     'AXH','\u0259\u0325' |
                   'BCL','b\u031A' |
                   'DCL','d\u031A' |
                   'ENG','\u014B\u030D' |
                   'GCL','g\u031A' |
                   'KCL','k\u031A' |
                   'TCL','t\u031A' |
                   'PAU', NA |
                   'EPI', NA |
                   'H#', NA |
                   'AXR','\u025A' |
                   'UX','\u0289' |
                   'HH','h' |
                   'NX','\u027E\u0303'
)

data.table::fwrite(x = t, file = 'data/timit.csv')
