library(shiny)

shinyServer(
  function(input, output, session) {

    output$plot <- renderPlot({

      if(input$modelType == 'discrete') {
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
          },

          'hypergeometric' = {
            par(mfrow=c(1,2))
            D=rhyper(nn=input$s, m=input$m, n=input$n, k=rep(input$k, input$s))
            tab=table(D)
            barplot(tab,col='blue')
            x2=0:input$s
            y2=dhyper(x2, m=input$m, n=input$n, k=input$k, log=FALSE)
            plot(x2,y2,type='b')
          }
        )
      }

      if(input$modelType == 'continuous') {
        switch (input$modelCont,
          'uniform' = {
            a <- input$a
            b <- input$b
            n1 <- input$s
            rand.unif <- runif(n1, min = a, max = b)
            hist(rand.unif,
                 freq = FALSE,
                 xlab = 'x',
                 ylim = c(0, 0.4),
                 xlim = c(-3,3),
                 density = 20,
                 main = "Uniform distribution")
            curve(dunif(x, min = a, max = b),
                  from = -3, to = 3,
                  n = n1,
                  col = "darkblue",
                  lwd = 2,
                  add = TRUE,
                  yaxt = "n",
                  ylab = 'probability')
          },

          'normal' = {
            par(mfrow=c(1,2))
            x=seq(-input$i,input$i,0.01)
            plot(x,dnorm(x,input$mu,input$sigma),type='l', col='red')
          },

          'exponential' = {
            par(mfrow=c(1,2))
            x=seq(0,input$i,0.01)
            plot(x,dexp(x,input$lam),type='l',col='green')
          },

          'gamma' = {
            par(mfrow=c(1,2))
            x=seq(0,input$i,0.01)
            plot(x,dgamma(x,input$sigma,input$lam),type='l',col='blue')
          },

          'chisquared' = {
            par(mfrow=c(1,2))
            x=seq(0,input$i,0.01)
            plot(x,dchisq(x,input$k),type='l',col='black')
          }
        )
      }
    })

    output$summary <- renderPrint({

      if(input$modelType == 'discrete') {
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
          },

          'hypergeometric' = {
            summary(rhyper(nn=input$s, m=input$m, n=input$n, k=rep(input$k, input$s)))
          }
        )
      }

      if(input$modelType == 'continuous') {
        switch (input$modelCont,
          'uniform' = {
            summary(runif(input$s,input$a, input$b))
          },

          'normal' = {
            c(pnorm(input$s,input$mu, input$sigma))
            summary(rnorm(input$s,input$mu, input$sigma))
          },

          'exponential' = {
            c(pexp(input$s,input$lam))
            summary(rexp(input$s,input$lam))
          },

          'gamma' = {
            summary(rgamma(input$s,input$sigma,input$lam))
          },

          'chisquared' = {
            summary(rchisq(input$s,input$k))
          }
        )
      }
    })

    output$table <- renderTable({

      if(input$modelType == 'discrete') {
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
          },

          'hypergeometric' = {
            c(rhyper(nn=input$s, m=input$m, n=input$n, k=rep(input$k, input$s)))
          }
        )
      }

      if(input$modelType == 'continuous') {
        switch (input$modelCont,
          'uniform' = {
            c(runif(input$s,input$a, input$b))
          },

          'normal' = {
            c(rnorm(input$s,input$mu, input$sigma))
          },

          'exponential' = {
            c(rexp(input$s,input$lam))
          },

          'gamma' = {
            c(rgamma(input$s,input$sigma,input$lam))
          },

          'chisquared' = {
            c(rchisq(input$s,input$k))
          }
        )
      }
    })

    myData <- reactive({
      file1 <- input$datafile

      if (is.null(file1)) {
        return()
      }

      data = read.csv(file=file1$datapath)
      data

    })

    observe({
      updateSelectInput(session, inputId = "pred_columns", choices = colnames(myData()))
    })

    output$extdata = DT::renderDataTable({
      extdata <- myData()
      DT::datatable(extdata, options = list(lengthChange = TRUE))
    })


    output$prediction <- renderPrint({

         print(paste('Selected Column : ',input$pred_columns))
         df <- myData()
         x <- df[,input$pred_columns]

      switch (input$predmodel,
        'bernoulli' = {
        },

        'binomial' = {
        },

       'multinomial' = {
       },

        'poisson' = {
        },

        'geometric' = {
        },

        'hypergeometric' = {
        },

        'uniform' = {
        },

        'normal' = {
          print(paste('Predicted Value : ', mean(rnorm(input$s,mean(x), sd(x)))))
        },

        'exponential' = {
          print(paste('Predicted Value : ', mean(rexp(input$s,1/mean(x)))))
        },

        'gamma' = {
        },

        'chisquared' = {
        }
      )
    })
  }
)
