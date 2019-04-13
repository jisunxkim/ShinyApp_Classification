#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



library(shiny)
library(datasets)
library(ggplot2)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
        observeEvent(input$doButton, 
                {       
                        output$dataSummary <- renderPrint({
                                summary(mtcars)
                        })
                        
                        n_cluster <- input$NumberClusters

                       if (input$modelType == "km") {
                               set.seed(100)
                                km_result <- kmeans(mtcars, centers = n_cluster, iter.max = 100)
                                
                                cluster_result <- cbind(mtcars, cluster = km_result$cluster)
                                cluster_doc <- km_result
                                
                                output$plotting <- renderPlot({
                                        ggplot(data = cluster_result, aes(x = mpg, y = hp, colour = as.factor(cluster))) + 
                                                geom_point(size = 4, alpha = 0.3) +
                                                labs(title =" MPG vs HP by Cluster", y ="HP", x ="MPG", colour = "cluster number", caption ="Data Source: R mtcars")
                                })                                
                                

                       }
                        
                        else if (input$modelType == "ha") {
                                set.seed(100)
                                distance <- dist(mtcars, method = "euclidean") # distance matrix
                                fit <- hclust(distance, method = "ward.D2") 
                                groups <- cutree(fit, k = n_cluster) # cut tree into 5 clusters
                                # draw dendogram with red borders around the 5 clusters 
                                cluster_doc <- list(fit, cluster = groups)                                                            
                                output$plotting <- renderPlot({
                                        plot(fit)
                                        rect.hclust(fit, k = n_cluster, borde = "red")
                                })
                                

        
                        }
 
        
        
                        if (input$summaryText == 1) {
                                output$report <- renderPrint({
                                        print(cluster_doc)
                                })
                        }
                        else output$report <- renderText({
                                "Summary is not selected"
                        })
                        
                      
                }
        )

})
