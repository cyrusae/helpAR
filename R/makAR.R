arM <- data.table::fread(file = 'data/mixed.csv') 
data.table::setkey(arM, ar)
### Import mixed-case single-character ARPAbet 

arL <- data.table::fread(file = 'data/lower.csv')
data.table::setkey(arL, ar)
### Import lowercase ARPAbet

arC <- data.table::fread(file = 'data/upper.csv')
data.table::setkey(arC, ar)
### Import uppercase ARPAbet 

tim <- data.table::fread(file = 'data/TIMIT.csv')
data.table::setkey(tim, ar)
### Import TIMIT interpretation 

# Internal helper function: take in working table, check it against ARPAbet dictionaries
## Assume TIMIT interpretation is included
### TODO: Consider allowing users to toggle TIMIT 

## This is going to want the regex filtering to have already happened
makAR <- function(dt
                  #, timit = TRUE
                  ) {
  dt <- arM[dt]
  dt[is.na(ip), ip := arM[.(.SD), ip]]
  dt[is.na(ip), ip := arC[.(.SD), ip]]
  dt[is.na(ip), ip := arL[.(.SD), ip]]
#  if (timit = TRUE) { 
    dt[is.na(ip), ip := tim[.(.SD), ip]] 
#    }
  dt 
}