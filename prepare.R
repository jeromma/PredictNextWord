prepare <- function (fn, ngrams=c(2:4), rmStopwords=TRUE, inputLines=-1) {
#
# This function reads a text file, preprocesses it, extracts ngrams, and produces phrasetables.
#   Input: Text file to be used to train a model to predict the next word
#   Output: Data frame with ngrams, frequency of ngram, and size of ngram
#   Parameters:
#     fn - name of text file to read and prepare
#     ngrams - vector of integer ngram sizes to extract
#     rmStopwords - logical indicating whether or not stopwords should be removed
#     inputLines - number of lines to read from input file or -1 for all lines
#
    library(ngram)

    words <- prep01(fn, rmStopwords)
    
    result <- prep02(words)
    
    return(result)
}