extract <- function(phrase, type, n=3){
    
    words <- strsplit(phrase, split=" ")[[1]]
    
    prefix <- substr(type, 1, 1)
    model <- paste(prefix, "_model", sep="")
    
    ptables <- sort(names(get(model)), decreasing=TRUE)
    for (pt in ptables) {
        ngramSize <- as.integer(substr(pt, 3, 3))
        key <- paste(words[(n-(ngramSize-2)):n], sep=" ", collapse=" ")
        entry <- get(model)[[pt]][key]
        if (!is.na(names(entry)[1])) return(entry[[1]][1])
    }

    return("the")
}

predictNextWord <- function(inputPhrase, inputType="compare"){
    
    if (!(inputType %in% c("blog", "news", "twitter", "compare"))){
        return("Parameter error: inputType must be one of 'blog', 'news', 'twitter', or 'compare'.")
    }
    
    if (inputType=="compare") types <- c("blog", "news", "twitter")
    else types <- inputType
    
    phrase <- form(inputPhrase)

    resultString <- ""
    for (t in types){
        rs <- paste("Prediction for type '", t, "' is '", extract(phrase, t), "'.  ", sep="")
        resultString <- paste(resultString, rs, sep="")
    }
    return(resultString)
}