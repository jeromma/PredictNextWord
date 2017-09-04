ptest <- function(fn, model, rmStopwords=TRUE) {
    library(readr)
    library(ngram)

    message(Sys.time(), " ", fn, " ", "read_lines")
    txtlines <- read_lines(fn)

    message(Sys.time(), " ",fn, " ", "concatenate")
    txtconc <- concatenate(txtlines)
    rm(txtlines)
    
    message(Sys.time(), " ",fn, " ", "iconv")
    txtclean <- iconv(txtconc, "latin1", sub="")
    rm(txtconc)
    
    message(Sys.time(), " ",fn, " ", "preprocess")
    txtpp <- preprocess(txtclean, remove.punct=TRUE)
    rm(txtclean)
    
    txtsplit <- strsplit(txtpp, split=" ")[[1]]
    if (rmStopwords) {
        message(Sys.time(), " ",fn, " ", "remove stopwords")
        message("*** Wordcount before: ", format(length(txtsplit), big.mark=","))
        stopwords <- c("the", "a", "an")
        keep <- !(txtsplit %in% stopwords)
        txtsplit <- txtsplit[keep]
        message("*** Wordcount after: ", format(length(txtsplit), big.mark=","))
        rm(keep)
    }
    rm(txtpp)
    
#    for (i in c(1000)) {
#        example <- paste(txtsplit[1:i], collapse=" ")
        i <- 174
        example <- paste(txtsplit[170:180], collapse=" ")
        message(paste(example, collapse=" "))
        x <- perplexity(example, model)
        message(Sys.time(), " ", fn, " ", i, " perplexity = ", x)
#    }
}