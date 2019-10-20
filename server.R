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
        },

#        'multinomial' = {
#          par(mfrow=c(1,2))
#          d <- table(rmultinom(input$s, input$n, input$p))
#          barplot(d, col='red')
#          x=0:input$n
#          y=dmultinom(x, input$n, input$p)
#          plot(x,y, type='b')
#        },

        'poisson' = {
          par(mfrow=c(1,2))
          D=rpois(input$s, input$lam)
          tab=table(D)
          barplot(tab,col='blue')
          x1=0:input$max
          y1=dpois(x1,input$lam)
          plot(x1,y1,type='b')
        },

        'geometric' = {
          par(mfrow=c(1,2))
          D=rgeom(input$s, input$p)
          tab=table(D)
          barplot(tab,col='blue')
          x2=0:input$max
          y2=dgeom(x2,input$p)
          plot(x2,y2,type='b')
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
        },

#        'multinomial' = {
#          summary(rmultinom(input$s, input$n, input$p))
#        },

        'poisson' = {
          summary(rpois(input$s, input$lam))
        },

        'geometric' = {
          summary(rgeom(input$s, input$p))
        }
      )
    })

    output$table <- renderTable({

      switch (input$model,
        'bernoulli' = {
          c(rbinom(input$s,1,input$p))
        },

        'binomial' = {
          c(rbinom(input$s, input$n, input$p))
        },

#        'multinomial' = {
#          c(rmultinom(input$s, input$n, input$p))
#        },

        'poisson' = {
          c(rpois(input$s, input$lam))
        },

        'geometric' = {
          c(rgeom(input$s, input$p))
        }
      )

    })
  }
)