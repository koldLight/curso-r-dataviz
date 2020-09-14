library(shiny)
library(palmerpenguins)
library(plotly)

# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("Distribución de las propiedades de los pingüinos"),
  
  # Un panel que tiene una zona más pequeña en el lateral izquierdo,
  # y un panel principal más grande a la derecha
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo select sobre una lista de opciones
      selectInput(
        inputId = "property",
        label   = "Propiedad",
        choices = list("Longitud del pico"    = "bill_length_mm",
                       "Profundidad del pico" = "bill_depth_mm",
                       "Longitud de la aleta" = "flipper_length_mm",
                       "Peso"                 = "body_mass_g")
      )
      
    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      # El histograma
      plotlyOutput(outputId = "histogram")
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # Genera el histograma sobre la propiedad seleccionada
  output$histogram <- renderPlotly({
    plot_ly(penguins, x = ~get(input$property), type = "histogram", nbinsx = input$bins) %>%
      layout(xaxis = list(title = "Propiedad"))
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
