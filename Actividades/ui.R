library(tidyverse)
library(shiny)
library(shinythemes)
library(shinyWidgets)
library(shinydashboard)
library(DT)
library(leaflet)
library(plotly)
library(ElemStatLearn)


ui <- fluidPage(theme = shinytheme("united"),  titlePanel("SAheart dataset summary"),
                sidebarLayout(
                  sidebarPanel(
                    sliderInput("nrand", "Numero de Intervalos",
                                min = 2, max = 20, value = 12),
                    selectInput("var","Variable continua", choices = c("sbp","tobacco","ldl","adiposity","typea",
                                                                       "obesity", "alcohol","age","chd"), selected = "sbp"
                                ),
                    selectInput("Disc1","Variable discreta", 
                                choices = c("Ninguno","famhist","chd"), 
                                selected = "Ninguno")),
                  mainPanel(plotOutput("outplot1"))
                
),
sidebarLayout(
  sidebarPanel(
    selectInput("var1","Variable continua 1", choices = c("sbp","tobacco","ldl","adiposity","typea",
                                                       "obesity", "alcohol","age","chd"), selected = "sbp"
    ),
    selectInput("var2","Variable continua 2", choices = c("sbp","tobacco","ldl","adiposity","typea",
                                                         "obesity", "alcohol","age","chd"), selected = "tobacco"
    ),
    selectInput("Disc2","Variable discreta", 
                choices = c("Ninguno","famhist","chd"), 
                selected = "Ninguno")),
  mainPanel(plotOutput("outplot2"))
))
