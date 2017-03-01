
############################################################
############################################################
#### Funções auxiliares

#' Função para circular shift em lista
#'
shifter <- function(x, n = 1) {
  if (n == 0) x else c(tail(x, -n), head(x, n))
}

############################################################
############################################################

#' Função para contar diferença de períodos no formato nnnn.n
#' 
diffPeriodo <- function(periodo1, periodo2){
  stopifnot(nchar(periodo1) == 6 && nchar(periodo2) == 6)
  
  per <- 2*(as.numeric(substr(periodo1,1,4) ) - as.numeric(substr(periodo2,1,4) )) +
    (as.numeric(substr(periodo1,6,6) ) - as.numeric(substr(periodo2,6,6) )) + 1
  
  return(per)
}
############################################################
############################################################

