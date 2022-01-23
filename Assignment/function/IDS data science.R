# utiils ------------------------------------

which_show <- function(l, indice = NULL){
  l <- filter_found(l)
  if (length(l) == 0){
    return(NULL)
  }
  
  res <- lapply(l, `[[`, "show")
  res <- unlist (res)
  if (all(!res)) {
    return(NULL)
  }
  timeSystem <- unlist(lapply(l[res], `[[`, "timeSystem"), use.names = FALSE)
  res <- names(l)[res]
  res <- res[order(timeSystem, decreasing = FALSE)]
  if (is.null(indice)){
    res
  } else {
    as_null(res[indice])
  }
}

filter_found <- function(l) {
  found <- unlist(lapply(l, `[[`, "found"), use.names = FALSE)
  l[!found]
}

all_found <- function(l) {
  found <- unlist(lapply(l, `[[`, "found"), use.names = FALSE)
  all(found)
}

as_null <- function(x) {
  if(is.na(x)) {
    NULL
  } else {
    x
  }
}

which_square <- function(l, module) {
  res <- lapply(module, function(x) l[[x]]$square)
  unlist(res, use.names = FALSE)
}
