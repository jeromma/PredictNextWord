library(ngram)

form <- function(inputPhrase, n=3) {
#
# Make sure the input phrase is well-formed
# (n words, standard encoding, all lower case, no punctuation)
#   Input: Input phrase to be formed
#   Output: Well-formed phrase
#   Parameters:
#      inputPhrase - character string
#      n - number of words in well-formed phrase
#   Dependencies: preprocess and wordcount from package ngram
#
    if (!(class(inputPhrase)=="character")) {
        return("Parameter error: class of inputPhrase must be character")
    }
    
    if (n <= 0) {
        return("Parameter error: value of n must be greater than zero")
    }
    
    cleanPhrase <- iconv(inputPhrase, "latin1", sub="")
    ppPhrase <- preprocess(cleanPhrase, remove.punct=TRUE)
    
    wc <- wordcount(ppPhrase)
    if (wc==n) return(ppPhrase)
    if (wc<n) dots <- paste(rep(".", n-wc), collapse=" ")
    if (wc==0) outputPhrase <- dots
    else if (wc<n) outputPhrase <- paste(dots, ppPhrase, sep=" ", collapse="")
    else {
        words <- strsplit(ppPhrase, " ")
        outputPhrase <- paste(words[[1]][(wc-n+1):wc], collapse=" ")
    }
    return(outputPhrase)
}

testForm <- function(n) {
    for (i in 0:(n+2)) {
        if (i==0) phrase <- ""
        else phrase <- paste(letters[1:i], collapse=" ")
        wfPhrase <- form(phrase, n=n)
        message(n, "/", i, "/", phrase, "/", wfPhrase)
    }
}