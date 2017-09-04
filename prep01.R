prep01 <- function (fn, rmStopwords=TRUE, inputLines=-1) {
#
# This function reads a text file and preprocesses it.
#   Input: Text file to be used to train, validate, or test a model to predict the next word
#   Output: Vector of words
#   Parameters:
#     fn - name of text file to read and prepare
#     rmStopwords - logical indicating whether or not stopwords should be removed
#     inputLines - number of lines to read from input file or -1 for all lines
#
    library(readr)
    library(ngram)

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
    
    words <- strsplit(txtpp, split=" ")[[1]]
    if (rmStopwords) {
        message(Sys.time(), " ",fn, " ", "remove stopwords")
        message("*** Wordcount before: ", format(length(words), big.mark=","))
        stopwords <- c("the", "a", "an")
        keep <- !(words %in% stopwords)
        words <- words[keep]
        message("*** Wordcount after: ", format(length(words), big.mark=","))
        rm(keep)
    }
    rm(txtpp)
    return(words)
}