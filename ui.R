#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Machine Learing: Classification"),
  setBackgroundImage(src = "background2.jpg"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            h3("Model Selection"),
            radioButtons("modelType", label =  "Select a model", choices = c("k-means" = "km", "Hierarchical Agglomerative" = "ha"), selected = "km"),
            checkboxInput("summaryText", label = "Summary of the result"),            
            h3("Select number of clusters"),
            sliderInput("NumberClusters", label = "Input cluster numbers", 2, 6, 3),
            actionButton("doButton", label = "Run the model!")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
            tabsetPanel(
                    tabPanel("Document",
                             h3("Introduction"),
                     tags$p("This shiny application classifies the 32 automobiles of 1973 to 74 models. The data source is from 1974 Motro Trend US magaine and available from R datasets. A user can chose either K-means or Hierarchical Agglomerative method for the unsupervised classification."),
                     tags$br(),
                     h3("Directions"),
                     h4("1. pick a method"),
                     h4("2. select number of class"),
                     h5("3. explore data summary, cluster result and cluster plot tabs for the results")),
                    tabPanel("Data Summary", verbatimTextOutput("dataSummary")),
                    tabPanel("Cluster Result Report",
                             verbatimTextOutput("report") ),
                    tabPanel("Cluster Plot",
                             plotOutput("plotting"))
            )
    )
  )
))
