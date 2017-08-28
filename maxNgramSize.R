maxNgramSize <- function(){
    
    maxVector <- c()
    
    for (type in c("b", "n", "t")) {
        model <- paste(type, "_model", sep="")
        ptList <- sort(names(get(model)), decreasing=TRUE)
        mns <- as.integer(substr(ptList[1], 3, 3))
        maxVector <- c(maxVector, mns)
    }
    return(max(maxVector))
}
