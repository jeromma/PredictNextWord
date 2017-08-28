#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

source("predictNextWord.R", local=TRUE)
source("form.R", local=TRUE)
source("maxNgramSize.R", local=TRUE)
source("ctest.R", local=TRUE)

load("all3models")

library(shiny)
library(shinyjs)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  shinyjs::hide("hideDetails")
  shinyjs::hide("details")
  
  output$prediction <- renderText({
    predictNextWord(input$textContent, inputType=input$textType)
  })
   
  output$maxNgramSize <- renderText({
    paste("This model uses a max ngram size of", maxNgramSize(), ".", sep=" ")
  })
  
  output$outputContent <- renderPrint({
      paste("'", format(input$textContent), "'", sep="")
  })
  
  output$formed <- renderPrint({
      paste("'", form(input$textContent), "'", sep="")
  })
  
  output$phraseTables <- renderTable({
      ctest(form(input$textContent))
  })
  
  observeEvent(input$showDetails, {
    shinyjs::show("details")
    shinyjs::hide("showDetails")
    shinyjs::show("hideDetails")
  })
  
  observeEvent(input$hideDetails, {
    shinyjs::hide("details")
    shinyjs::hide("hideDetails")
    shinyjs::show("showDetails")
  })

})
