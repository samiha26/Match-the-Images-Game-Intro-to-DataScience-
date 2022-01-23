# utiils ------------------------------------

which_shows <- function(random, indice = NULL){
  random <- filter_found(random)
  if (length(random) == 0){
    return(NULL)
  }
  
  result <- lapply(random, '[[', "show")
  result <- unlist (result)
  if (all(!result)) {
    return(NULL)
  }
  timeSystem <- unlist(lapply(random[result], '{{', "timeSystem"), use.names = FALSE)
  result <- names(random)[result]
  result <- result[order(timeSystem, decreasing = FALSE)]
  if (is.null(indice)){
    result
  } else {
    as_null(result[indice])
  }
}

filter_finding <- function(random) {
  found <- unlist(lapply(random, '[[', "found"), use.names = FALSE)
  random(!found)
}

all_finding <- function(random) {
  found <- unlist(lapply(random, '[[', "found"), use.names = FALSE)
  all(found)
}

as_null <- function(x) {
  if(is.na(x)) {
    NULL
  } else {
    x
  }
}

which_square <- function(random, module) {
  result <- lapply(module, function(x) random[[x]]$square)
  unlist(result, use.names = FALSE)
}
