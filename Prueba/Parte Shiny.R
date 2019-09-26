###################
## Instrucciones ##
###################

# Complete los espacios en "..." para que la app shiny funcione #

library(shiny)
library(gapminder)
library(plotly)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      "..."("..."), # Título ingresado por usuario
      numericInput("size", "Point size", 1, 1),
      checkboxInput("...", "...", FALSE),
      colourInput("color", "Point color", value = "blue"),
      "..."("continents", "Continents",
                  choices = levels(gapminder$continent),
                  multiple = TRUE,
                  selected = "Europe"),
      "..."("years", "Years",
                  min(gapminder$year), max(gapminder$year),
                  value = c(1977, 2002))
    ),
    mainPanel(
      "..."("plot"), dataTableOutput("...") # Utilizar plotly
    )
  )
)

# Define the server logic
server <- function(input, output) {
  data("gapminder")
  output$plot <- "..."({
    ggplotly({
      data <- subset(gapminder,
                     continent %in% input$continents &
                       year >= input$years[1] & year <= "..."$years[2])
      
      p <- ggplot(data, aes(gdpPercap, lifeExp)) +
        geom_point(size = input$"...", col = input$"...") +
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
                   continent %in% input$"..." &
                     year >= input$years[1] & year <= input$years[2])
    datatable(data, filter = "top")
  })
  
}

shinyApp(ui = ui, server = server)