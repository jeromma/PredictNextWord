#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    useShinyjs(),
    
    # Application title
    titlePanel("Predict next word"),
    
    helpText("Type into the box below.  The app will predict the next word."),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("textType",
                        "Type of text:",
                        c("blog", "news", "twitter", "compare")),
            textAreaInput("textContent",
                          "Type here:",
                          rows=5)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            wellPanel(
                h3("Predicted next word:"),
                textOutput("prediction")
            ),
            
            wellPanel(
                actionButton("showDetails",
                             "Show details"),
                
                actionButton("hideDetails",
                             "Hide details"),
                
                div(id="details",
                    h3("Maximum ngram size used in model"),
                    textOutput("maxNgramSize"),
                    h3("Input text as typed"),
                    textOutput("outputContent"),
                    h3("Well-formed input text"),
                    textOutput("formed"),
                    h3("Phrase tables"),
                    htmlOutput("phraseTables")
                )
                
            ))
    )
    
))
