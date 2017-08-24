extract <- function(phrase, type){

  prefix <- substr(type, 1, 1)
  model <- paste(prefix, "_model", sep="")

  item <- get(model)[["pt4"]][phrase][[1]][1]
  if (!is.na(item)) return(item)

  item <- get(model)[["pt3"]][phrase][[1]][1]
  if (!is.na(item)) return(item)

  item <- get(model)[["pt2"]][phrase][[1]][1]
  if (!is.na(item)) return(item)

  return("the")
}

predictNextWord <- function(phrase, type="compare"){

  if (!(type %in% c("blog", "news", "twitter", "compare"))){
    message('Parameter type must be one of "blog", "news", "twitter", or "compare".')
    return("error")
  }

  if (type=="compare"){
    types <- c("blog", "news", "twitter")
  }else{
    types <- c(type)
  }

  resultString <- ""
  for (t in types){
    rs <- paste("Prediction for type '", t, "' is '", extract(phrase, t), "'.  ", sep="")
    resultString <- paste(resultString, rs, sep="")
  }
  return(resultString)
}