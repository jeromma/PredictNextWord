prep02 <- function (words, ngrams=c(2:4)) {
#
# This function takes a vector of words and extracts ngrams and produces phrasetables.
#   Input: Vector words to be used to train a model to predict the next word
#   Output: Data frame with ngrams, frequency of ngram, and size of ngram
#   Parameters:
#     words - vector of words to process
#     ngrams - vector of integer ngram sizes to extract
#
    library(ngram)
    
    fn <- "trainSubset"

    message(Sys.time(), " ",fn, " ", "Initialize data frame with word counts")
    result <- as.data.frame(table(words), stringsAsFactors=FALSE)
    names(result) <- c("ngrams", "freq")
    result <- cbind(result, size=1)

    txtForNgrams <- concatenate(words)
    
    for (ngsize in ngrams) {
        
        message(Sys.time(), " ",fn, " ", "ngram", ngsize)
        nglist <- ngram(txtForNgrams, n=ngsize)
        pt <- get.phrasetable(nglist)[c("ngrams", "freq")]
        pt$ngrams <- sapply(pt$ngrams, function(x) sub(" $", "", x))
        pt <- cbind(pt, size=ngsize)
        result <- rbind(result, pt)
        rm(nglist, pt)
        
    }
    message(Sys.time(), " ",fn, " ", "end")
    message("")
    return(result)
}