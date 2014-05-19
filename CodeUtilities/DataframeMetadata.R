ColumnRenameHeadstart <- function( d ) {
  cat(paste0(", \"", colnames(d), "\"", " = ", "\"", colnames(d), "\"", "\n")) #Gives a headstart to plyr::rename
}
# ColumnRenameHeadstart(ds)

ColumnClassHeadstart <- function( d ) {
  for( i in seq_along(colnames(d)) ) {
    cat( ", \"", colnames(d)[i], "\" = \"", class(d[, i]), "\"\n", sep="")
  }
}
# ColumnClassHeadstart(ds)

ColumnValueHeadstart <- function( x ) {
  for( value in sort(unique(x)) ) {
    cat( ", \"", value, "\" = \"", value, "\"\n", sep="")
  }
}
# ColumnClassHeadstart(ds$Activity)
