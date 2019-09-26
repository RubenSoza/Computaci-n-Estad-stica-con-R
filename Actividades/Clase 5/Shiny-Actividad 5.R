library(plotly)
library(shiny)
library(tidyverse)
library(DT)
library(readxl)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "categoría", label = "Seleccione la categoría", 
                choices = c("ARTE Y DISEÑO", "BELLEZA", "CASA Y HOGAR",
                           "CLIMA", "COMIDA Y BEBIDA", "COMPRAS",
                           "COMUNICACIÓN", "DATOS", "DEPORTES",
                           "EDUCACIÓN", "ENTRETENIMIENTO", "ESTILO DE VIDA",
                           "EVENTOS", "FAMILIA", "FINANCIERAS",     
                           "FOTOGRAFÍA", "HERRAMIENTAS", "HISTORIETAS", 
                           "JUEGO", "LIBRERIAS", "LIBROS Y REFRERENCIAS",
                           "MAPAS Y NAVEGACIÓN", "MÉDICO", "NEGOCIO", 
                           "NOTICIAS", "PADRES", "PERSONALIZACIÓN",
                           "PRODUCTIVIDAD", "REPRODUCTORES DE VIDEO", 
                           "SALUD Y BELLEZA","SOCIAL", 
                           "VEHICULOS", "VIAJES")),
      textInput(inputId = "titulo", label = "Título del gráfico", 
              value = "Escriba el título del gráfico"),
      sliderInput(inputId = "tamaño", label = "Seleccione el tamaño de los puntos", 
                value = 1, min = 1, max = 20),
      selectInput(inputId = "color", label = "Color de Puntos", 
                 choices = c("red","blue","green"))
    ),
    mainPanel(plotlyOutput("dispersion"), dataTableOutput("tabla"))
  )
)

server <- function(input,output){
  
  # Leemos la base de datos y la manipulamos para lograr lo pedido
  PlayStore <- read_excel("G:/Mi unidad/Universidad/Cursos/Computación Estadística con R/Datasets/PlayStore.xlsx")
  
  # Generamos los outputst
  output$tabla <- renderDataTable({
    PlayStore %>% 
      mutate(Descargas = str_remove_all(Descargas, "[,aprox.]")) %>%
      mutate(Descargas = as.numeric(Descargas)) %>% 
      dplyr::filter(Categoría == input$categoría) -> PlayStore_filtrada
    
    datatable(PlayStore_filtrada)
  })
  
  output$dispersion <- renderPlotly({
    PlayStore %>% 
      mutate(Descargas = str_remove_all(Descargas, "[,aprox.]")) %>%
      mutate(Descargas = as.numeric(Descargas)) %>% 
      dplyr::filter(Categoría == input$categoría) -> PlayStore_filtrada
    g <- ggplot(data = PlayStore_filtrada) + 
      geom_point(aes(x = Descargas, y = Comentarios), 
                 size = input$tamaño, col = input$color) +
      ggtitle(input$titulo) +
      theme_light()
    ggplotly(g)}
    )
}

shinyApp(ui = ui, server = server)


