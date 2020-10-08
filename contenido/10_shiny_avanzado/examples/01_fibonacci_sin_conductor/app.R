library(shiny)

# Función para calcular el enésimo número de la serie de fibonacci
fibonacci <- function(n) {
  if (n < 1) {
    return(NA)
  }
  if (n < 3) {
    return(1)
  }
  fibonacci(n - 1) + fibonacci(n - 2)
}


# La interfaz gráfica
ui <- fluidPage(
  
  # El título de la aplicación
  titlePanel("Serie de Fibonacci"),
  
  # Un panel que tiene una zona más pequeña en el lateral izquierdo,
  # y un panel principal más grande a la derecha
  sidebarLayout(
    
    # Usaremos el panel izquierdo para los inputs
    sidebarPanel(
      
      # Input de tipo slide
      numericInput(inputId   = "numero",
                   label     = h3("Número"),
                   value     = 10,
                   min       = 1,
                   max       = 30),

    ),
    
    # El panel principal con los outputs
    mainPanel(
      
      h4("Serie: ", textOutput(outputId = "serie")),
      h4("Suma: ",  textOutput(outputId = "suma")),
      h4("Media: ", textOutput(outputId = "media")),
      
    )
  )
)

# El servidor
server <- function(input, output) {
  
  # El conductor, que devuelve la serie.
  # Hay que encapsularlo dentro de una expresión en la función reactive
  serie <- reactive({
    sapply(1:input$numero, fibonacci)
  })
  
  # El output serie contiene toda la serie
  output$serie <- renderText({
    paste(serie(), collapse = ", ")
  })
  
  # El output suma contiene toda la suma de todos los valores de la serie
  output$suma <- renderText({
    sum(serie())
  })
  
  # El output media contiene toda la media de todos los valores de la serie
  output$media <- renderText({
    mean(serie())
  })
  
}

# Generamos la aplicación
shinyApp(ui = ui, server = server)
