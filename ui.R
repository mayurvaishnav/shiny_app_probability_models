library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Discrete Probability Models"),
  sidebarPanel(
    selectInput("model", "Select Model",
      choices = c(
        "Bernoulli" = "bernoulli",
        "Binomial" = "binomial",
        "Multinomial" = "multinomial",
        "Poisson" = "poisson",
        "Geometric" = "geometric",
        "Hypergeometric" = "hypergeometric"
      ),
      selected = "binomial"
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