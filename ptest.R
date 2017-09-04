ptest <- function(fn, model, rmStopwords=TRUE) {

    txtsplit <- prep01(fn, rmStopwords)
    
    for (i in c(1000)) {
        example <- paste(txtsplit[1:i], collapse=" ")
        x <- perplexity(example, model)
        message(Sys.time(), " ", fn, " ", i, " perplexity = ", x)
    }
}