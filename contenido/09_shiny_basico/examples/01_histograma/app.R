library(shiny)
library(palmerpenguins)
library(ggplot2)

# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("Distribución del peso en los pingüinos"),
  
  # Un panel que tiene una zona más pequeña en el lateral izquierdo,
  # y un panel principal más grande a la derecha
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo slider, para seleccionar el número
      # de bins del histograma
      sliderInput(inputId = "bins",
                  label = "Número de bins:",
                  min = 1,
                  max = 50,
                  value = 25)
      
    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      # El histograma
      plotOutput(outputId = "histogram")
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # Genera el histograma con el número de bins seleccionado
  output$histogram <- renderPlot({
    ggplot(penguins, aes(x = body_mass_g)) +
      geom_histogram(bins = input$bins)
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
