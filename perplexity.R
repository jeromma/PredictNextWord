logProb <- function(context) {
#
# logProb() uses stupid backoff to calculate the log of the probability of a word given 
# the input context.  It has dependencies on perplexity() and is written to be called
# only from that funtion.
#   Input: Vector of words
#   Output: Log of the probability of the last word in the input conditioned on the other
#       words in the input
#   Parameters:
#       context - vector of words
#   Notes: the following variables are in perplexity()'s environment
#       history, model$counts, trainSize
#
    size <- length(context)
    limit <- min(size, history)

    for (k in 1:(limit-1)) {
        phrase <- paste(context[k:limit], collapse=" ")
        phraseInList <- !is.na(model$counts[phrase])

        key <- paste(context[k:(limit-1)], collapse=" ")
        keyInList <- !is.na(model$counts[key])
        
        if (phraseInList && keyInList) return(log(model$counts[phrase]/model$counts[key]))
    }
    
    phrase <- context[limit]
    wordInList <- !is.na(model$counts[phrase])
    
    if (wordInList) return(log(model$counts[phrase]/trainSize))
    else return(log(1/trainSize))
}

perplexity <- function(example, model=NULL) {
#
# perplexity() calculates the perplexity of the input text based on the input model
#   Input: text and next word model
#   Output: Perplexity of the input text
#   Parameters:
#       example - a character string that can be split into words
#       model - next word model
#
    message(Sys.time(), " perplexity start")
    environment(logProb) <- environment()

    history <- model$maxSize
    trainSize <- model$trainSize

    words <- strsplit(example, split=" ")[[1]]
    exampleSize <- length(words)

    cumLogProb <- 0
    
    if (exampleSize <= history) {
        
        for (i in 1:exampleSize) {
            cumLogProb <- cumLogProb + logProb(words[1:i])
        }
        
    } else {

        for (i in 1:history) {
            cumLogProb <- cumLogProb + logProb(words[1:i])
        }

        for (i in 1:(exampleSize-history)) {
            x <- logProb(words[(i+1):(history+i)])
            if (is.na(x)) message("i = ", i)
            cumLogProb <- cumLogProb + logProb(words[(i+1):(history+i)])
        }
    }

    perplexity <- exp(cumLogProb * (-1/exampleSize))
    message(Sys.time(), " perplexity end")
    return(perplexity)
}