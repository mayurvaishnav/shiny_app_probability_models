library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Distrubition of Random Variables"),
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
        numericInput("a", "Parameter a in Normal" , value = -2),
        numericInput("b", "Parameter b in Normal" , value = 0.8)
      ),

      conditionalPanel(
        condition = "input.model == 'normal'"
      ),

      conditionalPanel(
        condition = "input.model == 'exponential'"
      ),

      conditionalPanel(
        condition = "input.model == 'gamma'"
      ),

      conditionalPanel(
        condition = "input.model == 'chisquared'"
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
))