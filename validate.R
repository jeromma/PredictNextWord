validate <- function(trainFN, validateFN, rmswList=c(TRUE, FALSE), fractions=c(.2, .4, .6)) {
    
    source("prep01.R")
    source("prep02.R")
    source("train.R")
    source("perplexity.R")
    
    resultDF <- data.frame(size=integer(), rmsw=logical(), pp=numeric())
    
    for (rmsw in rmswList) {
        
        validateWords <- prep01(validateFN, rmStopwords=rmsw)[1:1000]
        example <- paste(validateWords, collapse=" ")
        
        message(Sys.time(), " validate rmsw = ", rmsw)
        trainWords <- prep01(trainFN, rmStopwords=rmsw)
        trainLength <- length(trainWords)
        for (size in fractions) {
            
            message(Sys.time(), " validate size = ", size)
            trainSubset <- trainWords[1:( floor(size*trainLength) )]
            ngramDF <- prep02(trainSubset)
            model <- train(ngramDF, counts=TRUE, pt=FALSE)
            pp <- perplexity(example, model)
            resultDF <- rbind(resultDF, data.frame(size=size, rmsw=rmsw, pp=pp))
            rownames(resultDF) <- c()
            
            message(Sys.time(), " validate pp = ", pp)
            message(" ")
        }
    }
    return(resultDF)
}