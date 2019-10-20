library(shiny)

shinyServer(
  function(input, output) {

    output$plot <- renderPlot({
      
      switch (input$model,
        'bernoulli' = {
          par(mfrow=c(1,2))
          Density <- density(rbinom(input$s,1,input$p))
          plot(Density, main="Kernel Density of generated data")
          polygon(Density, col="red", border="blue")
          x=0:1
          plot(x,dbinom(x,1,input$p))
        },

        'binomial' = {
          par(mfrow=c(1,2))
          d <- density(rbinom(input$s, input$n, input$p))
          plot(d, main="Kernel Density of generated data")
          polygon(d, col="red", border="blue")
          x=0:input$n
          plot(x,dbinom(x, input$n, input$p))
        }
      )
    })

    output$summary <- renderPrint({

      switch (input$model,
        'bernoulli' = {
          summary(rbinom(input$s, 1, input$p))
        },

        'binomial' = {
          summary(rbinom(input$s, input$n, input$p))
        }
      )
    })

    output$table <- renderTable({

      switch (input$model,
        'bernoulli' = {
          c(rbinom(input$s,1,input$p))
        },

        'binomial' = {
          c(rbinom(input$s, input$n,input$p))
        }
      )

    })
  }
)