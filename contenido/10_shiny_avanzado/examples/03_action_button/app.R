library(shiny)
library(palmerpenguins)
library(dplyr)
library(ggplot2)

# Extraigo todas las especies y sexos (distintos de NA) para los select
all_species <- unique(penguins$species)
all_sexes  <- unique(penguins[!is.na(penguins$sex), ]$sex)

# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("Ejemplo con botón"),
  
  # Un panel que tiene una zona más pequeña en el lateral izquierdo,
  # y un panel principal más grande a la derecha
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo select para la especie
      selectInput(inputId = "especie",
                  label   = h3("Especie"),
                  choices = all_species),

      # Input de tipo select para el sexo
      selectInput(inputId = "sexo",
                  label   = h3("Sexo"),
                  choices = all_sexes),
      
      actionButton(inputId = "actualizar", label = "Actualizar")
      
    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      plotOutput("histograma"),
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # El output serie contiene toda la serie
  output$histograma <- renderPlot({
    
    # Utilizamos input$calcular (el botón) como dependencia, para que se
    # recalcule al hacer click (fuera de isolate!)
    input$actualizar
    
    # El resto de las dependencias (valores de entrada) las metemos dentro de una expresión
    # de isolate. Con isolate evitamos que se dispare automáticamente la evaluación.
    datos_filtrados <- isolate({
      filter(penguins, species == input$especie, sex == input$sexo)
    })
    
    ggplot(datos_filtrados, aes(x = body_mass_g)) +
      geom_histogram(bins = 20)
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
