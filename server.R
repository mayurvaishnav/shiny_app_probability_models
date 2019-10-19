library(shiny)

shinyServer(
  function(input, output) {

    output$plot <- renderPlot({
      
    })

    output$summary <- renderText({
      
    })

    output$table <- renderTable({
      
    })
  }
)