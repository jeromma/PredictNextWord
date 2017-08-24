#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  shinyjs::hide("hideDetails")
  shinyjs::hide("details")
  
  output$prediction <- renderText({
    predictNextWord(input$textContent, type=input$textType)
  })
   
  output$maxNgramSize <- renderText({
    "This model uses a max ngram size of 3."
  })
  
  output$usedNgram <- renderPrint({
    "Current predictions chosen using ngrams of sizes: "
    c(3, 3, 2)
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
