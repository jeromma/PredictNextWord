kv <- function(x){
#
# This function processes an ngram and returns a key value pair.
#   Input: Ngram, ususally an entry from an ngram phrasetable
#   Output: Key value pair, where key is first n-1 words of ngram and value is last word of ngram
#   Parameters:
#       x - ngram to be processed
#
#
# Find the location of the last word of the ngram.
#
    c <-regexpr("[^ ]*$", x)
#
# Return a vector with key as first element and value as second.
#
    c(substr(x, 1, c-2), substr(x, c, nchar(x)))
}


topChoices <- function(phrasetable, choices=1){
#
# This function uses an ngram data frame from prepare() to create a table of keys with associated
# choices.  The keys consist of the first n-1 words from each ngram in the data frame.
#   Input: Ngram data frame from prepare()
#   Output: Table of keys with associated choices
#   Parameters:
#       phrasetable - ngram data frame from prepare(
#       choices - how many choices to keep for each ngram key
#
    message(Sys.time(), " Creating key value pairs.")
    kvp <- sapply(phrasetable$ngrams, kv, USE.NAMES=FALSE)
    
    message(Sys.time(), " Pruning key value pairs.")
    stopwords <- c("a", "an", "the", 
                   "shit", "piss", "fuck", "cunt", "motherfucker", "cocksucker", "tits")
    deselect <- kvp[2,] %in% stopwords
    kvp <- kvp[, !deselect]
    
    message(Sys.time()," Creating table of top choices.")
    topchoices <- tapply(kvp[2,], kvp[1,], head, n=choices)
    
    message(Sys.time(), " Done")
    return(topchoices)
}

train <- function(ptlist, cutoff=1, counts=TRUE, pt=TRUE){
#       cutoff - keep phrasetable entries only if they occur more often than this value
    
    model <- vector("list", length=0)
    
    select <- ptlist$freq > cutoff
    ptlist <- ptlist[select,]
    
    if (counts) {
        counts <- ptlist$freq
        names(counts) <- ptlist$ngrams
        model[["counts"]] <- counts
    }
    
    model[["maxSize"]] <- max(ptlist$size)
    
    wordEntries <- ptlist$size==1
    
    model[["vocabulary"]] <- sum(wordEntries)
    
    model[["trainSize"]] <- sum(ptlist$freq[wordEntries])
    
    if (pt) model[["pt"]] <- topChoices(ptlist)

    return(model)
}