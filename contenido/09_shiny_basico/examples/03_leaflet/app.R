library(shiny)
library(leaflet)

# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("Mapas base de leaflet"),
  
  # Un panel que tiene una zona más pequeña en el lateral izquierdo,
  # y un panel principal más grande a la derecha
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo select sobre una lista de opciones, para los mapas base
      selectizeInput(
        inputId = "provider_name",
        label   = "Tile",
        choices = names(providers)
      )
      
    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      # El histograma
      leafletOutput(outputId = "map")
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # Genera el mapa con el proveedor de tiles seleccionado
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(input$provider_name) %>%
      setView(lng = -3.69, lat = 40.43, zoom = 6)
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
