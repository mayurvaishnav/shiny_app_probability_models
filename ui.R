library(shiny)
library(markdown)

# shinyUI(pageWithSidebar(
  navbarPage("Home",
    tabPanel("Random  Variable",
      headerPanel("Distrubition of Random Variables"),
      sidebarLayout(
        sidebarPanel(
          radioButtons("modelType", "Type:",
                       choices = c(
                         "Discrete" = "discrete",
                         "Continuous" = "continuous"
                       ),
                       selected = 'discrete',
                       inline = 'true'
          ),

          # Model Input according to Model Type
          conditionalPanel(
            condition = "input.modelType == 'discrete'",

            selectInput("model", "Select Model",
                        choices = c(
                          "Bernoulli" = "bernoulli",
                          "Binomial" = "binomial",
                          "Multinomial" = "multinomial",
                          "Poisson" = "poisson",
                          "Geometric" = "geometric",
                          "Hypergeometric" = "hypergeometric"
                        ),
                        selected = "bernoulli"
            ),

            sliderInput("s", "Number of simulated data(s)", min=1, max=1000, value = 10),

            conditionalPanel(
              condition = "input.model == 'bernoulli'",
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            conditionalPanel(
              condition = "input.model == 'binomial'",
              numericInput("n", "Number of trails(n)", value = 10),
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            #      conditionalPanel(
            #        condition = "input.model == 'multinomial'",
            #        numericInput("n", "Number of trails(n)", value = 10),
            #        sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            #      ),

            conditionalPanel(
              condition = "input.model == 'poisson'",
              numericInput("max", "Upper limit for x" , value = 5),
              numericInput("lam", "Parameter lambda in Poisson", value = 10)
            ),

            conditionalPanel(
              condition = "input.model == 'geometric'",
              numericInput("max", "Upper limit for x" , value = 5),
              sliderInput("p", "Probability of successful trail(p)", min=0, max=1, step = 0.01, value = 0.5)
            ),

            conditionalPanel(
              condition = "input.model == 'hypergeometric'",
              numericInput("m", "M" , value = 10),
              numericInput("n", "N" , value = 20),
              numericInput("k", "K" , value = 5)
            )

          ),

          conditionalPanel(
            condition = "input.modelType == 'continuous'",

            selectInput("modelCont", "Select Model",
                        choices = c(
                          "Uniform" = "uniform",
                          "Normal" = "normal",
                          "Exponential" = "exponential",
                          "Gamma" = "gamma",
                          "Chi-squared" = "chisquared"
                        ),
                        selected = "uniform"
            ),

            sliderInput("s", "Number of simulated data" ,min=1, max=1000, value = 10),
            numericInput("i", "Support" , value = 2),

            conditionalPanel(
              condition = "input.modelCont == 'uniform'",
              numericInput("a", "Parameter a in Uniform" , value = -2),
              numericInput("b", "Parameter b in Uniform" , value = 0.8)
            ),

            conditionalPanel(
              condition = "input.modelCont == 'normal'",
              numericInput("mu", "Parameter mu in Normal" , value = 0),
              numericInput("sigma", "Parameter sigma in Normal" , value = 1)
            ),

            conditionalPanel(
              condition = "input.modelCont == 'exponential'",
              numericInput("lam", "Parameter lambda in exponential" , value = 1)
            ),

            conditionalPanel(
              condition = "input.modelCont == 'gamma'",
              numericInput("sigma", "Parameter sigma in Gamma" , value = 1),
              numericInput("lam", "Parameter lambda in Gamma" , value = 1)
            ),

            conditionalPanel(
              condition = "input.modelCont == 'chisquared'",
              numericInput("k", "Parameter K in Gamma" , value = 1)
            )
          )
        ),
        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Plot", plotOutput("plot")),
                      tabPanel("Summary", verbatimTextOutput("summary")),
                      tabPanel("Table", tableOutput("table"))
          )
        )
      )
    ),

    tabPanel("Prediction",
      headerPanel("Prediction next value"),
      sidebarLayout(
        sidebarPanel(
          selectInput("predmodel", "Select Model",
                      choices = c(
                                  "Bernoulli" = "bernoulli",
                                  "Binomial" = "binomial",
                                  "Multinomial" = "multinomial",
                                  "Poisson" = "poisson",
                                  "Geometric" = "geometric",
                                  "Hypergeometric" = "hypergeometric",
                                  "Uniform" = "uniform",
                                  "Normal" = "normal",
                                  "Exponential" = "exponential",
                                  "Gamma" = "gamma",
                                  "Chi-squared" = "chisquared"
                                ),
                      selected = "bernoulli"
          ),

          # Input: Select a file ----

          fileInput("datafile", "Choose CSV File",
                    multiple = FALSE,
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv")),

          selectInput(inputId = "pred_columns", label = "Select a Column", choices = ""),

          sliderInput("s", "Number of simulated data" ,min=1, max=1000, value = 100),

          conditionalPanel(
            condition = "input.conmodel == 'uniform'"
          )
        ),

        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Data", DT::dataTableOutput('extdata')),
                      tabPanel("Prediction", verbatimTextOutput("prediction"))
          )
        )
      )
    )
  )
# ))
