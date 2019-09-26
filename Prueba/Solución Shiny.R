###################
## Instrucciones ##
###################

# Complete los espacios en "..." para que la app shiny funcione #

library(shiny)
library(plotly)
library(DT)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("title", "Title", "GDP vs life exp"),
      numericInput("size", "Point size", 1, 1),
      checkboxInput("fit", "Add line of best fit", FALSE),
      colourInput("color", "Point color", value = "blue"),
      selectInput("continents", "Continents",
                  choices = levels(gapminder$continent),
                  multiple = TRUE,
                  selected = "Europe"),
      sliderInput("years", "Years",
                  min(gapminder$year), max(gapminder$year),
                  value = c(1977, 2002))
    ),
    mainPanel(
      plotlyOutput("plot"), dataTableOutput("table")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  data("gapminder")
  output$plot <- renderPlotly({
    ggplotly({
      data <- subset(gapminder,
                     continent %in% input$continents &
                       year >= input$years[1] & year <= input$years[2])
      
      p <- ggplot(data, aes(gdpPercap, lifeExp)) +
        geom_point(size = input$size, col = input$color) +
        scale_x_log10() +
        ggtitle(input$title)
      
      if (input$fit) {
        p <- p + geom_smooth(method = "lm")
      }
      p
    })
  })
  output$table <- renderDataTable({
    data <- subset(gapminder,
                   continent %in% input$continents &
                     year >= input$years[1] & year <= input$years[2])
    datatable(data, filter = "top")})
}

shinyApp(ui = ui, server = server)