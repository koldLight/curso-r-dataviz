library(shiny)

# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("título"),
  
  # Panel con barra al lateral
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo texto, con ID input_text
      textInput(
        inputId = "input_text",
        label   = "Escribe algo"
      )
      
    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      # Output de tipo texto, con ID output_text
      textOutput(outputId = "output_text")
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # Genera el output output_text utilizando input_text
  output$output_text <- renderText({
    paste("El usuario ha escrito:", input$input_text)
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
