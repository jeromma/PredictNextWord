ctest <- function(phrase){
  words <- strsplit(phrase, " ")
  wordcount <- length(words[[1]])
  na3 <- rep(NA, 3)
  result <- data.frame(b_4=na3, b_3=na3, b_2=na3,
                       n_4=na3, n_3=na3, n_2=na3,
                       t_4=na3, t_3=na3, t_2=na3)
  testPhrase <- vector("character", length=3)
  for (i in 0:2){
    testPhrase <- paste(words[[1]][(wordcount-i):wordcount], collapse=" ")
    size <- i+2
    ngramSize <- paste("pt", size, sep="")
    b_col <- paste("b_", size, sep="")
    b1 <- b_model[[ngramSize]][testPhrase][[1]]
    result[b_col] <- c(b1, rep(NA, 3-length(b1)))

    n_col <- paste("n_", size, sep="")
    n1 <- n_model[[ngramSize]][testPhrase][[1]]
    result[n_col] <- c(n1, rep(NA, 3-length(n1)))
    
    t_col <- paste("t_", size, sep="")
    t1 <- t_model[[ngramSize]][testPhrase][[1]]
    result[t_col] <- c(t1, rep(NA, 3-length(t1)))
    
  }
  result
}