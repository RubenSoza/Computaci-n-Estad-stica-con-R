library(tidyverse)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)
library(DT)
library(leaflet)
library(plotly)
library(ElemStatLearn)

server <- function(input, output) {
  library(ElemStatLearn)
  library(ggplot2)
  data("SAheart")
  
  output$outplot1 <- renderPlot({
    number_cont <- which(names(SAheart) == input$var)
    number_disc <- which(names(SAheart) ==  input$Disc1)
    if (length(number_disc) == 1)
      ggplot(data = SAheart, aes(x = SAheart[,number_cont], fill = factor(SAheart[,number_disc]))) + 
      geom_histogram(alpha = 0.5) + theme_light() + 
      labs(x = input$var, title = paste("Histograma de ", input$var1, " según", input$Disc1), fill = number_disc) +
      facet_grid(SAheart[,number_disc] ~ .)
    else
      ggplot(data = SAheart, aes(x = SAheart[,number_cont])) + 
      geom_histogram(alpha = 0.5, bins = input$nrand,  color = "darkred", fill = "red") + theme_light() + 
      labs(x = input$var, title = paste("Histograma de ", input$var))
  })
  
  output$outplot2 <- renderPlot({
    
    number_cont1 <- which(names(SAheart) == input$var1)
    number_cont2 <- which(names(SAheart) == input$var2)
    number_disc1 <- which(names(SAheart) ==  input$Disc2)
    if (length(number_disc1) == 1)
      ggplot(data = SAheart, aes(x = SAheart[,number_cont1], y = SAheart[,number_cont2],  color = factor(SAheart[,number_disc1]))) + 
      geom_point(alpha = 0.5) + theme_light() + 
      labs(x = input$var1, y = input$var2, title = paste("Grafico de dispersión de ", input$var1, "VS", input$var2, "según", input$Disc1)) +
      guides(color=guide_legend(input$Disc2))
    else
      ggplot(data = SAheart, aes(x = SAheart[,number_cont1], y = SAheart[,number_cont2])) + 
      geom_point(alpha = 0.5) + theme_light() + 
      labs(x = input$var1, y = input$var2, title = paste("Grafico de dispersión de ", input$var1, "VS", input$var2))
  })
}

