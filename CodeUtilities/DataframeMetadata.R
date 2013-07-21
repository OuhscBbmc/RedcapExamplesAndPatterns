ColumnRenameHeadstart <- function( df ) {
  cat(paste0(", \"", colnames(df), "\"", "=", "\"", colnames(df), "\"", "\n")) #Gives a headstart to plyr::rename
}
# ColumnRenameHeadstart(ds)

ColumnClassHeadstart <- function( df ) {
  for( i in seq_along(colnames(df)) ) {
    cat( ", \"", colnames(df)[i], "\" = \"", class(df[, i]), "\"\n", sep="")
  }
}
# ColumnClassHeadstart(ds)

ColumnClassHeadstart <- function( x ) {
  for( value in sort(unique(x)) ) {
    cat( ", \"", value, "\" = \"", value, "\"\n", sep="")
  }
}
# ColumnClassHeadstart(ds$Activity)
