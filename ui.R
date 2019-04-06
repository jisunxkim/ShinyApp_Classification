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
  titlePanel("Machine Learing: regression, seleting a learnig rate alpha"),
  setBackgroundImage(src = "background2.jpg"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            h3("Model Selection"),
            radioButtons("modelType", "Select a model", choices = c("k-means" = "km", "Mean-Shift Clustering" = "ms"), selected = "km"),
            checkboxInput("summaryText", "Summary of the result"),            
            h3("Select number of clusters"),
            sliderInput("NumberClusters", "Input cluster numbers", 2, 6, 3),
            actionButton("doButton", "Run the model!")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
            tabsetPanel(
                    tabPanel("Document",
                             h3("Data Set: mtcars"),
                     tags$p("Ready to take the Shiny tutorial? If so")),
                    tags$em("This is great!"),
                    tags$a(href = "https://www.google.com/", "click here"),
                    tabPanel("Prediction Result")
            )
    )
  )
))
