kv <- function(x){
#
# This function processes an ngram and returns a key value pair.
#   Input: Ngram, ususally an entry from an ngram phrasetable
#   Output: Key value pair, where key is first n-1 words of ngram and value is last word of ngram
#   Parameters:
#     x - ngram to be processed
#
# If there is a space at the end of the ngram, remove it.
#
  x <- sub(" $", "", x)
#
# Find the location of the last word of the ngram.
#
  c <-regexpr("[^ ]*$", x)
#
# Return a vector with key as first element and value as second.
#
  c(substr(x, 1, c-2), substr(x, c, nchar(x)))
}

trainOne <- function(phrasetable, cutoff=1, choices=3){
  message(Sys.time(), " Shortening phrasetable")
  select <- phrasetable$freq > cutoff
  smallpt <- phrasetable[select,]
  
  message(Sys.time(), " Creating key value pairs.")
  kvp <- sapply(smallpt$ngrams, kv, USE.NAMES=FALSE)
  
  message(Sys.time(), " Pruning key value pairs.")
  stopwords <- c("the", "a", "an",
                 "shit", "piss", "fuck", "cunt", "motherfucker", "cocksucker", "tits")
  deselect <- kvp[2,] %in% stopwords
  kvp <- kvp[, !deselect]
  
  message(Sys.time()," Creating table of top choices.")
  topchoices <- tapply(kvp[2,], kvp[1,], head, n=choices)

  message(Sys.time(), " Done")
  return(topchoices)
}

trainAll <- function(ptlist){
  models <- vector("list", length=0)
  
  for (pt in names(ptlist)){
    message(Sys.time(), " ** ", pt, " **")
    models[[pt]] <- trainOne(ptlist[[pt]])
  }
  return(models)
}