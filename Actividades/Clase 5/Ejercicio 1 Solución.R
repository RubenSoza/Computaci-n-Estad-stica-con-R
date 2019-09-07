#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30),
         textInput("texto", "Ingrese su texto aqui", 
                   value = "Texto")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"), textOutput("textOut"),
         textOutput("textOut2"), textOutput("textOut3")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', 
           border = 'white', main = input$texto)
   })
   
   output$textOut <- renderText({
     input$texto
   })
   
   output$textOut2 <- renderText({
     paste("El número de bins es ", input$bins)
   })
   
   output$textOut3 <- renderText({
     paste("El título del gráfico es ", input$texto,
           " y el número de bins del histograma es", input$bins)
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

