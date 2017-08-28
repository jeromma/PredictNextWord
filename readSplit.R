readSplit <- function (fnIn, fnOutTrain, fnOutTest, split=.05, seed=92255) {
#
# This function reads a text file and splits it randomly into two output files: train and test.
#   Input: Text file to be split
#   Output: Train file and test file
#   Parameters:
#       fnIn - name of text file to be split
#       fnOutTrain - name of output train text file
#       fnOutTest - name of output test text file
#       split - fraction of input file to be written to train file; rest will go to test
#       seed - random seed for repeatability
#
    library("readr")
    
    set.seed(seed)
    
    txtlines <- read_lines(fnIn)
    
    inputLength <- length(txtlines)
    trainLength <- floor(split*inputLength)
    inTrain <- sort(sample(1:inputLength, trainLength))
    train <- txtlines[inTrain]
    test <- txtlines[-inTrain]
    
    writeLines(train, fnOutTrain)
    writeLines(test, fnOutTest)
}