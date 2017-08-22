prepare <- function (fn, ngrams=c(2:4), inputLines=-1) {
#
# This function reads a text file, preprocesses it, extracts ngrams, and produces phrasetables.
#   Input: Text file to be used to train a model to predict the next word
#   Output: List of phrasetables corresponding to input ngram sizes
#   Parameters:
#     fn - name of text file to read and prepare
#     ngrams - vector of integer ngram sizes to extract
#     inputLines - number of lines to read from input file or -1 for all lines
#
  library("readr")
  library("ngram")
  
  result <- vector("list", length=0)
  
  if(!is.character(fn)){
    message("Parameter fn must be character string.")
    return(result)
  }
  
  if (!file.exists(fn)){
    message("File ", fn, " not found.")
    return(result)
  }
  
  message(Sys.time(), " ", fn, " ", "read_lines")
  txtlines <- read_lines(fn, n_max=inputLines)

  message(Sys.time(), " ",fn, " ", "concatenate")
  txtconc <- concatenate(txtlines)
  rm(txtlines)
    
  message(Sys.time(), " ",fn, " ", "iconv")
  txtclean <- iconv(txtconc, "latin1", sub="")
  rm(txtconc)

  message(Sys.time(), " ",fn, " ", "preprocess")
  txtpp <- preprocess(txtclean, remove.punct=TRUE)
  rm(txtclean)

  for (ngsize in ngrams) {

    message(Sys.time(), " ",fn, " ", "ngram", ngsize)
    nglist <- ngram(txtpp, n=ngsize)
    ptName <- paste("pt", ngsize, sep="")
    result[[ptName]] <- get.phrasetable(nglist)
    rm(nglist)
    
  }
  message(Sys.time(), " ",fn, " ", "end")
  message("")
  return(result)
}